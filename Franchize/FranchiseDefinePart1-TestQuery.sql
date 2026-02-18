

--DISABLE Trigers :
--************************************************************************************** khouroshstoredb
USE POS
GO
DISABLE TRIGGER Tr_CheckStore ON pos.dbo.store
GO 
DISABLE TRIGGER Tr_Duplicatescode ON pos.dbo.store
GO 

--USE Anbar
--GO
--DISABLE TRIGGER Tr_CheckAanbar ON Anbar.dbo.aanbar
--GO


--**************************************************************************************** khorooshdb
--USE Accounting
--GO
--DISABLE TRIGGER [Tr_CheckCostcenter] ON Accounting.dbo.costcenter


USE Personnel
GO
DISABLE TRIGGER Tr_CheckDeparteman_CodeMarkaz ON Personnel.dbo.Departeman
GO

--**********************************************************************
SELECT  * FROM OKMasterData..mdRegionSub where mdRegionSN = 16.199


--**************************************************************************************
--**************************************************************************************
--**************************************************************************************
--**************************************************************************************
--**************************************************************************************
-- central
SET XACT_ABORT ON
USE OKPlan
GO
-----------------------------------------------------------
-- ورودی‌ها
-----------------------------------------------------------


DECLARE @FranchiseStoreSN   DECIMAL(18,3) = 83438.474;
DECLARE @mdRegionSubSN  DECIMAL(18,3)  = 79;

-----------------------------------------------------------
-- متغیرهای داخلی SP
-----------------------------------------------------------
DECLARE @FranchiseContractSN DECIMAL(18,3);
DECLARE @StoreId DECIMAL(18,3);
DECLARE @CityId DECIMAL(18,3);
DECLARE @mdProvincePosSN DECIMAL(18,3);

--BEGIN TRY
--    BEGIN TRAN;

    ---------------------------------------------------------
    -- 0) دریافت StoreId و CityId
    ---------------------------------------------------------
    SELECT 
        @StoreId = StoreId,
        @CityId = CityId
    FROM KOUROSHSTOREDB.POS.dbo.Store
    WHERE StoreId = @FranchiseStoreSN;

    ---------------------------------------------------------
    -- 1) دریافت FranchiseContractSN
    ---------------------------------------------------------
    SELECT TOP 1 
           @FranchiseContractSN = FC.FranchiseContractSN
    FROM dbo.fcFranchiseStore FS
        INNER JOIN dbo.fcFranchiseContract FC
            ON FC.FranchiseStoreSN = FS.FranchiseStoreSN
        INNER JOIN dbo.fcFranchiseStoreVasighe FSV
            ON FSV.FranchiseContractSN = FC.FranchiseContractSN
        INNER JOIN dbo.fcFranchiseContractPerson FCP
            ON FCP.FranchiseContractSN = FC.FranchiseContractSN
    WHERE FS.FranchiseStoreSN = @FranchiseStoreSN
      AND FS.StoreID IS NULL
      AND FC.FranchiseContractTypeSN = 1;

    IF @FranchiseContractSN IS NULL
    BEGIN
        RAISERROR(N'هیچ FranchiseContractSN معتبر یافت نشد.', 16, 1);
        ROLLBACK TRAN;
        RETURN;
    END


    ---------------------------------------------------------
    -- 2) اجرای SP های داخلی (کاملاً مثل نسخه اصلی)
    ---------------------------------------------------------

    EXEC dbo.fcFranchiseStoreCheckingNotNullData 
         @FranchiseStoreSN = @FranchiseStoreSN;

    --EXEC dbo.fcFranchiseContractCheckingNotNullDataPrint 
    --     @FranchiseContractSN = @FranchiseContractSN;

    EXEC dbo.fcSPFranchiseStore_InsertEstate_toPAP 
         @FranchiseStoreSN = @FranchiseStoreSN;

    EXEC dbo.akspAmlak_FranchiseToAmlak  
         @FranchiseStoreSN = @FranchiseStoreSN,  
         @mdRegionSubSN = @mdRegionSubSN,
         @mdSectionSN = NULL;

    EXEC dbo.fcSPFranchiseStore_InsertContract_toPAP 
         @FranchiseContractSN = @FranchiseContractSN;

    EXEC dbo.fcSPFranchiseStore_InsertContractPerson_toPAP 
         @FranchiseContractSN = @FranchiseContractSN;

    EXEC dbo.fcSPFranchiseStore_InsertContractBand_toPAP 
         @FranchiseContractSN = @FranchiseContractSN;

    EXEC dbo.fcSPFranchiseStore_InsertStore_toPAP 
         @FranchiseStoreSN = @FranchiseStoreSN,
         @FranchiseContractSN = @FranchiseContractSN;

	SET @StoreId = (
    SELECT EntityPrimaryKey
    FROM fcFranchiseTransactionLog
    WHERE FranchiseStoreSN = 84183.474
      AND FranchiseTransactionLogSN = (
            SELECT MAX(FranchiseTransactionLogSN)
            FROM fcFranchiseTransactionLog
            WHERE FranchiseStoreSN = @FranchiseStoreSN
        )
);



    ---------------------------------------------------------
    -- 3) خروجی اول
    ---------------------------------------------------------
    SELECT
        S.StoreId,
        S.SName,
        S.RegionId,
        NULL AS ExtraColumn,
        S.StoreNumber,
        R.mdRegionSubDS,
        C.mdCityPosDS
    FROM KOUROSHSTOREDB.POS.dbo.Store S
    LEFT JOIN OKMasterData..mdRegionSub R
        ON R.mdRegionSubSN = @mdRegionSubSN
    LEFT JOIN OKMasterData..mdCityPos C
        ON C.mdCityPosSN = S.CityId
    WHERE S.StoreId = @StoreId;


    ---------------------------------------------------------
    -- 4) خروجی دوم (استان و املاک)
    ---------------------------------------------------------

    SELECT 
        @mdProvincePosSN = mdProvincePosSN
    FROM OKMasterData..mdCityPos
    WHERE mdCityPosSN = @CityId;


    SELECT
        S.SName,
        NULL AS ExtraColumn,
        S.StoreNumber,
        R.mdRegionSubDS,
        C.mdCityPosDS,
        P.mdProvincePosDS,
        A.akAmlakAddress,
        A.akAmlakPostalCode
    FROM KOUROSHSTOREDB.POS.dbo.Store S
    LEFT JOIN OKMasterData..mdRegionSub R
        ON R.mdRegionSubSN = @mdRegionSubSN
    LEFT JOIN OKMasterData..mdCityPos C
        ON C.mdCityPosSN = S.CityId
    LEFT JOIN OKMasterData..mdProvincePos P
        ON P.mdProvincePosSN = @mdProvincePosSN
    LEFT JOIN OKMali..akAmlak A
        ON A.akAmlakMovaledSN = @FranchiseStoreSN
    WHERE S.StoreId = @StoreId;





--    COMMIT TRAN;

--END TRY
--BEGIN CATCH
--    ROLLBACK TRAN;

--    DECLARE @ErrMsg NVARCHAR(4000) = ERROR_MESSAGE(),
--            @ErrLine INT = ERROR_LINE();

--    RAISERROR(N'خطا: %s (خط: %d)', 16, 1, @ErrMsg, @ErrLine);
--END CATCH;


     --EXEC dbo.fcSPFranchiseStore_InsertSectionId_toPAP 
    --     @FranchiseStoreSN = @FranchiseStoreSN,
    --     @FranchiseContractSN = @FranchiseContractSN,
    --     @mdRegionSubSN = @mdRegionSubSN;
CREATE TABLE #temptable ( [FranchiseStoreSabtRegion] nvarchar(50), [FranchiseStoreSN] decimal(18,3), [FranchiseContractSN] decimal(18,3), [mdDepSN_Parent] bigint, [RegionId] decimal(18,3), [FranchiseContractTypeSN] tinyint, [StoreID] decimal(18,3), [FranchiseStoreSN] decimal(18,3), [FranchiseStoreStatus] int, [FranchiseStoreIsHaghighi] bit, [RegionId] decimal(18,3), [StoreID] decimal(18,3), [FranchiseStoreDS] nvarchar(200), [BPMServiceWorkFlowRunLogDesc] nvarchar(200), [FranchiseStoreMalekName] nvarchar(150), [FranchiseStoreMalekFamili] nvarchar(250), [MadrakId] int, [FranchiseStoreMalekTel] nvarchar(150), [FranchiseStoreMalekMobali] nvarchar(150), [Cityid] decimal(18,3), [FranchiseStoreMohalTypeSN] int, [FranchiseStoreMohalAddres] nvarchar(2000), [FranchiseStoreMalekeyatTypeSN] int, [FranchiseStoreUseTypeSN] int, [FranchiseStoreParvanehKasbTypeSN] int, [FranchiseStoreMasahat] decimal(18,2), [FranchiseStoreBar] decimal(18,2), [FranchiseStoreIsAnbar] bit, [FranchiseStoreIsBalkon] bit, [FranchiseStoreIsParking] bit, [FranchiseStoreEjareh] bigint, [FranchiseStoreVasighehMablagh] money, [PersonelId_Sarparast] decimal(18,3), [StoreOpeningDarkhastSN] decimal(18,3), [FranchiseStoreSabtDate] nvarchar(10), [FranchiseStoreTafsiliCode] int, [FranchiseStoreVasighehTypeSN] decimal(18,3), [UserID_Name] nvarchar(500), [Host_Name] nvarchar(500), [TimeStamp] varbinary(8), [SiteID] int, [FranchiseStoreMalekAccNo] nvarchar(30), [FranchiseStoreEtebarZemanatnamehDate] nvarchar(10), [FranchiseStoreBazdidDate] nvarchar(10), [FranchiseStoreRejectReasonSN] decimal(18,3), [FranchiseStoreOpeningDate] nvarchar(10), [FranchiseStoreBalconArea] float(8), [FranchiseStoreBasementArea] float(8), [FranchiseStoreMainPelak] varchar(20), [FranchiseStoreSecondaryPelak] varchar(20), [FranchiseStoreSabtRegion] nvarchar(50), [FranchiseStorePostalCode] nvarchar(20), [OKCSRahgiriNO] varchar(20), [EstateId] decimal(18,3), [EstateCode] varchar(20), [FranchiseStoreDistrict] nvarchar(50), [FranchiseStorePriority] int, [FranchiseStoreIsMainStreet] int, [FranchiseStoreTedadBar] tinyint, [FranchiseStoreLength] decimal(6,2), [FranchiseStoreWidth] decimal(6,2), [FranchiseStoreHeight] decimal(6,2), [FranchiseStoreSanadNo] varchar(500), [FranchiseStoreSanaddate] varchar(10), [FranchiseStoreShahrdariRegion] int, [FranchiseStorePowerSplit3Phase] int, [FranchiseStorePowerAmper] int, [FranchiseStoreKontorNo] varchar(20), [FranchiseStorePowerSplit] int, [FranchiseStoreLineSplit] int, [FranchiseStoreGasSplit] int, [FranchiseStoreGasPercent] money, [FranchiseStoreWaterSplit] int, [FranchiseStoreWaterPercent] money, [FranchiseStoreShutter] bit, [FranchiseStoreAutoDoor] bit, [FranchiseStoreCooling] bit, [FranchiseStoreHeating] bit, [FranchiseStoreEarthing] bit, [CostCenter] varchar(10), [FranchiseStoreEskelet] tinyint, [FranchiseStoreFromNorth] tinyint, [FranchiseStoreFromSouth] tinyint, [FranchiseStoreFromEast] tinyint, [FranchiseStoreFromWest] tinyint, [Latitude] decimal(18,10), [Longitude] decimal(18,10), [FranchiseStoreLightingCount] tinyint, [FranchiseStoreIsLEDLighting] bit, [FranchiseStoreLightWatt] int, [FranchiseStoreIsInlineWiring] bit, [HotWaterTypeID] decimal(18,3), [SectionId] int, [FranchiseStoreNo_Kargah] varchar(15), [TafsiliNO] varchar(20), [FranchiseStoreRahnPrice] bigint, [KilometerDistance] int, [mdInventLocationAXSN] bigint, [FranchiseContractSN] decimal(18,3), [FranchiseStoreSN] decimal(18,3), [FranchiseContractStatus] tinyint, [FranchiseContractTypeSN] tinyint, [FranchiseContractNo] varchar(20), [FranchiseContractSabtDate] varchar(10), [FranchiseContractStartDate] varchar(10), [FranchiseContractDesc] nvarchar(4000), [FranchiseContractPersonnelCount] int, [FranchiseContractCancellationMonth] money, [FranchiseContractEquipmentIsPayed] bit, [FranchiseContractEquipmetnTime] varchar(5), [FranchiseContractTaahodJarimeh] bigint, [FranchiseContractAghdDate] varchar(10), [FranchiseContractGUID] uniqueidentifier, [UserID_Name] varchar(100), [Host_Name] varchar(100), [TimeStamp] varbinary(8), [IUserID] int, [IDate] varchar(10), [UUserID] int, [UDate] varchar(10), [FranchiseContractDS] nvarchar(150), [FranchiseContractTashilatMoney] decimal(18,0), [FranchiseContractRentMasahat] decimal(5,2), [FranchiseContractRentEjare] decimal(10,0), [FranchiseContractRentRahnAmount] decimal(10,0), [FranchiseContractRentAddedPercent] decimal(5,2), [FranchiseContractDuration] tinyint, [TarafeSanadID] decimal(18,3), [ContractID] decimal(18,3), [FranchiseContracPishbiniSale] decimal(18,0), [FranchisePeyvastPath] nvarchar(500), [BorrowerName] nvarchar(50), [LoanAccountNo] nvarchar(50), [LoanBankName] nvarchar(50), [LoanBankBranch] nvarchar(50), [FranchiseContractIsOfoghTajhiz] bit, [BPMServiceWorkFlowRunLogDesc] nvarchar(500), [FranchiseContractReferentialStatus] tinyint, [FranchiseContractSN_Ref] decimal(18,3), [FranchiseContractCommiter] int, [FranchiseContractAirDistance] decimal(12,3), [FranchiseContractSalesCommitment6] decimal(18,0), [FranchiseContractSalesCommitment12] decimal(18,0), [FranchiseContractTashilatType] tinyint, [FranchiseContractMablaghGharardadTajhiz] bigint, [FranchiseContractTedadGhestGharardadTajhiz] int, [mdDepSN_Parent] bigint, [FranchiseContractSalesOpening] bigint, [FranchiseContractVasigheSN] decimal(18,3), [FranchiseStoreVasigheDS] nvarchar(500), [FranchiseStoreVasigheNO] int, [FranchiseStoreVasighehTypeSN] decimal(18,3), [FranchiseStoreVasighePrice] bigint, [FranchiseStoreVasigheMelkiAddress] nvarchar(200), [FranchiseStoreVasigheBankiShobe] nvarchar(50), [FranchiseStoreVasigheEtebarDate] nvarchar(50), [FranchiseStoreVasigheStatus] tinyint, [FranchiseContractSN] decimal(18,3), [FranchiseStoreVasighePelak] nvarchar(50), [FranchiseStoreVasigheMalek] nvarchar(100), [FranchiseStoreVasigheGharardadRahnNO] nvarchar(50), [FranchiseStoreVasigheDate] nvarchar(10), [FranchiseStoreVasigheDaftarkhaneNO] nvarchar(50), [BankID] decimal(18,3), [CityId] decimal(18,3), [IDate] varchar(10), [IUserID] int, [UDate] varchar(10), [UUserID] int, [UserID_Name] nvarchar(50), [Host_Name] nvarchar(100), [TimeStamp] varbinary(8), [FranchiseContractPersonSN] decimal(18,3), [FranchiseContractSN] decimal(18,3), [FranchiseContractPersonStatus] int, [FranchiseContractPersonSabtDate] varchar(10), [FranchiseContractPersonFName] nvarchar(50), [FranchiseContractPersonLName] nvarchar(50), [FranchiseContractPersonFatherName] nvarchar(50), [FranchiseContractPersonBirthDate] varchar(10), [CityID] decimal(18,3), [CityIDSodoor] decimal(18,3), [FranchiseContractPersonIDNo] varchar(10), [FranchiseContractPersonNationalID] varchar(10), [FranchiseContractPersonIsMale] bit, [FranchiseContractPersonPostalCode] varchar(10), [FranchiseContractPersonAddress] varchar(300), [FranchiseContractPersonPhoneNo] varchar(20), [FranchiseContractPersonMobileNo] varchar(20), [FranchiseContractPersonFax] varchar(20), [FranchiseContractPersonEmailAddress] varchar(20), [BankID] decimal(18,3), [FranchiseContractPersonAccNo] nvarchar(30), [FranchiseContractPersonAccShobe] nvarchar(30), [FranchiseContractPersonSharePercent] decimal(5,2), [UserID_Name] varchar(100), [Host_Name] varchar(100), [TimeStamp] varbinary(8), [OwnerID] decimal(18,3), [FranchiseContractPersonIsHoghoghi] bit, [TafsiliNO] varchar(10), [CompanyType] decimal(18,3), [FranchiseContractPersonModirName] nvarchar(150), [FranchiseContractPersonSahebEmza] nvarchar(500), [FranchiseContractPersonCodeBoorsi] varchar(100), [FranchiseContractPersonEconomicalId] varchar(11) )
INSERT INTO #temptable ([FranchiseStoreSabtRegion], [FranchiseStoreSN], [FranchiseContractSN], [mdDepSN_Parent], [RegionId], [FranchiseContractTypeSN], [StoreID], [FranchiseStoreSN], [FranchiseStoreStatus], [FranchiseStoreIsHaghighi], [RegionId], [StoreID], [FranchiseStoreDS], [BPMServiceWorkFlowRunLogDesc], [FranchiseStoreMalekName], [FranchiseStoreMalekFamili], [MadrakId], [FranchiseStoreMalekTel], [FranchiseStoreMalekMobali], [Cityid], [FranchiseStoreMohalTypeSN], [FranchiseStoreMohalAddres], [FranchiseStoreMalekeyatTypeSN], [FranchiseStoreUseTypeSN], [FranchiseStoreParvanehKasbTypeSN], [FranchiseStoreMasahat], [FranchiseStoreBar], [FranchiseStoreIsAnbar], [FranchiseStoreIsBalkon], [FranchiseStoreIsParking], [FranchiseStoreEjareh], [FranchiseStoreVasighehMablagh], [PersonelId_Sarparast], [StoreOpeningDarkhastSN], [FranchiseStoreSabtDate], [FranchiseStoreTafsiliCode], [FranchiseStoreVasighehTypeSN], [UserID_Name], [Host_Name], [TimeStamp], [SiteID], [FranchiseStoreMalekAccNo], [FranchiseStoreEtebarZemanatnamehDate], [FranchiseStoreBazdidDate], [FranchiseStoreRejectReasonSN], [FranchiseStoreOpeningDate], [FranchiseStoreBalconArea], [FranchiseStoreBasementArea], [FranchiseStoreMainPelak], [FranchiseStoreSecondaryPelak], [FranchiseStoreSabtRegion], [FranchiseStorePostalCode], [OKCSRahgiriNO], [EstateId], [EstateCode], [FranchiseStoreDistrict], [FranchiseStorePriority], [FranchiseStoreIsMainStreet], [FranchiseStoreTedadBar], [FranchiseStoreLength], [FranchiseStoreWidth], [FranchiseStoreHeight], [FranchiseStoreSanadNo], [FranchiseStoreSanaddate], [FranchiseStoreShahrdariRegion], [FranchiseStorePowerSplit3Phase], [FranchiseStorePowerAmper], [FranchiseStoreKontorNo], [FranchiseStorePowerSplit], [FranchiseStoreLineSplit], [FranchiseStoreGasSplit], [FranchiseStoreGasPercent], [FranchiseStoreWaterSplit], [FranchiseStoreWaterPercent], [FranchiseStoreShutter], [FranchiseStoreAutoDoor], [FranchiseStoreCooling], [FranchiseStoreHeating], [FranchiseStoreEarthing], [CostCenter], [FranchiseStoreEskelet], [FranchiseStoreFromNorth], [FranchiseStoreFromSouth], [FranchiseStoreFromEast], [FranchiseStoreFromWest], [Latitude], [Longitude], [FranchiseStoreLightingCount], [FranchiseStoreIsLEDLighting], [FranchiseStoreLightWatt], [FranchiseStoreIsInlineWiring], [HotWaterTypeID], [SectionId], [FranchiseStoreNo_Kargah], [TafsiliNO], [FranchiseStoreRahnPrice], [KilometerDistance], [mdInventLocationAXSN], [FranchiseContractSN], [FranchiseStoreSN], [FranchiseContractStatus], [FranchiseContractTypeSN], [FranchiseContractNo], [FranchiseContractSabtDate], [FranchiseContractStartDate], [FranchiseContractDesc], [FranchiseContractPersonnelCount], [FranchiseContractCancellationMonth], [FranchiseContractEquipmentIsPayed], [FranchiseContractEquipmetnTime], [FranchiseContractTaahodJarimeh], [FranchiseContractAghdDate], [FranchiseContractGUID], [UserID_Name], [Host_Name], [TimeStamp], [IUserID], [IDate], [UUserID], [UDate], [FranchiseContractDS], [FranchiseContractTashilatMoney], [FranchiseContractRentMasahat], [FranchiseContractRentEjare], [FranchiseContractRentRahnAmount], [FranchiseContractRentAddedPercent], [FranchiseContractDuration], [TarafeSanadID], [ContractID], [FranchiseContracPishbiniSale], [FranchisePeyvastPath], [BorrowerName], [LoanAccountNo], [LoanBankName], [LoanBankBranch], [FranchiseContractIsOfoghTajhiz], [BPMServiceWorkFlowRunLogDesc], [FranchiseContractReferentialStatus], [FranchiseContractSN_Ref], [FranchiseContractCommiter], [FranchiseContractAirDistance], [FranchiseContractSalesCommitment6], [FranchiseContractSalesCommitment12], [FranchiseContractTashilatType], [FranchiseContractMablaghGharardadTajhiz], [FranchiseContractTedadGhestGharardadTajhiz], [mdDepSN_Parent], [FranchiseContractSalesOpening], [FranchiseContractVasigheSN], [FranchiseStoreVasigheDS], [FranchiseStoreVasigheNO], [FranchiseStoreVasighehTypeSN], [FranchiseStoreVasighePrice], [FranchiseStoreVasigheMelkiAddress], [FranchiseStoreVasigheBankiShobe], [FranchiseStoreVasigheEtebarDate], [FranchiseStoreVasigheStatus], [FranchiseContractSN], [FranchiseStoreVasighePelak], [FranchiseStoreVasigheMalek], [FranchiseStoreVasigheGharardadRahnNO], [FranchiseStoreVasigheDate], [FranchiseStoreVasigheDaftarkhaneNO], [BankID], [CityId], [IDate], [IUserID], [UDate], [UUserID], [UserID_Name], [Host_Name], [TimeStamp], [FranchiseContractPersonSN], [FranchiseContractSN], [FranchiseContractPersonStatus], [FranchiseContractPersonSabtDate], [FranchiseContractPersonFName], [FranchiseContractPersonLName], [FranchiseContractPersonFatherName], [FranchiseContractPersonBirthDate], [CityID], [CityIDSodoor], [FranchiseContractPersonIDNo], [FranchiseContractPersonNationalID], [FranchiseContractPersonIsMale], [FranchiseContractPersonPostalCode], [FranchiseContractPersonAddress], [FranchiseContractPersonPhoneNo], [FranchiseContractPersonMobileNo], [FranchiseContractPersonFax], [FranchiseContractPersonEmailAddress], [BankID], [FranchiseContractPersonAccNo], [FranchiseContractPersonAccShobe], [FranchiseContractPersonSharePercent], [UserID_Name], [Host_Name], [TimeStamp], [OwnerID], [FranchiseContractPersonIsHoghoghi], [TafsiliNO], [CompanyType], [FranchiseContractPersonModirName], [FranchiseContractPersonSahebEmza], [FranchiseContractPersonCodeBoorsi], [FranchiseContractPersonEconomicalId])
VALUES
( N'10', 83913.474, 117288.474, 7877, 8.199, 1, NULL, 83913.474, 50, 0, 8.199, NULL, NULL, NULL, N'نفيسه', N'ميرزابيگي', 0, N'', N'09357325818', 1101.301, 3, N'بلوار صیادشیرازی، صیادشیرازی 24، ساختمان سینا 36', 2, 1, 1, 100.00, 6.00, 0, 1, 0, 1250000000, NULL, NULL, NULL, N'14040908', NULL, NULL, NULL, N'10.192.30.11_OKDC20124', 0x00000007a9e77a06, 85767, NULL, NULL, NULL, NULL, NULL, 35, 0, '184', '8787', N'10', N'9179136173', '1404090809231385767', NULL, '10124', N'صیادشیرازی 24', 0, 0, 1, 0.00, 0.00, 0.00, '405519', '14020130', 9, 1, 32, '0', 0, 1, 1, 100.0000, 1, 100.0000, 1, 1, 1, 1, 1, NULL, 1, 1, 3, 1, 2, 0.0000000000, 0.0000000000, 10, 1, 50, 1, 2.101, NULL, NULL, NULL, 7000000000, NULL, NULL, 117288.474, 83913.474, 0, 1, NULL, '14040911', '14041001', NULL, 3, NULL, NULL, NULL, NULL, '14040925', '{869bd77b-58cf-f011-8c17-005056b7ac7b}', NULL, '10.192.30.11_OKDC20124', 0x00000007a9e77e0f, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 60, 182.101, NULL, 800000000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 805081, NULL, 800000000, 900000000, NULL, 0, 0, 7877, 1500000000, 11932.474, NULL, NULL, 2.474, NULL, N'مشهد، پیروزی 79، دوستکام 17 پلاک 54 واحد 1', NULL, NULL, 0, 117288.474, N'27814 فرعی از 182 اصلی مفروز مجزی شده از 14062', N'حیدر و سیمین میرزابیگی', NULL, N'14040915', N'337', NULL, 1101.301, NULL, NULL, NULL, NULL, N'7946_عرفاني سقاباشي اميررضا', N'10.192.30.11_OKDC20124', 0x00000007a9e77b64, 13408.474, 117288.474, 0, '14040911', N'نفیسه', N'میرزابیگی', N'حیدر', '13740520', 2904.301, 2904.301, '0690532679', '0690532679', 0, '9179616599', 'مشهد، بلوار وکيل آباد، اقبال لاهوري 14.4 پلاک 7', '09357325818', '09357325818', NULL, NULL, 4.199, N'IR400560930580002759147001', N'بلوار هاشمیه مشهد', 100.00, '7946_عرفاني سقاباشي اميررضا', '10.192.30.11_OKDC20124', 0x00000007a9e77db6, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL )

DROP TABLE #temptable


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


SELECT  * FROM OKMasterData..mdRegionSub where mdRegionSN = 8.199



--************************************************************************************** central
SET XACT_ABORT ON
USE OKPlan
GO
-----------------------------------------------------------
-- ورودی‌ها
-----------------------------------------------------------


DECLARE @FranchiseStoreSN   DECIMAL(18,3) = 84183.474;
DECLARE @mdRegionSubSN  DECIMAL(18,3)  = 10;

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

    EXEC dbo.fcSPFranchiseStore_InsertSectionId_toPAP 
         @FranchiseStoreSN = @FranchiseStoreSN,
         @FranchiseContractSN = @FranchiseContractSN,
         @mdRegionSubSN = @mdRegionSubSN;


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

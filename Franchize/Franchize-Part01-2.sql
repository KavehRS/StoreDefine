SET XACT_ABORT ON
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









--(SELECT  * FROM OKMasterData..mdRegionSub where mdRegionSN = 16.199 ), 



USE OKPlan
GO

DECLARE @mdRegionsubSN INT = 78; -- مقدار mdRegionsubSN را وارد کنید
DECLARE @FranchiseStoreSN DECIMAL(18,3) = 85670.474; -- مقدار FranchiseStoreSN را وارد کنید
DECLARE @FranchiseContractSN DECIMAL(18,3);

-- کوئری اصلی برای گرفتن FranchiseContractSN
SELECT 
    @FranchiseContractSN = FC.FranchiseContractSN
FROM dbo.fcFranchiseStore FS
    INNER JOIN dbo.fcFranchiseContract FC
        ON FC.FranchiseStoreSN = FS.FranchiseStoreSN
    INNER JOIN dbo.fcFranchiseStoreVasighe FSV
        ON FSV.FranchiseContractSN = FC.FranchiseContractSN
    INNER JOIN dbo.fcFranchiseContractPerson FCP
        ON FCP.FranchiseContractSN = FC.FranchiseContractSN
WHERE      
    FS.FranchiseStoreSN = @FranchiseStoreSN AND
    FS.StoreID IS NULL AND
    FC.FranchiseContractTypeSN = 1;

-- بررسی خروجی
IF @FranchiseContractSN IS NULL
BEGIN
    PRINT 'فروشگاه تکراری است';
END
ELSE
BEGIN
    -- اجرای کوئری‌ها به ترتیب
    EXEC dbo.fcFranchiseStoreCheckingNotNullData @FranchiseStoreSN = @FranchiseStoreSN;
    EXEC dbo.fcFranchiseContractCheckingNotNullDataPrint @FranchiseContractSN = @FranchiseContractSN;
    EXEC fcSPFranchiseStore_InsertEstate_toPAP @FranchiseStoreSN = @FranchiseStoreSN;
    EXEC dbo.akspAmlak_FranchiseToAmlak @FranchiseStoreSN = @FranchiseStoreSN, @mdRegionsubSN = @mdRegionsubSN, @mdSectionsn = NULL;
    EXEC dbo.fcSPFranchiseStore_InsertContract_toPAP @FranchiseContractSN = @FranchiseContractSN;
    EXEC dbo.fcSPFranchiseStore_InsertContractPerson_toPAP @FranchiseContractSN = @FranchiseContractSN;
    EXEC dbo.fcSPFranchiseStore_InsertContractBand_toPAP @FranchiseContractSN = @FranchiseContractSN;
    EXEC dbo.fcSPFranchiseStore_InsertStore_toPAP @FranchiseStoreSN = @FranchiseStoreSN, @FranchiseContractSN = @FranchiseContractSN;
    EXEC fcSPFranchiseStore_InsertSectionId_toPAP @FranchiseStoreSN = @FranchiseStoreSN, @FranchiseContractSN = @FranchiseContractSN, @mdRegionsubSN = @mdRegionsubSN;
    
    -- نمایش مقادیر
    PRINT 'پارامترهای استفاده شده:';
    PRINT 'mdRegionsubSN: ' + CAST(@mdRegionsubSN AS VARCHAR(10));
    PRINT 'FranchiseStoreSN: ' + CAST(@FranchiseStoreSN AS VARCHAR(50));
    PRINT 'FranchiseContractSN: ' + CAST(@FranchiseContractSN AS VARCHAR(50));
    PRINT 'StoreId: ' + CAST(@FranchiseContractSN AS VARCHAR(50));
END




 ////////////////////////////////////////////////////////////////////////////////////





-- EXEC fcSPFranchiseStore_InsertSectionId_toPAP @FranchiseStoreSN =     85670.474   ,	@FranchiseContractSN = 118000.474,   @mdRegionsubSN = 72



SELECT * FROM fcFranchiseTransactionLog WHERE FranchiseStoreSN =   85670.474   


SELECT 
    a.SName,
    CONVERT(INT, a.RegionId) AS RegionId_Int,
    CASE 
        WHEN ISNULL(c.AxReg, 0) = 0 THEN CONVERT(INT, a.RegionId)
        ELSE CONVERT(INT, c.AxReg)
    END AS AxReg_Result_Int,
    a.StoreNumber
FROM KOUROSHSTOREDB.POS.dbo.Store a
FULL OUTER JOIN OKMasterData..mdcitypos b
    ON a.CityId = b.mdCityPosSN
FULL OUTER JOIN OKMasterData..mdDynamicsAXRegions c
    ON b.mdProvincePosSN = c.mdProvincePosSN
WHERE a.StoreId = '9580.199'



SELECT
am.akAmlakDS,NULL,NULL,d.mdDistrictDS,c.mdCityPosDS,p.mdProvincePosDS,am.akAmlakAddress,am.akAmlakPostalCode
 FROM      OKMali..akAmlak am
 FULL OUTER JOIN OKMasterData..mddistrict d
 ON am.mdRegionsubSN = d.mdRegionsubSN
  FULL OUTER JOIN OKMasterData..mdcityPOS c
  ON am.mdCitySN = c.mdCityPOsSN
  FULL OUTER JOIN OKMasterData..mdProvincePos p
  ON c.mdProvincePosSN = p.mdProvincePosSN
WHERE  am.akAmlakMovaledSN =  85670.474 ;




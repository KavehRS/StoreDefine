

--DISABLE Trigers :
--************************************************************************************** khouroshstoredb
USE POS
GO
DISABLE TRIGGER Tr_CheckStore ON pos.dbo.store
GO 
DISABLE TRIGGER Tr_Duplicatescode ON pos.dbo.store
GO 


--**************************************************************************************** khorooshdb

USE Personnel
GO
DISABLE TRIGGER Tr_CheckDeparteman_CodeMarkaz ON Personnel.dbo.Departeman
GO



--****************************************************************************centralwh----USE OKPlan
SELECT  * FROM OKMasterData..mdRegionSub where mdRegionSN = 16.199

DECLARE 
    @FranchiseStoreSN decimal(18,3) = 81292.474, 
    @FranchiseContractSN decimal(18,3),
    @mdRegionsubSN int = 70,
    @StoreId nvarchar(100);

USE OKPlan;

-- گرفتن FranchiseContractSN
SELECT TOP 1
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

-- گرفتن StoreId داینامیک
SELECT TOP 1 
    @StoreId = CAST(StoreID AS nvarchar(100))
FROM dbo.fcFranchiseStore
WHERE FranchiseStoreSN = @FranchiseStoreSN;

SET XACT_ABORT ON;
BEGIN TRY
    BEGIN TRANSACTION;

    EXEC dbo.fcFranchiseStoreCheckingNotNullData @FranchiseStoreSN = @FranchiseStoreSN;

    -- نادیده گرفتن خطا یا وارنینگ این EXEC
    BEGIN TRY
        EXEC dbo.fcFranchiseContractCheckingNotNullDataPrint @FranchiseContractSN = @FranchiseContractSN;
    END TRY
    BEGIN CATCH
        -- نادیده گرفتن خطا و ادامه اجرا
    END CATCH

    EXEC dbo.fcSPFranchiseStore_InsertEstate_toPAP @FranchiseStoreSN = @FranchiseStoreSN;
    EXEC dbo.akspAmlak_FranchiseToAmlak @FranchiseStoreSN = @FranchiseStoreSN, @mdRegionsubSN = @mdRegionsubSN, @mdSectionsn = NULL;
    EXEC dbo.fcSPFranchiseStore_InsertContract_toPAP @FranchiseContractSN = @FranchiseContractSN;
    EXEC dbo.fcSPFranchiseStore_InsertContractPerson_toPAP @FranchiseContractSN = @FranchiseContractSN;
    EXEC dbo.fcSPFranchiseStore_InsertContractBand_toPAP @FranchiseContractSN = @FranchiseContractSN;
    EXEC dbo.fcSPFranchiseStore_InsertStore_toPAP @FranchiseStoreSN = @FranchiseStoreSN, @FranchiseContractSN = @FranchiseContractSN;
    EXEC dbo.fcSPFranchiseStore_InsertSectionId_toPAP @FranchiseStoreSN = @FranchiseStoreSN, @FranchiseContractSN = @FranchiseContractSN, @mdRegionsubSN = @mdRegionsubSN;

    -- لاگ با اصلاح EntityPrimaryKey برای Store
    SELECT 
        log.*,
        CASE 
            WHEN log.EntityName = N'Store' THEN CAST(store.StoreId AS NVARCHAR(100))
            ELSE log.EntityPrimaryKey
        END AS CorrectedEntityPrimaryKey
    FROM fcFranchiseTransactionLog log
    LEFT JOIN KOUROSHSTOREDB.POS.dbo.Store store
        ON log.EntityName = N'Store' AND store.StoreId = log.EntityPrimaryKey
    WHERE log.FranchiseStoreSN = @FranchiseStoreSN;

    -- استفاده داینامیک از StoreId
    SELECT RegionId, * 
    FROM KOUROSHSTOREDB.POS.dbo.Store 
    WHERE StoreId = @StoreId;

    SELECT * FROM OKMasterData..mddistrict WHERE mdDistrictDS LIKE N'%تهران%';
    SELECT * FROM OKMali..akAmlak WHERE akAmlakDS LIKE N'%فرانچا%ز اند%شه فاز% شاهد غرب%';

    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;
    THROW;
END CATCH;






SELECT  * FROM fcFranchiseTransactionLog WHERE FranchiseStoreSN = 81564.474 

SELECT RegionId,* FROM KOUROSHSTOREDB.POS.dbo.Store 
WHERE StoreId ='8726.199' 

SName , StoreNumber,


SELECT * FROM OKMasterData..mddistrict
WHERE mdDistrictDS LIKE N'%رمان%'  -- بخشی از نام دیستریکت را وارد میکنیم

SELECT * FROM      OKMali..akAmlak  
WHERE akAmlakDS  LIKE N'%فرانچا%ز رفسنجان خ%ابان حجت%'  -- بان فرانچایز با جایگزین کردن % به جای «ی» و «ک»
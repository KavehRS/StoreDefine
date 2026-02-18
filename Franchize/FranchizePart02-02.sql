










--- SELECT * FROM OKPlan..fcFranchiseTransactionLog WHERE FranchiseStoreSN =  85880.474 AND ErrorDS IS NULL



-- SELECT * FROM dbo.Owner -- 8646.199 -- 7121.199
-- WHERE OwnerID = 8646.199
 
--**********************************************Centralwh******OKMasterData

SELECT * FROM OKMasterData..mdRegionSub where mdRegionSN = 11.199  AND mdRegionSubDS LIKE '%Å—œ%'
SELECT * FROM OKMasterData..mddistrict WHERE mdDistrictDS LIKE '%Å—œ%'


--*********************************************Kouroshstoredb*****POS 
 SELECT * FROM KOUROSHSTOREDB.POS.dbo.Store-- 
WHERE StoreId ='9584.199'

--**********************************************Centralwh******okmasterdata

SELECT * FROM  okmasterdata.dbo.mdCostCenterAX
WHERE mdCostCenterAXValue  LIKE '%OKR11313%'

----gig-dc1-p451  ax
--SELECT KEY_, value FROM DimAttributeOMCostCenter WHERE value like N'OKR11219'




--**********************************************OKDC32013\NODE******OperationalDB
SELECT RECID,* FROM OperationalDB.ax.OMOPERATINGUNITENTITY
--WHERE NAME LIKE '%%'
WHERE OPERATINGUNITNUMBER LIKE '%OKR11313%'

/************************************************/


USE OKPlan;
GO
SET XACT_ABORT ON
-- Declare all input variables at the beginning
DECLARE @FranchiseStoreSN DECIMAL(18,3) = 85880.474;
DECLARE @FranchiseContractSN DECIMAL(18,3) = 117795.474;
DECLARE @mdRegionsubSN INT = 71;
DECLARE @Sectionid DECIMAL(18,3) = 7826.000;
DECLARE @mdcostcenteraxsn BIGINT = 5646240583;
DECLARE @mdDistrictSN INT = 65;
DECLARE @AXRECID BIGINT = 5637607993;

-- Execute stored procedures using the variables
EXEC dbo.fcSPFranchiseStore_InsertDepartment_toPAP
    @FranchiseStoreSN = @FranchiseStoreSN,
    @FranchiseContractSN = @FranchiseContractSN,
    @mdRegionsubSN = @mdRegionsubSN,
    @Sectionid = @Sectionid,
    @mdcostcenteraxsn = @mdcostcenteraxsn,
    @mdDistrictSN = @mdDistrictSN,
    @AXRECID = @AXRECID;

EXEC dbo.fcSPFranchiseStore_InsertTadarokat_toPAP @FranchiseStoreSN = @FranchiseStoreSN;
EXEC dbo.fcSPFranchiseStore_InsertDiscountstore_toPAP @FranchiseStoreSN = @FranchiseStoreSN;
EXEC dbo.fcSPFranchiseStore_InsertVatStore_toPAP @FranchiseStoreSN = @FranchiseStoreSN;
EXEC dbo.fcSPFranchiseStore_InsertCash_toPAP @FranchiseStoreSN = @FranchiseStoreSN;
EXEC dbo.fcSPFranchiseStore_InsertPosDevice_toPAP @FranchiseStoreSN = @FranchiseStoreSN;

-- Final select using the variable
SELECT * 
FROM OKPlan..fcFranchiseTransactionLog 
WHERE FranchiseStoreSN = @FranchiseStoreSN ;

SELECT SName FROM KOUROSHSTOREDB.POS.dbo.Store
WHERE SCode = 11313 




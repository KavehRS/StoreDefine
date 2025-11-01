 SET XACT_ABORT ON



--- SELECT * FROM OKPlan..fcFranchiseTransactionLog WHERE FranchiseStoreSN =    83322.474



-- SELECT * FROM dbo.Owner -- 8646.199 -- 7121.199
-- WHERE OwnerID = 8646.199
 
--**********************************************Centralwh******OKMasterData

SELECT * FROM OKMasterData..mdRegionSub where mdRegionSN = 7.199 AND mdRegionSubDS LIKE '%گلستان%'
SELECT * FROM OKMasterData..mddistrict WHERE mdDistrictDS LIKE '%گلستان%'


SELECT 
s.mdRegionSubDS,
s.mdRegionSubSN,
d.mdDistrictDS,
d.mdDistrictSN
FROM OKMasterData..mddistrict d
INNER JOIN OKMasterData..mdRegionSub s
    ON d.mdRegionSubSN = s.mdRegionSubSN
WHERE s.mdRegionSN = 9.199
  AND s.mdRegionSubDS LIKE N'%سنندج%';





--*********************************************Kouroshstoredb*****POS 
 SELECT * FROM KOUROSHSTOREDB.POS.dbo.Store-- 
WHERE StoreId ='9036.199'

--**********************************************Centralwh******okmasterdata

SELECT * FROM  okmasterdata.dbo.mdCostCenterAX
WHERE mdCostCenterAXValue  LIKE '%OKR10765%'


--**********************************************OKDC32013\NODE******OperationalDB

SELECT RECID,* FROM OperationalDB.ax.OMOPERATINGUNITENTITY
--WHERE NAME LIKE '%%'
WHERE OPERATINGUNITNUMBER LIKE N'%OKR10765%'






/************************************************
************************دریافت سریال ارزش AX****
*****************************از خانم دست افکن***
************************************************/

	USE OKPlan
        EXEC dbo.fcSPFranchiseStore_InsertDepartment_toPAP  @FranchiseStoreSN =  83322.474,  
                                                            @FranchiseContractSN = 116807.474,
														    @mdRegionsubSN = 41,
														    @Sectionid = 7308.000,
															@mdcostcenteraxsn= 5645811579 ,
														    @mdDistrictSN = 22,
														    @AXRECID = 5637591015
															
--SELECT * FROM dbo.mdSection WHERE mdSectionSN = 6996

/*Cannot insert the value NULL into column 'mdDepCodeMarkaz', table 'OKMasterData.dbo.mdDep'; column does not allow nulls. INSERT fails.*/
-- 12704.000 KOOROSHDB	Personnel	Departeman	12704.000
--SELECT * FROM mdvwDep WHERE mdDepNO = 13226

--5637583859
--SELECT * FROM  OKMasterData.dbo.mdDep 
-- -- SET mdDepAXRecID = 5637583859 , mdSectionSN = 7186.000  --mdcostcenteraxsn= 5645469588 ,  mdRegionsubSN = 37, mdDistrictSN = 12,
--WHERE mdDepDS LIKE N'%فرانچا%ز نوشهر %وش% سرا دو%'  




----10- EXEC sp_helptext cfcSPFranchiseStore_InsertDepartment_toPAP

-- SELECT * FROM Departeman WHERE Depname LIKE  N'%فرانچا%ز نوشهر %وش% سرا دو%'  
-- SELECT * FROM  OKMasterData.dbo.mdDep WHERE mdCostCenterAxSn = 5645501838



-- ************************************************************************************************  
  
        EXEC dbo.fcSPFranchiseStore_InsertTadarokat_toPAP @FranchiseStoreSN =        83322.474    ;  --       83322.474  


	


--11- sp_helptext dbo.fcSPFranchiseStore_InsertTadarokat_toPAP
                        
--**************************************************************************************************  
  
        EXEC dbo.fcSPFranchiseStore_InsertDiscountstore_toPAP @FranchiseStoreSN =       83322.474 ;



		
--12-sp_helptext dbo.fcSPFranchiseStore_InsertDiscountstore_toPAP
                       
--***************************************************************************************************
  
        EXEC dbo.fcSPFranchiseStore_InsertVatStore_toPAP @FranchiseStoreSN =       83322.474;  




--13-sp_helptext fcSPFranchiseStore_InsertVatStore_toPAP
                        
--***************************************************************************************************

        EXEC dbo.fcSPFranchiseStore_InsertCash_toPAP @FranchiseStoreSN =       83322.474 ;  




--14-sp_helptext fcSPFranchiseStore_InsertCash_toPAP
                        
--***************************************************************************************************  
  
        EXEC dbo.fcSPFranchiseStore_InsertPosDevice_toPAP @FranchiseStoreSN =    83322.474 ; 






--15-sp_helptext fcSPFranchiseStore_InsertPosDevice_toPAP
           
--***************************************************************************************************  
	SELECT * FROM OKPlan..fcFranchiseTransactionLog WHERE FranchiseStoreSN  =    83322.474  






                     ***************** END -- send name for Business*****************

SELECT SName FROM KOUROSHSTOREDB.POS.dbo.Store
WHERE StoreId ='9036.199' 





--SELECT * FROM KOUROSHSTOREDB.POS.dbo.Store WHERE SCode = 10289


-- چک کردن ایجاد کاست سنتر AX2012
SELECT * FROM  [centralwh1\node].okmasterdata.dbo.mdCostCenterAX
WHERE mdCostCenterAXValue LIKE N'%OKR%' --AND mdCostCenterAXValue IN (N'OKR09173')
ORDER BY mdCostCenterAXValue DESC






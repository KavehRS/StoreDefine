 SET XACT_ABORT ON



--- SELECT * FROM OKPlan..fcFranchiseTransactionLog WHERE FranchiseStoreSN =      84157.474



-- SELECT * FROM dbo.Owner -- 8646.199 -- 7121.199
-- WHERE OwnerID = 8646.199
 
--**********************************************Centralwh******OKMasterData

SELECT * FROM OKMasterData..mdRegionSub where mdRegionSN = 1.199 AND mdRegionSubDS LIKE '%تربت%'
SELECT * FROM OKMasterData..mddistrict WHERE mdDistrictDS LIKE '%تربت%'



--*********************************************Kouroshstoredb*****POS 
 SELECT * FROM KOUROSHSTOREDB.POS.dbo.Store-- 
WHERE StoreId ='9208.199'

--**********************************************Centralwh******okmasterdata

SELECT * FROM  okmasterdata.dbo.mdCostCenterAX
WHERE mdCostCenterAXValue  LIKE '%OKR10690%'


--**********************************************OKDC32013\NODE******OperationalDB

SELECT RECID,* FROM OperationalDB.ax.OMOPERATINGUNITENTITY
--WHERE NAME LIKE '%%'
WHERE OPERATINGUNITNUMBER LIKE N'%OKR10690%'






/************************************************
************************دریافت سریال ارزش AX****
*****************************از خانم دست افکن***
************************************************/

	USE OKPlan
        EXEC dbo.fcSPFranchiseStore_InsertDepartment_toPAP  @FranchiseStoreSN =    84157.474,  
                                                            @FranchiseContractSN = 117162.474,
														    @mdRegionsubSN = 4,
														    @Sectionid = 7480.000,
															@mdcostcenteraxsn= 5645927076 ,
														    @mdDistrictSN = 5,
														    @AXRECID = 5637594444
															
--SELECT * FROM dbo.mdSection WHERE mdSectionSN = 6996

/*Cannot insert the value NULL into column 'mdDepCodeMarkaz', table 'OKMasterData.dbo.mdDep'; column does not allow nulls. INSERT fails.*/
-- 12704.000 KOOROSHDB	Personnel	Departeman	12704.000
--SELECT * FROM mdvwDep WHERE mdDepNO = 13226

----5637583859
--SELECT * FROM  OKMasterData.dbo.mdDep 
-- -- SET mdcostcenteraxsn= 5645744079 mdDepAXRecID= 5637587999 mdDistrictSN = 682 -- mdDepAXRecID = 5637583859 , mdSectionSN = 7186.000  --mdcostcenteraxsn= 5637587999 ,  mdRegionsubSN = 37, mdDistrictSN = 682,
--WHERE mdDepDS LIKE N'%خل%ل آباد رجا%'  



----10- EXEC sp_helptext cfcSPFranchiseStore_InsertDepartment_toPAP

-- SELECT * FROM Departeman WHERE Depname LIKE  N'%فرانچا%ز نوشهر %وش% سرا دو%'  
-- SELECT * FROM  OKMasterData.dbo.mdDep WHERE mdCostCenterAxSn = 5645501838



-- ************************************************************************************************  
  
        EXEC dbo.fcSPFranchiseStore_InsertTadarokat_toPAP @FranchiseStoreSN =          84157.474    ;  --         84157.474  


	


--11- sp_helptext dbo.fcSPFranchiseStore_InsertTadarokat_toPAP
                        
--**************************************************************************************************  
  
        EXEC dbo.fcSPFranchiseStore_InsertDiscountstore_toPAP @FranchiseStoreSN =         84157.474 ;



		
--12-sp_helptext dbo.fcSPFranchiseStore_InsertDiscountstore_toPAP
                       
--***************************************************************************************************
  
        EXEC dbo.fcSPFranchiseStore_InsertVatStore_toPAP @FranchiseStoreSN =         84157.474;  




--13-sp_helptext fcSPFranchiseStore_InsertVatStore_toPAP
                        
--***************************************************************************************************

        EXEC dbo.fcSPFranchiseStore_InsertCash_toPAP @FranchiseStoreSN =         84157.474 ;  




--14-sp_helptext fcSPFranchiseStore_InsertCash_toPAP
                        
--***************************************************************************************************  
  
        EXEC dbo.fcSPFranchiseStore_InsertPosDevice_toPAP @FranchiseStoreSN =      84157.474 ; 






--15-sp_helptext fcSPFranchiseStore_InsertPosDevice_toPAP
           
--***************************************************************************************************  
	SELECT * FROM OKPlan..fcFranchiseTransactionLog WHERE FranchiseStoreSN  =      84157.474  






                     ***************** END -- send name for Business*****************
SELECT Sname FROM KOUROSHSTOREDB.POS.dbo.Store
WHERE StoreId ='9208.199' 







--SELECT * FROM KOUROSHSTOREDB.POS.dbo.Store WHERE SCode = 10289


-- چک کردن ایجاد کاست سنتر AX2012
SELECT * FROM  [centralwh1\node].okmasterdata.dbo.mdCostCenterAX
WHERE mdCostCenterAXValue LIKE N'%OKR%' --AND mdCostCenterAXValue IN (N'OKR09173')
ORDER BY mdCostCenterAXValue DESC






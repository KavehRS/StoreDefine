
SET XACT_ABORT ON



--- SELECT * FROM OKPlan..fcFranchiseTransactionLog WHERE FranchiseStoreSN =  85670.474 AND ErrorDS IS NULL



-- SELECT * FROM dbo.Owner -- 8646.199 -- 7121.199
-- WHERE OwnerID = 8646.199
 
--**********************************************Centralwh******OKMasterData

SELECT * FROM OKMasterData..mdRegionSub where mdRegionSN = 16.199  AND mdRegionSubDS LIKE '%ج%رفت%'
SELECT * FROM OKMasterData..mddistrict WHERE mdDistrictDS LIKE '%ج%رفت%'


--*********************************************Kouroshstoredb*****POS 
 SELECT * FROM KOUROSHSTOREDB.POS.dbo.Store-- 
WHERE StoreId ='9579.199'

--**********************************************Centralwh******okmasterdata

SELECT * FROM  okmasterdata.dbo.mdCostCenterAX
WHERE mdCostCenterAXValue  LIKE '%OKR11309%'

----gig-dc1-p451  ax
--SELECT KEY_, value FROM DimAttributeOMCostCenter WHERE value like N'OKR11219'




--**********************************************OKDC32013\NODE******OperationalDB

SELECT RECID,* FROM OperationalDB.ax.OMOPERATINGUNITENTITY
--WHERE NAME LIKE '%%'
WHERE OPERATINGUNITNUMBER LIKE N'%OKR11309%'






/************************************************
************************دریافت سریال ارزش AX****
*****************************از خانم دست افکن***
************************************************/

	USE OKPlan
        EXEC dbo.fcSPFranchiseStore_InsertDepartment_toPAP  @FranchiseStoreSN =   85670.474,  
                                                            @FranchiseContractSN = 117850.474,
														    @mdRegionsubSN = 78,
														    @Sectionid = 7823.000,
															@mdcostcenteraxsn= 5646234579 ,
														    @mdDistrictSN = 69,
														    @AXRECID = 5637608632
															
--SELECT * FROM dbo.mdSection WHERE mdSectionSN = 6996

/*Cannot insert the value NULL into column 'mdDepCodeMarkaz', table 'OKMasterData.dbo.mdDep'; column does not allow nulls. INSERT fails.*/
-- 12704.000 KOOROSHDB	Personnel	Departeman	12704.000
--SELECT * FROM mdvwDep WHERE mdDepNO = 13226

------5637583859

--SELECT * FROM pos .. store WHERE scode = 10993

--UPDATE
--SELECT * FROM 
--OKMasterData.dbo.mdDep
-- --  SET mdRegionSN = 11.199
--WHERE mdDepDS LIKE  N'%بومهن%حق%' 




SELECT * FROM pos .. store WHERE SName like N'%فرانچا%ز صدرا خ%ابان مولانا%' 


--SELECT * FROM pos .. store

--SELECT * FROM [OKMasterData].[dbo].[VW_mdDep] WHERE  mdInvLocAXValue =N'OKS10847'
--sp_helptext VW_mdDep
--SELECT * FROM OKMasterData.dbo.mdDep

--WHERE mdDepDS LIKE  N'%مر%وان%گلشن%' 

--SELECT * FROM  pos .. store WHERE scode = 10846
----
--UPDATE pos .. store 
--SET RegionId =
--6.199
--WHERE scode = 10882

----10- EXEC sp_helptext cfcSPFranchiseStore_InsertDepartment_toPAP

-- SELECT * FROM Departeman WHERE Depname LIKE  N'%جو%بار%امام%خم%ن%'   
-- SELECT * FROM  OKMasterData.dbo.mdDep WHERE mdCostCenterAxSn = 5645501838



-- ************************************************************************************************  
  
        EXEC dbo.fcSPFranchiseStore_InsertTadarokat_toPAP @FranchiseStoreSN =   85670.474    --        ;  --           85670.474  



		--SELECT * FROM store WHERE SName  LIKE  N'%فاضل نراق%' 



--11- sp_helptext dbo.fcSPFranchiseStore_InsertTadarokat_toPAP
                        
--**************************************************************************************************  
  
        EXEC dbo.fcSPFranchiseStore_InsertDiscountstore_toPAP @FranchiseStoreSN =    85670.474 ;



		
--12-sp_helptext dbo.fcSPFranchiseStore_InsertDiscountstore_toPAP
                       
--***************************************************************************************************
  
        EXEC dbo.fcSPFranchiseStore_InsertVatStore_toPAP @FranchiseStoreSN =   85670.474;  




--13-sp_helptext fcSPFranchiseStore_InsertVatStore_toPAP
                        
--***************************************************************************************************

        EXEC dbo.fcSPFranchiseStore_InsertCash_toPAP @FranchiseStoreSN =           85670.474 ;  




--14-sp_helptext fcSPFranchiseStore_InsertCash_toPAP
                        
--***************************************************************************************************  
  
  EXEC dbo.fcSPFranchiseStore_InsertPosDevice_toPAP @FranchiseStoreSN =        85670.474 ; 






--15-sp_helptext fcSPFranchiseStore_InsertPosDevice_toPAP
           
--***************************************************************************************************  
SELECT * FROM OKPlan..fcFranchiseTransactionLog WHERE FranchiseStoreSN  =   85670.474   AND ErrorDS IS NULL






                     ***************** END -- send name for Business*****************
SELECT Sname FROM KOUROSHSTOREDB.POS.dbo.Store
WHERE StoreId ='9579.199' 







--SELECT * FROM KOUROSHSTOREDB.POS.dbo.Store WHERE SCode = 10289


-- چک کردن ایجاد کاست سنتر AX2012
SELECT * FROM  [centralwh1\node].okmasterdata.dbo.mdCostCenterAX
WHERE mdCostCenterAXValue LIKE N'%OKR%' --AND mdCostCenterAXValue IN (N'OKR09173')
ORDER BY mdCostCenterAXValue DESC




		EXEC fcSPFranchiseStore_InsertSectionId_toPAP @FranchiseStoreSN =     85670.474         ,
		@FranchiseContractSN = 117857.474, @mdRegionsubSN = 103


		--SELECT * FROM ttadarokat WHERE  sharh LIKE  N'%لار دانش%' 

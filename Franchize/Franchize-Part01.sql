
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



--****************************************************************************centralwh----USE OKPlan

 
USE OKPlan
GO
SELECT 
DISTINCT fs.FranchiseStoreSabtRegion,
      FS.FranchiseStoreSN,
      FC.FranchiseContractSN,
	  FC.mdDepSN_Parent,
	  fs.RegionId ,FC.FranchiseContractTypeSN,FS.StoreID,*
FROM dbo.fcFranchiseStore FS
    INNER JOIN dbo.fcFranchiseContract FC ---قرارداد
        ON FC.FranchiseStoreSN = FS.FranchiseStoreSN
    INNER JOIN dbo.fcFranchiseStoreVasighe FSV -----وثیقه
        ON FSV.FranchiseContractSN = FC.FranchiseContractSN
    INNER JOIN dbo.fcFranchiseContractPerson FCP ----اشخاص قرارداد
        ON FCP.FranchiseContractSN = FC.FranchiseContractSN
WHERE      
FS.FranchiseStoreSN =   84184.474      AND     -- وارد کردن FranchiseStoreSN
FS.StoreID IS NULL AND ---فروشگاه تعریف نشده 
FC.FranchiseContractTypeSN = 1 --نوعش تسهیلاته یا نمایندگی 
--AND FC.FranchiseContractStatus = 80


-- SELECT * FROM  dbo.fcFranchiseStore WHERE  FranchiseStoreSN =  84184.474     -- StoreID: 7663.199
-- SELECT * FROM  dbo.fcFranchiseContract  WHERE   FranchiseContractSN = 117176.474   
-- SELECT * FROM dbo.fcFranchiseStoreVasighe WHERE FranchiseContractSN  = 117176.474
-- SELECT * FROM  dbo.fcFranchiseContractPerson WHERE FranchiseContractSN  = 117176.474


--	 EXEC sp_helptext fcVWFranchiseContract_DropDown_Ref 
-- SELECT * FROM  dbo.fcFranchiseStore WHERE FranchiseStoreMalekFamili LIKE '%شاورز%'
--SELECT * FROM dbo.fcFranchiseContractPerson WHERE FranchiseContractPersonLName  LIKE '%شاورز%'
--SELECT * FROM 

--***************************************************************************************************  

        EXEC dbo.fcFranchiseStoreCheckingNotNullData @FranchiseStoreSN =     84184.474   ;  
	   



	   
--1- exec sp_helptext fcFranchiseStoreCheckingNotNullData
--LOG--SELECT * FROM fcFranchiseTransactionLog WHERE FranchiseStoreSN=     84184.474                                                           
--****************************************************************************************************

		EXEC dbo.fcFranchiseContractCheckingNotNullDataPrint @FranchiseContractSN =  117176.474;

		


--2-sp_helptext fcFranchiseContractCheckingNotNullDataPrint      
--LOG--SELECT * FROM fcFranchiseTransactionLog WHERE FranchiseStoreSN=     84184.474             
--****************************************************************************************************

    	EXEC fcSPFranchiseStore_InsertEstate_toPAP       84184.474   ;
           
	
	--SELECT * FROM    Estate..Estate -- 6959.199
	--WHERE EstateID IN (7688.199 )
	

	--SELECT * FROM   KOUROSHSTOREDB.POS.dbo.Store 
	----SET EstateID = 6794.199
 --   WHERE EstateID = 7544.199





--3-sp_helptext fcSPFranchiseStore_InsertEstate_toPAP
--LOG--SELECT * FROM fcFranchiseTransactionLog WHERE FranchiseStoreSN=        84184.474                                                                    
--**************************************************************************************************** 

        EXEC dbo.akspAmlak_FranchiseToAmlak  @FranchiseStoreSN =     84184.474      ,  @mdRegionsubSN = 46,--(SELECT  * FROM OKMasterData..mdRegionSub where mdRegionSN = 8.199 ), 
	                                                                               	  @mdSectionsn = NULL


--@mdRegionsubSN قرار میدهیم کد ریجن را در کوییری داخل پرانتز وارد کرده و سپس دیستریکت را پیدا کرده و جلوی 


	 -- SELECT  * FROM         OKMali..akamlak 
		--SET mdRegionSubSN = 32
  --      WHERE  akAmlakMovaledSN =     84184.474    

                                                 
--4-sp_helptext [akspAmlak_FranchiseToAmlak]
--LOG--SELECT * FROM fcFranchiseTransactionLog WHERE FranchiseStoreSN=     84184.474                                                                    
--****************************************************************************************************	                 
 
        EXEC dbo.fcSPFranchiseStore_InsertContract_toPAP @FranchiseContractSN = 117176.474; 
		

		--SELECT * FROM         Estate..Contract
		--WHERE ContractID = 8286.199


	

--SELECT * FROM      dbo.fcFranchiseContract --- 7390.199
-- --SET ContractID = NULL
--WHERE FranchiseStoreSN =     84184.474    

	--FranchiseStoreSN

--5-sp_helptext fcSPFranchiseStore_InsertContract_toPAP      
--LOG--SELECT * FROM fcFranchiseTransactionLog WHERE FranchiseStoreSN  =     84184.474                                            
--****************************************************************************************************  
     
        EXEC dbo.fcSPFranchiseStore_InsertContractPerson_toPAP @FranchiseContractSN = 117176.474


		--SELECT  * FROM      Estate..[Owner]
		--WHERE OwnerID in (10318.199)



	
		
--6-sp_helptext fcSPFranchiseStore_InsertContractPerson_toPAP      
--LOG--SELECT * FROM fcFranchiseTransactionLog WHERE FranchiseStoreSN=     84184.474                                                                   
--****************************************************************************************************  
  
        EXEC dbo.fcSPFranchiseStore_InsertContractBand_toPAP @FranchiseContractSN =117176.474;


		
  --   SELECT  *  FROM    Estate..ContractBand
	 --WHERE ContractID=  8171.199

 


  
--7- EXEC sp_helptext fcSPFranchiseStore_InsertContractBand_toPAP      
--LOG--SELECT * FROM fcFranchiseTransactionLog WHERE FranchiseStoreSN =      84184.474                                                                    
--**************************************************************************************************** 
    
        EXEC dbo.fcSPFranchiseStore_InsertStore_toPAP @FranchiseStoreSN    =   84184.474   ,
													  @FranchiseContractSN =  117176.474 ;
							
	-- SELECT * FROM store where StoreId = 9021.199








----8- EXEC sp_helptext fcSPFranchiseStore_InsertStore_toPAP
--LOG-- SELECT * FROM fcFranchiseTransactionLog WHERE FranchiseStoreSN=     84184.474                                                                 
--****************************************************************************************************   

		EXEC fcSPFranchiseStore_InsertSectionId_toPAP @FranchiseStoreSN =     84184.474         ,	@FranchiseContractSN =117176.474, @mdRegionsubSN = 46

	


	--DELETE [CentralWH1\NODE].OKMasterData.dbo.mdSection
	----SET mdRegionSubSN = 45
	--WHERE MDSectionSN  IN (7302.000)

	--SELECT * FROM  Section
	--WHERE Sectionid IN (7296)


	  --SELECT * FROM  dbo.fcFranchiseStore
	  -- -- SET Cityid = 143.490
	  --WHERE FranchiseStoreSN =     84184.474    
	 ----Select * from OKMASTERDATA.dbo.mdCityPos where mdProvincePosSN =1.301 AND mdCityPosDS LIKE N'%پ%شوا%'


--SELECT * FROM fcFranchiseTransactionLog WHERE   EntityName = N'Store' -- AND EntityPrimaryKey =  N'4087.199'
--SELECT * FROM OKMasterData..mdRegionSub where mdRegionSN =7.199 
--SELECT * FROM owner WHERE ownerid=8330.199


--9- EXEC sp_helptext fcSPFranchiseStore_InsertSectionId_toPAP
--LOG--SELECT * FROM fcFranchiseTransactionLog WHERE FranchiseStoreSN =      84184.474                                                                      
--****************************************************************************************************

SELECT * FROM fcFranchiseTransactionLog WHERE FranchiseStoreSN =   84184.474    


SELECT RegionId,* FROM KOUROSHSTOREDB.POS.dbo.Store 
WHERE StoreId ='9216.199' 

SELECT
am.akAmlakDS,NULL,NULL,d.mdDistrictDS,c.mdCityPosDS,p.mdProvincePosDS,am.akAmlakAddress,am.akAmlakPostalCode
 FROM      OKMali..akAmlak am
 FULL OUTER JOIN OKMasterData..mddistrict d
 ON am.mdRegionsubSN = d.mdRegionsubSN
  FULL OUTER JOIN OKMasterData..mdcityPOS c
  ON am.mdCitySN = c.mdCityPOsSN
  FULL OUTER JOIN OKMasterData..mdProvincePos p
  ON c.mdProvincePosSN = p.mdProvincePosSN
WHERE  am.akAmlakMovaledSN =     84184.474 ;


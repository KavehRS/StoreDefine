
SET XACT_ABORT ON
--DISABLE Trigers :
--************************************************************************************** kouroshstoredb
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


--**************************************************************************************** korooshdb
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
FS.FranchiseStoreSN =   85657.474      AND     -- وارد کردن FranchiseStoreSN
FS.StoreID IS NULL AND ---فروشگاه تعریف نشده 
FC.FranchiseContractTypeSN = 1 --نوعش تسهیلاته یا نمایندگی 
--AND FC.FranchiseContractStatus = 80


-- SELECT * FROM  dbo.fcFranchiseStore WHERE  FranchiseStoreSN =  85657.474     -- StoreID: 7663.199
-- SELECT * FROM  dbo.fcFranchiseContract  WHERE   FranchiseContractSN = 117923.474   
-- SELECT * FROM dbo.fcFranchiseStoreVasighe WHERE FranchiseContractSN  = 117923.474
-- SELECT * FROM  dbo.fcFranchiseContractPerson WHERE FranchiseContractSN  = 117923.474


--	 EXEC sp_helptext fcVWFranchiseContract_DropDown_Ref 
-- SELECT * FROM  dbo.fcFranchiseStore WHERE FranchiseStoreMalekFamili LIKE '%شاورز%'
--SELECT * FROM dbo.fcFranchiseContractPerson WHERE FranchiseContractPersonLName  LIKE '%شاورز%'
--SELECT * FROM 

--***************************************************************************************************  

        EXEC dbo.fcFranchiseStoreCheckingNotNullData @FranchiseStoreSN =     85657.474   ;  
	   



	   
--1- exec sp_helptext fcFranchiseStoreCheckingNotNullData
--LOG--SELECT * FROM fcFranchiseTransactionLog WHERE FranchiseStoreSN=     85657.474                                                           
--****************************************************************************************************

		EXEC dbo.fcFranchiseContractCheckingNotNullDataPrint @FranchiseContractSN =  117923.474;

		


--2-sp_helptext fcFranchiseContractCheckingNotNullDataPrint      
--LOG--SELECT * FROM fcFranchiseTransactionLog WHERE FranchiseStoreSN=     85657.474            
--****************************************************************************************************

    	EXEC fcSPFranchiseStore_InsertEstate_toPAP       85657.474   ;
           
	
	--SELECT * FROM     Estate..Estate -- 6959.199
	--WHERE EstateID IN (8066.199, 8063.199, 8044.199, 8823.199)
	

	--SELECT * FROM   KOUROSHSTOREDB.POS.dbo.Store 
	----SET EstateID = 6794.199
 --   WHERE EstateID = 8044.199





--3-sp_helptext fcSPFranchiseStore_InsertEstate_toPAP
--LOG--SELECT * FROM fcFranchiseTransactionLog WHERE FranchiseStoreSN=        85657.474                                                                    
--**************************************************************************************************** 

        EXEC dbo.akspAmlak_FranchiseToAmlak  @FranchiseStoreSN =     85657.474      ,  @mdRegionsubSN = 32,--(SELECT  * FROM OKMasterData..mdRegionSub where mdRegionSN = 10.199 ), 
	                                                                               	  @mdSectionsn = NULL


--@mdRegionsubSN قرار میدهیم کد ریجن را در کوییری داخل پرانتز وارد کرده و سپس دیستریکت را پیدا کرده و جلوی 

----
--SELECT  * FROM         OKMali..akamlak where akAmlakDS like N'%فرانچا%ز د%لم امام حس%ن شرق%'
----SET mdRegionSN = 7.199
--WHERE akAmlakSN = 348



	 -- SELECT  * FROM         OKMali..akamlak where akAmlakDS like N'%شاهد%'
		---- SET mdRegionSubSN = 32
  --      WHERE  akAmlakMovaledSN =     85657.474    

--4-sp_helptext [akspAmlak_FranchiseToAmlak]
--LOG--SELECT * FROM fcFranchiseTransactionLog WHERE FranchiseStoreSN=     85657.474                                                                    
--****************************************************************************************************	                 
 
        EXEC dbo.fcSPFranchiseStore_InsertContract_toPAP @FranchiseContractSN = 117923.474; 
		

		--SELECT * FROM 		Estate..Contract
		--WHERE ContractID = 8823.199


	

--SELECT * FROM  dbo.fcFranchiseContract --- 7390.199
-- -- SET ContractID = NULL
--WHERE FranchiseStoreSN =     85657.474    

	--FranchiseStoreSN

--5-sp_helptext fcSPFranchiseStore_InsertContract_toPAP      
--LOG--SELECT * FROM fcFranchiseTransactionLog WHERE FranchiseStoreSN  =     85657.474                                            
--****************************************************************************************************  
     
        EXEC dbo.fcSPFranchiseStore_InsertContractPerson_toPAP @FranchiseContractSN = 117923.474


		--SELECT  * FROM      Estate..[Owner]
		--WHERE OwnerID in (10318.199)



	
		
--6-sp_helptext fcSPFranchiseStore_InsertContractPerson_toPAP      
--LOG--SELECT * FROM fcFranchiseTransactionLog WHERE FranchiseStoreSN=     85657.474                                                                   
--****************************************************************************************************  
  
        EXEC dbo.fcSPFranchiseStore_InsertContractBand_toPAP @FranchiseContractSN = 117986.474;


		
  --   SELECT  *  FROM    Estate..ContractBand
	 --WHERE ContractID=  8171.199

 


  
--7- EXEC sp_helptext fcSPFranchiseStore_InsertContractBand_toPAP      
--LOG--SELECT * FROM fcFranchiseTransactionLog WHERE FranchiseStoreSN =      85657.474                                                                    
--**************************************************************************************************** 
    
        EXEC dbo.fcSPFranchiseStore_InsertStore_toPAP @FranchiseStoreSN    =   85657.474   ,
													  @FranchiseContractSN =  117923.474 ;
							
	-- SELECT * FROM store where StoreId = 9021.199



----8- EXEC sp_helptext fcSPFranchiseStore_InsertStore_toPAP
--LOG-- SELECT * FROM fcFranchiseTransactionLog WHERE FranchiseStoreSN=    85657.474                                                                
--****************************************************************************************************   

		EXEC fcSPFranchiseStore_InsertSectionId_toPAP @FranchiseStoreSN =     85657.474         ,	@FranchiseContractSN = 117923.474, @mdRegionsubSN = 32




	-- Select * from  [CentralWH1\NODE].OKMasterData.dbo.mdSection
	----SET mdRegionSubSN = 63
	--WHERE MDSectionSN  IN (7745)

	--SELECT * FROM  Section
	--WHERE Sectionid IN (7745.000)


	  --SELECT * FROM  dbo.fcFranchiseStore
	  -- -- SET Cityid = 143.490
	  --WHERE FranchiseStoreSN =     85657.474    
	 ----Select * from OKMASTERDATA.dbo.mdCityPos where mdProvincePosSN =1.301 AND mdCityPosDS LIKE N'%پ%شوا%'


--SELECT * FROM fcFranchiseTransactionLog WHERE   EntityName = N'Store' -- AND EntityPrimaryKey =  N'4087.199'
--SELECT * FROM OKMasterData..mdRegionSub where mdRegionSN =7.199 
--SELECT * FROM owner WHERE ownerid=8330.199


--9- EXEC sp_helptext fcSPFranchiseStore_InsertSectionId_toPAP
--LOG--SELECT * FROM fcFranchiseTransactionLog WHERE FranchiseStoreSN =      85657.474                                                                      
--****************************************************************************************************

SELECT * FROM fcFranchiseTransactionLog WHERE FranchiseStoreSN =   85657.474    


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
WHERE a.StoreId = '9584.199'



SELECT
am.akAmlakDS,NULL,NULL,d.mdDistrictDS,c.mdCityPosDS,p.mdProvincePosDS,am.akAmlakAddress,am.akAmlakPostalCode
 FROM      OKMali..akAmlak am
 FULL OUTER JOIN OKMasterData..mddistrict d
 ON am.mdRegionsubSN = d.mdRegionsubSN
  FULL OUTER JOIN OKMasterData..mdcityPOS c
  ON am.mdCitySN = c.mdCityPOsSN
  FULL OUTER JOIN OKMasterData..mdProvincePos p
  ON c.mdProvincePosSN = p.mdProvincePosSN
WHERE  am.akAmlakMovaledSN =  85657.474 ;








SELECT * FROM  OKMasterData..mddistrict WHERE mdRegionsubSN =11
 SELECT  * FROM OKMasterData..mdRegionSub where mdRegionSN = 9.199


 
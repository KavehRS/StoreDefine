
/*فرانچایز بجنورد شیر آب*/
/*OKS10837	     فرانچا%ز بجنورد شهرباز*/
------------------------------------------------------------------------------------------------------------akamlakds
           
SELECT * FROM      [CentralWH1\NODE].okmali.dbo.akamlak  
-- SET akAmlakDS = N'فرانچایز بجنورد شیر آب'  
WHERE akAmlakDS LIKE  N'%فرانچا%ز بجنورد شهرباز%' AND akAmlakSN = 9330




----------------------------------------------------------------------------------------------------------------EstateName 

-- koroshdb
SELECT * FROM   	   Estate.dbo.Estate 
--SET EstateName = N'فرانچایز بجنورد شیر آب'    
WHERE EstateName LIKE  N'%فرانچا%ز بجنورد شهرباز%'  AND EstateID = 7812.199




SELECT * FROM     [CentralWH1\NODE].OKMasterData.dbo.mdDep
--SET  mdDepDS = N'فرانچایز بجنورد شیر آب'
WHERE  mdDepDS  LIKE  N'%فرانچا%ز بجنورد شهرباز%' AND mdDepSN = 13966




---------------------------------------------------------------------------------------------------------------------Depname

-- koroshdb
SELECT * FROM       Personnel.dbo.Departeman 
   --SET Depname= N'فرانچایز بجنورد شیر آب'
WHERE Depname   LIKE  N'%فرانچا%ز بجنورد شهرباز%' AND DepId = 13966

--------------------------------------------------------------------------------------------------------------------Tadarokat

SELECT * FROM     [Kouroshstoredb\NODE].Tadarokat.dbo.tTadarokat 
  --   SET Sharh = N'فرانچایز بجنورد شیر آب'  
WHERE  Sharh LIKE  N'%فرانچا%ز بجنورد شهرباز%'  AND TadarokatSN = 8745.199


-----------------------------------------------------------------------------------------------------------------------------Section


SELECT * FROM        Personnel.dbo.Section 
--SET SectionName = N'م8 فرانچایز بجنورد شیر آب' , namekargah = N'فرانچایز بجنورد شیر آب'  
WHERE  SectionName LIKE  N'%فرانچا%ز بجنورد شهرباز%' AND 	Sectionid = 7419
 

SELECT * FROM      [CentralWH1\NODE].OKMasterData.dbo.mdSection
-- SET mdSectionDS =  N'م8 فرانچایز بجنورد شیر آب'
WHERE mdSectionDS LIKE  N'%فرانچا%ز بجنورد شهرباز%' AND mdSectionSN = 7461


--===============================================================
--===============================================================
--===============================================================
--===============================================================

 USE common
 GO
 disable trigger tr_pss_duplicate ON common.dbo.uUserAccess
 GO

 USE pos
 GO
 disable trigger Tr_CheckStore ON pos.dbo.store
 GO

 USE pos
 GO
 disable trigger Tr_Duplicatescode ON  pos.dbo.store
 GO

 USE Tadarokat
 GO
 DISABLE TRIGGER dbo.CheckDuplicatIP ON dbo.tTadarokat -- Disable

 USE Anbar
 GO
 DISABLE TRIGGER dbo.Tr_Checkaanbar ON dbo.aAnbar -- Disable

--===============================================================
--===============================================================
--===============================================================
--===============================================================

SELECT * FROM          Anbar..aAnbar  -- 6542.199
--SET Dsc =  N'فرانچایز بجنورد شیر آب'  , UnqStr = N'فرانچایزصالحآبادسعدی'
WHERE Dsc LIKE  N'%فرانچا%ز بجنورد شهرباز%' AND AnbarSN = 8647.199




------------------------------------------------------------------------------------------------------------------POS
SELECT * FROM            pos..Store 
  --SET sname = N'فرانچایز بجنورد شیر آب'   
WHERE    SName LIKE   N'%فرانچا%ز بجنورد شهرباز%' AND  StoreId = 9134.199



--SELECT * FROM pos..Store_TrgLog
--WHERE StoreId = 7146.199





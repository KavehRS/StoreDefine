
/*فرانچايز کرج خيابان شريعتي*/
/*OKS10837	     فرانچا%ز %رج خ%ابان شر%ع*/
------------------------------------------------------------------------------------------------------------akamlakds
           
SELECT * FROM      [CentralWH1\NODE].okmali.dbo.akamlak  
-- SET akAmlakDS = N'فرانچايز کرج خيابان شريعتي'  
WHERE akAmlakDS LIKE  N'%فرانچا%ز %رج خ%ابان شر%ع%' AND akAmlakSN = 9594




----------------------------------------------------------------------------------------------------------------EstateName 

-- koroshdb
SELECT * FROM    	   Estate.dbo.Estate 
    --SET EstateName = N'فرانچايز کرج خيابان شريعتي'    
WHERE EstateName LIKE  N'%فرانچا%ز %رج خ%ابان شر%ع%'  AND EstateID = 8041.199




SELECT * FROM [CentralWH1\NODE].OKMasterData.dbo.mdDep
       --           SET  mdDepDS = N'فرانچايز کرج خيابان شريعتي'
WHERE  mdDepDS  LIKE  N'%فرانچا%ز %رج خ%ابان شر%ع%' AND mdDepSN = 14752




---------------------------------------------------------------------------------------------------------------------Depname

-- koroshdb
SELECT * FROM        Personnel.dbo.Departeman 
   --   SET Depname= N'فرانچايز کرج خيابان شريعتي'
WHERE Depname   LIKE  N'%فرانچا%ز %رج خ%ابان شر%ع%' AND DepId = 14752






--------------------------------------------------------------------------------------------------------------------Tadarokat

SELECT * FROM      [Kouroshstoredb\NODE].Tadarokat.dbo.tTadarokat 
    --  SET Sharh = N'فرانچايز کرج خيابان شريعتي'  
WHERE  Sharh LIKE  N'%فرانچا%ز %رج خ%ابان شر%ع%'  AND TadarokatSN = 9016.199


-----------------------------------------------------------------------------------------------------------------------------Section


SELECT * FROM  Personnel.dbo.Section 
             --  SET SectionName = N'م4 فرانچايز کرج خيابان شريعتي' , namekargah = N'فرانچايز کرج خيابان شريعتي'  
WHERE  SectionName LIKE  N'%فرانچا%ز %رج خ%ابان شر%ع%' AND 	Sectionid = 7681
 

SELECT * FROM       [CentralWH1\NODE].OKMasterData.dbo.mdSection
               -- SET mdSectionDS =  N'م4 فرانچايز کرج خيابان شريعتي'
WHERE mdSectionDS LIKE  N'%فرانچا%ز %رج خ%ابان شر%ع%' AND mdSectionSN = 7681


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
--SET Dsc =  N'فرانچايز کرج خيابان شريعتي'  , UnqStr = N'فرانچایزصالحآبادسعدی'
WHERE Dsc LIKE  N'%فرانچا%ز %رج خ%ابان شر%ع%' AND AnbarSN = 8647.199




------------------------------------------------------------------------------------------------------------------POS
SELECT * FROM     pos..Store 
      --  SET sname = N'فرانچايز کرج خيابان شريعتي'   
WHERE    SName LIKE   N'%فرانچا%ز %رج خ%ابان شر%ع%' AND  StoreId = 9403.199



--SELECT * FROM pos..Store_TrgLog
--WHERE StoreId = 7146.199





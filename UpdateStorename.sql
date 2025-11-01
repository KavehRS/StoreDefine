
/*فرانچايز امیدیه شهروند شهریور*/
/*OKS10419	    فرانچا%ز ام%د%ه شهروند دهملا*/
------------------------------------------------------------------------------------------------------------akamlakds
           
SELECT * FROM      [CentralWH1\NODE].okmali.dbo.akamlak  
-- SET akAmlakDS = N'فرانچايز امیدیه شهروند شهریور'  
WHERE akAmlakDS LIKE  N'%فرانچا%ز ام%د%ه شهروند%' AND akAmlakSN = 9062




----------------------------------------------------------------------------------------------------------------EstateName 


SELECT * FROM   	   Estate.dbo.Estate 
--SET EstateName = N'فرانچايز امیدیه شهروند شهریور'    
WHERE EstateName LIKE  N'%فرانچا%ز ام%د%ه شهروند دهملا%'  AND EstateID = 7594.199



SELECT * FROM     [CentralWH1\NODE].OKMasterData.dbo.mdDep
--SET  mdDepDS = N'فرانچايز امیدیه شهروند شهریور'
WHERE  mdDepDS  LIKE  N'%فرانچا%ز ام%د%ه شهروند %' AND mdDepSN = 13473




---------------------------------------------------------------------------------------------------------------------Depname


SELECT * FROM       Personnel.dbo.Departeman 
--SET Depname= N'فرانچايز امیدیه شهروند شهریور'
WHERE Depname   LIKE  N'%فرانچا%ز ام%د%ه شهروند%' AND DepId = 13473

--------------------------------------------------------------------------------------------------------------------Tadarokat

SELECT * FROM     [Kouroshstoredb\NODE].Tadarokat.dbo.tTadarokat 
 --    SET Sharh = N'فرانچايز امیدیه شهروند شهریور'  
WHERE  Sharh LIKE  N'%فرانچا%ز ام%د%ه شهروند%'  AND TadarokatSN = 8492.199


-----------------------------------------------------------------------------------------------------------------------------Section


SELECT * FROM        Personnel.dbo.Section 
--SET SectionName = N'م16 فرانچايز امیدیه شهروند شهریور' , namekargah = N'فرانچايز امیدیه شهروند شهریور'  
WHERE  SectionName LIKE  N'%فرانچا%ز ام%د%ه شهروند %' AND 	Sectionid = 7175
 

SELECT * FROM      [CentralWH1\NODE].OKMasterData.dbo.mdSection
-- SET mdSectionDS =  N'م16 فرانچايز امیدیه شهروند شهریور'
WHERE mdSectionDS LIKE  N'%فرانچا%ز ام%د%ه شهروند %' AND mdSectionSN = 7175


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
--SET Dsc =  N'فرانچايز امیدیه شهروند شهریور'  , UnqStr = N'فرانچايزامیدیهشهروندشهریور'
WHERE Dsc LIKE  N'%فرانچا%ز ام%د%ه شهروند %' AND AnbarSN = 8647.199




------------------------------------------------------------------------------------------------------------------POS
SELECT * FROM            pos..Store 
  --SET sname = N'فرانچايز امیدیه شهروند شهریور'   
WHERE    SName LIKE   N'%فرانچا%ز ام%د%ه شهروند %' AND  StoreId = 8877.199



--SELECT * FROM pos..Store_TrgLog
--WHERE StoreId = 7146.199





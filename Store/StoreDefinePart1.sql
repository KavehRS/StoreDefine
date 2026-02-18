SELECT
    a.mdRegionSN,
    a.mdCitySN,
    a.akAmlakNO,
    a.akAmlakDS, 
    a.akAmlakAddress,
    a.akAmlakPostalCode,
    a.mdSectionSN,
    a.mdRegionSubSN,
    a.mdDistrictSN,
    d.mdDistrictDS,
    c.mdCityDS,
    c.mdProvinceSN
FROM 
    [CENTRALWH1\NODE].OKMali.dbo.akamlak a
JOIN 
    [CENTRALWH1\NODE].okmasterdata.dbo.mdDistrict d
    ON a.mdDistrictSN = d.mdDistrictSN  -- Corrected: Added ON clause for district
JOIN 
    [CENTRALWH1\NODE].okmasterdata.dbo.mdCity c
    ON a.mdCitySN = c.mdCitySN
WHERE 
    a.akAmlakNO =    5637642897       ;






SELECT * FROM  [CentralWH1\NODE].okmasterdata.dbo.mdCitypos WHERE mdCityposDS  LIKE N'%اس%و%' AND mdProvincePosSN = N'3.301'

--SELECT * FROM  [CentralWH1\NODE].okmasterdata.dbo.mdCity   WHERE mdcityno = 10300


--Select * From mdVWCity_DataDropDown 
 

////////////////////////////////////////////////////////////////////////////////////////////////////


-- اجرای SP با مقداردهی فقط ورودی‌های اجباری
USE POS
EXEC dbo.StoreDefinePart1
    @akamlakno = 5637642897               ,    -- شماره ملک مورد نظر
    @City = 301.301 ;            -- شناسه شهر



	SELECT * FROM dbo.StoreDefinePart1


	SELECT * FROM ostandata --districs
	SELECT * FROM area --reg

	SELECT * FROM  pos..Store 
--	SET SName = N'فروشگاه تبريز ارتش جنوبي-حذف'
	WHERE SCode = 11018


	Select * From mdVWCity_DataDropDown 



	vwcity
-- 
















 use POS	
SELECT * FROM   Store   WHERE  sname like  N'%فروشگاه اهواز ادهم رود%'


select * from pos..store
WHERE SName LIKE N'%فروشگاه %رمان زنگ% آباد%';


SELECT * FROM  Tadarokat..tTadarokat
WHERE Sharh LIKE N'%ناران%'



SELECT * FROM  anbar..aAnbar
WHERE Dsc LIKE  N'%ناران%'







EXEC sp_helptext StoreDefinePart1

EXEC sp_helptext mdSPDep_Adi_Insert_V2 





--  بررسی و ثبت فروشگاه با ادامه اجرای عملیات در صورت عدم تکراری بودن یا 

----- central		
--SELECT  * FROM    [CENTRALWH1\NODE].OKMali.dbo.akamlak WHERE akAmlakNO = 4254259580



-- WHERE mdRegionSN = 9.199


-- SELECT  * FROM  [CENTRALWH1\NODE].[OKMasterData].[dbo].[mdRegion]
-- SELECT  * FROM   [CENTRALWH1\NODE].[OKMasterData].[dbo].[mdDistrict] WHERE mdDistrictSN = 
-- SELECT  * FROM    [CENTRALWH1\NODE].OKMali.dbo.PAPCITY where  CityId = 1901.301

SELECT * FROM OKMasterData..mdRegionSub 
SELECT * FROM   OKMasterData..mddistrict WHERE mdDistrictSN = 3




SELECT 
    rs.mdRegionSubSN      AS RegionSubSN,
    rs.*,
    d.*
FROM OKMasterData..mdRegionSub rs
FULL OUTER JOIN OKMasterData..mddistrict d
    ON rs.mdRegionSubSN = d.mdRegionSubSN
--HERE mdDistrictDS LIKE N'%بروج%'	
	;

	SELECT * FROM OKMasterData..mdRegionSub
	SELECT * FROM OKMasterData..mddistrict
	-- log SELECT * FROM dbo.mdRegionSub_TRGLOG

----SELECT * FROM  [CentralWH1\NODE].okmasterdata.dbo.mdCitypos WHERE mdCityposDS  LIKE N'%بندرعباس%'   SELECT * FROM  [CentralWH1\NODE].okmasterdata.dbo.mdProvince WHERE  mdProvinceDS LIKE N'%خراس%'                                                 
--SELECT * FROM [CentralWH1\NODE].okmasterdata.dbo.mdcountry
--SELECT * FROM [CentralWH1\NODE].okmasterdata.dbo.mdprovince WHERE mdCountrySN = 1.101
--SELECT * FROM [CentralWH1\NODE].okmasterdata.dbo.mdregion
--SELECT * FROM [CentralWH1\NODE].okmasterdata.dbo.mdregionsub
--SELECT mdDistrictDS FROM [CentralWH1\NODE].okmasterdata.dbo.mdDistrict WHERE mdDistrictSN = 6
-- SELECT  * FROM    [CENTRALWH1\NODE].OKMali.dbo.akamlak WHERE akAmlakNO = 4254259592 
----SELECT  * FROM    [CENTRALWH1\NODE].OKMali.dbo.EPMCITY 
--SELECT * FROM  [CentralWH1\NODE].okmasterdata.dbo.mdCitypos WHERE mdCityposDS  LIKE N'%تهران%' 
--SELECT * FROM  [CentralWH1\NODE].okmasterdata.dbo.mdProvince WHERE  mdProvinceDS LIKE N'%تهران%'  
--SELECT  * FROM    [CENTRALWH1\NODE].OKMali.dbo.akamlak WHERE akAmlakNO = 4254259588 
--SELECT  * FROM    [CENTRALWH1\NODE].OKMali.dbo.EPMCITY
 ----SELECT  * FROM    [CENTRALWH1\NODE].OKMali.dbo.EPMCITY
 --SELECT * FROM  [CentralWH1\NODE].okmasterdata.dbo.mdCitypos WHERE mdCityposNO = 2838
--SELECT * FROM dbo.mdcity WHERE mdCitySN = 10788
--SELECT * FROM  [CentralWH1\NODE].okmasterdata.dbo.mdCitypos WHERE mdCityposDS  LIKE N'%زنجان%' 
--SELECT * FROM  [CentralWH1\NODE].okmasterdata.dbo.mdProvince WHERE  mdProvinceDS LIKE N'%م%ناب%'  



--SELECT  * FROM    [CENTRALWH1\NODE].OKMali.dbo.EPMCITY



 select * from okmasterdata.dbo.mdVWCity_DataDropDown 


	select  aarea , adistrict ,code, placename,* from prd_OKBPMS


	///////////////////////////////////////////////////////////////
	
-- چک کردن ایجاد کاست سنتر AX2012
SELECT * FROM  [centralwh1\node].okmasterdata.dbo.mdCostCenterAX
WHERE mdCostCenterAXValue LIKE N'%OKR%' --AND mdCostCenterAXValue IN (N'OKR09173')
ORDER BY mdCostCenterAXValue DESC

	 




--- prd_OKBPMS -- okdc30038\node

SELECT * FROM LC_PropertyDetails
SELECT * FROM mdVWCity_DataDropDown
SELECT * FROM vw_LC_PropertyDetails
SELECT * FROM LC_LegalContract
SELECT * FROM LC_PropertyDetails


EXEC sp_helptext CENTRALWH.OKMasterData.dbo.mdSPDep_Adi_Insert_V2

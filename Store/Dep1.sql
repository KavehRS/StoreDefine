

USE POS
GO
-- بررسی ساختار دقیق ستون‌ها
--SELECT 
--    COLUMN_NAME,
--    DATA_TYPE,
--    IS_NULLABLE,
--    CHARACTER_MAXIMUM_LENGTH
--FROM INFORMATION_SCHEMA.COLUMNS 
--WHERE TABLE_NAME = 'mdDep'
--ORDER BY ORDINAL_POSITION;

-- INSERT با تمام فیلدهای NOT NULL
DECLARE @NewId INT = (SELECT ISNULL(MAX(mdDepSN), 0) + 1 FROM dbo.mdDep);
DECLARE @CurrentDate CHAR(8) = FORMAT(GETDATE(), 'yyyyMMdd', 'Fa-IR');

INSERT INTO dbo.mdDep (
    mdDepSN,            -- NOT NULL - کد اصلی
    mdDepNO,            -- NOT NULL - شماره
    mdStoreSN,          -- NOT NULL - کد فروشگاه
    mdDepDS,            -- NOT NULL - نام
    mdDepCodeMarkaz,    -- NULLable
    mdDepCodeMoin,      -- NOT NULL - کد معین
    mdDepCodeModir,     -- NULLable
    mdDepActive,        -- NOT NULL - فعال
    UserSN_Insert,      -- NULLable
    UserSN_Edit,        -- NULLable
    Date_Insert,        -- NOT NULL - تاریخ ایجاد
    mdDepGroupSN,       -- NULLable
    mdDepParentSN,      -- NOT NULL - والد
    mdRegionSN,         -- NULLable
    mdDepSubGroupSN,    -- NULLable
    mdCostCenterSN,     -- NULLable
    mdCostCenterAxSn,   -- NULLable
    mdSectionSN,        -- NOT NULL - بخش
    mdDepTypeSN,        -- NOT NULL - نوع
    mdDepActivityTypeSN,-- NOT NULL - نوع فعالیت
    mdLocationBizagiSN, -- NULLable
    mdDepDepIdNajm,     -- NULLable
    mdDepVerDate,       -- NOT NULL - تاریخ تایید
    mdDepIsDeleted,     -- NOT NULL - حذف شده
    mdDepIsFranchise,   -- NOT NULL - فرانچایز
    mdRegionSubSN,      -- NULLable
    mdCitySN,           -- NULLable
    mdDistrictSN,       -- NULLable
    mdDepAXRecID        -- NULLable
)
VALUES (
    @NewId,             -- mdDepSN
    @NewId,             -- mdDepNO
    9345.199,            -- mdStoreSN (تغییر بدهید)
    N' فروشگاه مشهد امامیه 56',     -- mdDepDS
    -1,                 -- mdDepCodeMarkaz
    7101,               -- mdDepCodeMoin
    NULL,               -- mdDepCodeModir
    1,                  -- mdDepActive
    NULL,               -- UserSN_Insert
    NULL,               -- UserSN_Edit
    NULL ,       -- Date_Insert
    NULL,               -- mdDepGroupSN
    0,                  -- mdDepParentSN (مهم! صفر یا کد معتبر)
    8.199,               -- mdRegionSN
    NULL,               -- mdDepSubGroupSN
    NULL,               -- mdCostCenterSN
    NULL,               -- mdCostCenterAxSn
    0,                  -- mdSectionSN (مهم!)
    2,                  -- mdDepTypeSN
    3,                  -- mdDepActivityTypeSN
    NULL,               -- mdLocationBizagiSN
    NULL,               -- mdDepDepIdNajm
    @CurrentDate,       -- mdDepVerDate
    0,                  -- mdDepIsDeleted
    0,                  -- mdDepIsFranchise
    88,               -- mdRegionSubSN
	
--SELECT * FROM OKMasterData..mdRegionSub where mdRegionSN = 7.199 AND mdRegionSubDS LIKE '%خو%'
--SELECT * FROM OKMasterData..mddistrict WHERE mdDistrictDS LIKE '%خو%'
    1101.301,                  -- mdCitySN 		 -- SELECT * FROM  [CentralWH1\NODE].okmasterdata.dbo.mdCitypos WHERE mdCityposDS  LIKE N'%اصفهان%'   SELECT * FROM  [CentralWH1\NODE].okmasterdata.dbo.mdProvince WHERE  mdProvinceDS LIKE N'%ردستان%'                                                          
	 -- SELECT * FROM  [CentralWH1\NODE].okmasterdata.dbo.mdCitypos WHERE mdCityposDS  LIKE N'%خو%'   SELECT * FROM  [CentralWH1\NODE].okmasterdata.dbo.mdProvince WHERE  mdProvinceDS LIKE N'%ردستان%'                                                          

    79,               -- mdDistrictSN
    NULL                -- mdDepAXRecID
);

SELECT 'ایجاد شد با کد: ' + CAST(@NewId AS VARCHAR(10)) AS Result;




























\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

SELECT * FROM  dbo.mdDep WHERE mdStoreSN = 9337.199
UPDATE  dbo.mdDep
SET  mdRegionSubSN = 56, mdDepIsDeleted = NULL , mdDistrictSN = 56
WHERE mdStoreSN = 9321.199



SELECT * FROM pos..store 
WHERE StoreId = 9337.199


SELECT * FROM OKMasterData..mdRegionSub where mdRegionSN = 8.199 AND mdRegionSubDS LIKE '%مشهد C%'
SELECT * FROM OKMasterData..mddistrict WHERE mdDistrictDS LIKE '%مشهد C%'


SELECT * FROM  [CentralWH1\NODE].okmasterdata.dbo.mdCitypos WHERE mdCityposDS  LIKE N'%مشهد%'   SELECT * FROM  [CentralWH1\NODE].okmasterdata.dbo.mdProvince WHERE  mdProvinceDS LIKE N'%ردستان%'                                                          

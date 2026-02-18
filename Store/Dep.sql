

-- غیرفعال کردن triggerهای مختلف برای جلوگیری از خطا در حین اجرا
-- غیرفعال کردن trigger بررسی تکراری نبودن دسترسی کاربران
--*********************************************************************
--********************************************************************* KOUROSHSTOREdb
		
--		--		DECLARE @aarea numeric(18,3)
--		--SET @aarea = (SELECT aarea  FROM pos .. LC_PropertyDetails WHERE code = 9498 )
--		----SELECT pos .. areaDescription FROM area WHERE idArea = @aarea 
--		--PRINT @aarea
----	SELECT * FROM OKMasterData..mddistrict
----SELECT * FROM mdprovince 

--SELECT * FROM LC_PropertyDetails WHERE code = 9363
--SELECT * FROM vw_LC_LegalContract_total



--SELECT * FROM LC_PropertyDetails WHERE code = 9459 
--SELECT * FROM vw_LC_LegalContract_total WHERE needCC = 0
--SELECT * FROM vw_LC_LegalContract
--select  * from LC_LegalContract where needCC = 0

--SELECT * FROM LC_PropertyDetails WHERE code = 9363
--select  * from LC_LegalContract where needCC = 0

--SELECT * FROM vwsection
--7496

--select * from mdVWDistrict_Bizagi_Da --دیستریکت 
--SELECT * FROM mdVwSection_Bizagi --محل استقرار  
-- select * FROM ostandata

--SELECT * FROM mdvwcity_datadropdown
--SELECT * FROM area
--SELECT * FROM district
-- select * FROM ostandata
----select  * from LC_LegalContract



select  lc.code, a.areaDescription , lc.adistrict , lc.placename, lc.Address, lc.ZipCode , o.mdProvinceSN, o.mdProvinceDS, lc.* 
FROM prd_OKBPMS.. LC_PropertyDetails lc
	FULL OUTER JOIN prd_OKBPMS .. area a
	ON lc.aarea = a.idArea
		FULL OUTER JOIN prd_OKBPMS .. ostandata o
	ON lc.adistrict = o.idostanData
WHERE code =  9670                        



/////////////////////////////////////////////////////////////////////

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


 --USE Anbar
 --GO
 --DISABLE TRIGGER dbo.Tr_Checkaanbar ON dbo.aAnbar -- Disable





-- تنظیم XACT_ABORT برای مدیریت خطاها در تراکنش‌ها
SET XACT_ABORT ON;


-- استفاده از دیتابیس POS به عنوان دیتابیس پیش‌فرض
USE POS
GO

-- تعریف متغیرهای مورد نیاز
DECLARE @store numeric(18,3)       -- آیدی فروشگاه
DECLARE @p2 numeric(18,3)          -- آیدی تدارکات
DECLARE @p3 numeric(18,3)          -- آیدی هواداری
DECLARE @p4 numeric(18,3)          -- آیدی مالیات
DECLARE @p5 numeric(18,3)          -- آیدی کارتخوان
DECLARE @p6 numeric(18,3)          -- آیدی صندوق
DECLARE @p7 numeric(18,3)          -- آیدی کاست سنتر
DECLARE @p8 numeric(18,3)          -- آیدی دپارتمان
DECLARE @depid int                 -- آیدی دپارتمان
DECLARE @City numeric(18,3)= 2809.301 -- آیدی شهر 
		 -- SELECT * FROM  [CentralWH1\NODE].okmasterdata.dbo.mdCitypos WHERE mdCityposDS  LIKE N'%تهران%'   SELECT * FROM  [CentralWH1\NODE].okmasterdata.dbo.mdProvince WHERE  mdProvinceDS LIKE N'%ردستان%'                                                          
DECLARE @Identifier NUMERIC(18, 4) = 0.0000 -- شناسه منحصر به فرد
DECLARE @code char(5) = 0          -- کد فروشگاه
DECLARE @Date VARCHAR(8)=format(getdate(),'yyMMdd',N'fa-ir') -- تاریخ جاری
DECLARE @Userid INT = 29700        -- آیدی کاربر ایجادکننده
DECLARE @Cost_CODE VARCHAR(20)=0   -- کد هزینه
DECLARE @cost_DESC VARCHAR(100)= N'فروشگاه تهران تهرانپارس باقری 216' -- نام فروشگاه
DECLARE @Actual_desc VARCHAR(100)=(SELECT REPLACE((@cost_DESC), ' ', '')) -- نام بدون فاصله
DECLARE @Sname varchar(200)=(@cost_DESC) -- نام فروشگاه
DECLARE @scode varCHAR(10) = 0     -- کد فروشگاه7
DECLARE @akamlakno bigint = 0      -- شماره اموال
DECLARE @EstateID decimal(18,3)= NULL --(SELECT akamlaksn FROM [CENTRALWH1\NODE].OKMali.dbo.akVWamlak_CreateDep_Adi WHERE akamlakno=  4254259467) -- آیدی ملک
DECLARE @Regionid decimal(18,3)= 1.199 --(SELECT mdregionsn FROM [CENTRALWH1\NODE].OKMali.dbo.akVWamlak_CreateDep_Adi WHERE akamlakno=  4254259467) -- آیدی منطقه
DECLARE @akAmlakDs nvarchar(50)= (@cost_DESC) --(SELECT akAmlakDs FROM [CENTRALWH1\NODE].OKMali.dbo.akVWamlak_CreateDep_Adi WHERE akamlakno=  4254259467) -- نام ملک
DECLARE @tadarokatno INT =(SELECT MAX(TadarokatNO+1) FROM Tadarokat..tTadarokat) -- شماره تدارکات

--SELECT * FROM pos..store WHERE SName LIKE N'%  فروشگاه اسلامشهر واوان بلوار منتطری%'
--SELECT * FROM [CENTRALWH1\NODE].OKMali.dbo.akVWamlak_CreateDep_Adi WHERE akamlakno=  4254259467
-- محاسبه کد فروشگاه جدید
-- با گرفتن آخرین کد و اضافه کردن 1 به آن
SET @scode = (SELECT TOP 1 (scode + 1) FROM POS.dbo.Store ORDER BY StoreId DESC)
SET @code = cast(@scode as int);



-- یافتن شناسه منحصر به فرد برای فروشگاه
-- این حلقه از 0.1593 شروع می‌شود و تا 0.9999 ادامه می‌یابد
-- و اولین شناسه خالی را پیدا می‌کند که در هیچ یک از جداول استفاده نشده باشد
DECLARE @IdentifierTemp DECIMAL(18, 4);
SET @IdentifierTemp = 0.1593;
WHILE @IdentifierTemp <= 0.9999 AND @Identifier = 0.000
BEGIN
    IF (
        (SELECT COUNT(*) FROM POS.dbo.Store WHERE Identifier = @IdentifierTemp) = 0
        AND (@IdentifierTemp * 1000) % 10 <> 0
        AND (
            (SELECT COUNT(*) FROM Tadarokat.dbo.tTadarokat WHERE Identifier = @IdentifierTemp) = 0
        )
        AND (
            (SELECT COUNT(*) FROM Anbar.dbo.aAnbar WHERE Identifier = @IdentifierTemp) = 0
        )
    )
    BEGIN
        SET @Identifier = @IdentifierTemp;
        PRINT @Identifier
    END
    SET @IdentifierTemp = @IdentifierTemp + 0.0001;
END;

-- محاسبه آیدی فروشگاه جدید
SELECT @store = MAX(StoreId)+1 FROM pos..Store

-- درج اطلاعات فروشگاه در جدول Store
-- توجه: AnbarId به صورت صریح NULL تنظیم شده است
INSERT INTO Store(
    [StoreId], [SCode], [SName], [Addr], [CityId], [AnbarId], 
    [Identifier], [CostCode], [TelNum], [IUserId], [IDate], 
    [UUserId], [UDate], [StoreTCode], [StoreMCode], [StoreCCode],
    [StoreMCodeR0], [StoreMCodeR1], [Area], [Rent], [RegionId], [EstateID], [isactive]
)
VALUES(
    @store, @code, @Sname, NULL, @City, NULL, 
    @Identifier, NULL, NULL, @Userid, @Date, 
    NULL, NULL, NULL, NULL, @Cost_CODE,
    NULL, NULL, $0.0000, 1, @Regionid, @EstateID, 1
)



	 
		----------------------------------------------------تدارکات
		select @p2 =  max(tadarokatsn)+1 from Tadarokat..tTadarokat
		exec tadarokat..tTadarokat_Insert @p2 output,@Sname,@tadarokatno,@Identifier,NULL,NULL,NULL,NULL,NULL

		----------------------------------------------------هواداری

		select @p3 =  max(DiscStoreId)+1 from pos..DiscountStore
		exec POS..DiscountStore_Insert @p3 output,31.199,@store,NULL,NULL,NULL,NULL

		----------------------------------------------------مالیات

		select @p4 =  max(VatStoreId)+1 from pos..VatStore
		exec POS..VatStore_Insert @p4 output,1.199,@store,NULL,NULL,NULL,NULL

		----------------------------------------------------صندوق

		select @p6 = MAX(cashid) + 1 from  pos..Cash
		exec POS..SP_Cash_Insert @p6 output,N'90','صندوق شماره 1',@store,1,26071,@Date,NULL,NULL,NULL,NULL,NULL,0

		select @p6 = MAX(cashid) + 1 from  pos..Cash
		exec POS..SP_Cash_Insert @p6 output,N'91','صندوق شماره 2',@store,1,26071,@Date,NULL,NULL,NULL,NULL,NULL,0

		select @p6 = MAX(cashid) + 1 from  pos..Cash
		exec POS..SP_Cash_Insert @p6 output,N'92','صندوق شماره 3',@store,1,26071,@Date,NULL,NULL,NULL,NULL,NULL,0

		select @p6 = MAX(cashid) + 1 from  pos..Cash
		exec POS..SP_Cash_Insert @p6 output,N'93','صندوق شماره 4',@store,1,26071,@Date,NULL,NULL,NULL,NULL,NULL,0
		




		SELECT * FROM pos..store
		WHERE Identifier=@Identifier

		SELECT * FROM Tadarokat..tTadarokat
		WHERE Identifier=@Identifier





---- نمایش نتایج نهایی برای بررسی

SELECT * FROM  pos .. Store 
   -- SET SName = N'فروشگاه خمینی شهر سه راه رجایی'
WHERE  sname LIKE  N'فروشگاه تهران تهرانپارس باقری 216'
---- -- AND 


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






--SELECT * FROM  
--Tadarokat..tTadarokat 
----   -- SET Sharh = N'فروشگاه خمینی شهر سه راه رجایی'
--WHERE Sharh LIKE  N'%فروشگاه اصفهان %اوه سوانح سوختگ%'






















-- بررسی ساختار دقیق ستون‌ها
--SELECT 
--    COLUMN_NAME,
--    DATA_TYPE,
--    IS_NULLABLE,
--    CHARACTER_MAXIMUM_LENGTH
--FROM INFORMATION_SCHEMA.COLUMNS 
--WHERE TABLE_NAME = 'mdDep'
--ORDER BY ORDINAL_POSITION;



-- INSERT با تمام فیلدهای NOT NULL    ---- centeral - 
USE Okmasterdata
go
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
    9581.199,            -- mdStoreSN (تغییر بدهید)
    N'فروشگاه تهران تهرانپارس باقری 216',     -- mdDepDS
    -1,                 -- mdDepCodeMarkaz
    7101,               -- mdDepCodeMoin
    NULL,               -- mdDepCodeModir
    1,                  -- mdDepActive
    NULL,               -- UserSN_Insert
    NULL,               -- UserSN_Edit
    NULL ,       -- Date_Insert
    NULL,               -- mdDepGroupSN
    0,                  -- mdDepParentSN (مهم! صفر یا کد معتبر)
    1.199,               -- mdRegionSN
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
    4,               -- mdRegionSubSN
	
		   --SELECT * FROM OKMasterData..mdRegionSub where mdRegionSN = 1.199 AND mdRegionSubDS LIKE '%تهرانپارس%'
		   --SELECT * FROM OKMasterData..mddistrict WHERE mdDistrictDS LIKE '%تهرانپارس%'
   2809.301,                  -- mdCitySN 		 -- SELECT * FROM  [CentralWH1\NODE].okmasterdata.dbo.mdCitypos WHERE mdCityposDS  LIKE N'%زاهدان%'   SELECT * FROM  [CentralWH1\NODE].okmasterdata.dbo.mdProvince WHERE  mdProvinceDS LIKE N'%ردستان%'                                                          
	 -- SELECT * FROM  [CentralWH1\NODE].okmasterdata.dbo.mdCitypos WHERE mdCityposDS  LIKE '%زاهدان%'   SELECT * FROM  [CentralWH1\NODE].okmasterdata.dbo.mdProvince WHERE  mdProvinceDS LIKE N'%ردستان%'                                                          

    5,               -- mdDistrictSN
    NULL                -- mdDepAXRecID
);

SELECT 'ایجاد شد با کد: ' + CAST(@NewId AS VARCHAR(10)) AS Result;






















\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

SELECT * FROM  dbo.mdDep WHERE mdStoreSN = 9331.199
UPDATE  dbo.mdDep
SET  mdRegionSubSN = 56, mdDepIsDeleted = NULL , mdDistrictSN = 56
WHERE mdStoreSN = 9321.199



SELECT * FROM pos..store 
WHERE StoreId = 9331.199


SELECT * FROM OKMasterData..mdRegionSub where mdRegionSN = 1.199 AND mdRegionSubDS LIKE '%شهرر%'
SELECT * FROM OKMasterData..mddistrict WHERE mdDistrictDS LIKE '%شهرر%'


SELECT * FROM  [CentralWH1\NODE].okmasterdata.dbo.mdCitypos WHERE mdCityposDS  LIKE N'%مشهد%'  
SELECT * FROM  [CentralWH1\NODE].okmasterdata.dbo.mdProvince WHERE  mdProvinceDS LIKE N'%ردستان%'                                                          








-- تنظیم XACT_ABORT برای مدیریت خطاها در تراکنش‌ها
SET XACT_ABORT ON;


-- استفاده از دیتابیس POS به عنوان دیتابیس پیش‌فرض
USE POS
GO

DECLARE @cost_DESC VARCHAR(100)=N'فروشگاه تهران کارگر چنگیزی' -- نام فروشگاه
DECLARE @Actual_desc VARCHAR(100)=(SELECT REPLACE(N'فروشگاه تهران کارگر چنگیزی', ' ', '')) -- نام بدون فاصله
DECLARE @Sname varchar(200)=(@cost_DESC) -- نام فروشگاه
DECLARE @p2 numeric(18,3)          -- آیدی تدارکات
DECLARE @tadarokatno INT =(SELECT MAX(TadarokatNO+1) FROM Tadarokat..tTadarokat) -- شماره تدارکات

		select @p2 =  max(tadarokatsn)+1 from Tadarokat..tTadarokat
		exec tadarokat..tTadarokat_Insert @p2 output,@Sname,@tadarokatno, """"@Identifier"""",NULL,NULL,NULL,NULL,NULL
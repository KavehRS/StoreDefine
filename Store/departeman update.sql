-- Centeralwh
	
SELECT scode, Sname  FROM  POS..Store   WHERE  sname like  N'%فروشگاه رفسنجان م%رزا% دو%'  -- برای پیدا کردن scode
SELECT * FROM [CENTRALWH1\NODE].okmasterdata.dbo.mddep where mddepds LIKE   N'%فروشگاه رفسنجان م%رزا% دو%'     -- برای پیدا کردن scode




SELECT * FROM  [CENTRALWH1\NODE].okmasterdata.dbo.mdCostCenterAX where mdCostCenterAXvalue LIKE '%OKR10758%'  -- برای mdcostcenteraxsn

-- D365 Server -- OKDC32013
SELECT RECID,* FROM OperationalDB.ax.OMOPERATINGUNITENTITY WHERE OPERATINGUNITNUMBER LIKE '%OKR10758%'   -- برای mdDepAXRecID


-- Centeralwh

 UPDATE  [CENTRALWH1\NODE].okmasterdata.dbo.mddep 
   SET mdcostcenteraxsn = 5645801847 ,
       mdDepAXRecID     = 5637590804
 where mddepsn = 13757




-- چک کردن ایجاد کاست سنتر AX2012
SELECT * FROM  [centralwh1\node].okmasterdata.dbo.mdCostCenterAX
WHERE mdCostCenterAXValue LIKE N'%OKR%' --AND mdCostCenterAXValue IN (N'OKR09173')
ORDER BY mdCostCenterAXValue DESC





OKS10412 
SELECT * FROM  [CENTRALWH1\NODE].okmasterdata.dbo.mddep 
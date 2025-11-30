-- Centeralwh
-- برای mdcostcenteraxsn & StoreNumber
SELECT  s.sname, s.Scode, ax.mdCostCenterAXRecId, m.mddepsn FROM  POS..Store s
JOIN [CENTRALWH1\NODE].okmasterdata.dbo.mddep m ON s.storeid = m.mdstoresn 
JOIN [CENTRALWH1\NODE].okmasterdata.dbo.mdCostCenterAX ax ON ax.mdCostCenterAXValue LIKE '%'+CAST(s.scode AS VARCHAR(20))+'%'
WHERE s.SName like  N'%فروشگاه م%بد بهشت%' 



-- D365 Server -- OKDC32013
SELECT RECID,* FROM OperationalDB.ax.OMOPERATINGUNITENTITY WHERE OPERATINGUNITNUMBER LIKE '%OKR10938%'   -- برای mdDepAXRecID


-- Centeralwh

 UPDATE  [CENTRALWH1\NODE].okmasterdata.dbo.mddep 
   SET mdcostcenteraxsn = 5645932326 ,
       mdDepAXRecID     = 5637595374
 where mddepsn = 14064





-- چک کردن ایجاد کاست سنتر AX2012
SELECT * FROM  [centralwh1\node].okmasterdata.dbo.mdCostCenterAX
WHERE mdCostCenterAXValue LIKE N'%OKR%' --AND mdCostCenterAXValue IN (N'OKR09173')
ORDER BY mdCostCenterAXValue DESC




-- Centeralwh
-- برای mdcostcenteraxsn & StoreNumber


SELECT  s.sname, s.Scode, ax.mdCostCenterAXRecId, m.mddepsn FROM  POS..Store s
JOIN [CENTRALWH1\NODE].okmasterdata.dbo.mddep m ON s.storeid = m.mdstoresn 
JOIN [CENTRALWH1\NODE].okmasterdata.dbo.mdCostCenterAX ax ON ax.mdCostCenterAXValue LIKE '%'+CAST(s.scode AS VARCHAR(20))+'%'
--WHERE mddepsn = 14782
WHERE Scode = 11310
--WHERE s.SName like  N'%فروشگاه تهران %هر%ز%ول%عصر%' 

 SELECT  * FROM [CENTRALWH1\NODE].okmasterdata.dbo.mdCostCenterAX where mdCostCenterAXValue =
'OKR11310'

OKS


SELECT  * FROM  POS..Store

-- D365 Server -- OKDC32013
SELECT RECID,NAME FROM OperationalDB.ax.OMOPERATINGUNITENTITY WHERE OPERATINGUNITNUMBER LIKE '%11310%'   -- برای mdDepAXRecID



-- Centeralwh

 UPDATE  [CENTRALWH1\NODE].okmasterdata.dbo.mddep 
   SET mdcostcenteraxsn = 5646234576 ,   --mdCostCenterAXRecId
       mdDepAXRecID     = 5637608633  --RECID
 where mddepsn = 15022




-- چک کردن ایجاد کاست سنتر AX2012
SELECT * FROM  [centralwh1\node].okmasterdata.dbo.mdCostCenterAX
WHERE mdCostCenterAXValue LIKE N'%OKR%' --AND mdCostCenterAXValue IN (N'OKR09173')
ORDER BY mdCostCenterAXValue DESC






SELECT  * FROM  POS..Store s
SELECT  * FROM [CENTRALWH1\NODE].okmasterdata.dbo.mddep 
SELECT  * FROM [CENTRALWH1\NODE].okmasterdata.dbo.mdCostCenterAX 















--SELECT  s.Scode, ax.mdCostCenterAXRecId FROM  POS..Store s
--JOIN [CENTRALWH1\NODE].okmasterdata.dbo.mddep m ON s.storeid = m.mdstoresn 
--JOIN [CENTRALWH1\NODE].okmasterdata.dbo.mdCostCenterAX ax ON ax.mdCostCenterAXValue LIKE '%'+CAST(s.scode AS VARCHAR(20))+'%'
--WHERE mddepsn = 14782








 --SELECT * FROM ttadarokat WHERE sharh = N'%نوشهر%'




SELECT * FROM [CENTRALWH1\NODE].okmasterdata.dbo.mdCostCenterAX 


SELECT * FROM  [CENTRALWH1\NODE].okmasterdata.dbo.mddep  where mddepsn = 14704


--SELECT * FROM [CENTRALWH1\NODE].okmasterdata.dbo.mddep  where mddepsn = 14862
--sp_help 'mddep'

SELECT * FROM [CENTRALWH1\NODE].okmasterdata.dbo.mdCostCenterAX













 --SELECT * FROM [CENTRALWH1\NODE].okmasterdata.dbo.mddep WHERE mddepsn = 11201

 --SELECT *  FROM [CENTRALWH1\NODE].okmasterdata.dbo.mddep WHERE mdDepCodeMoin = 14782 AND mdcostcenteraxsn IS null



















SELECT * FROM  [CENTRALWH1\NODE].okmasterdata.dbo.mddep 




select  aarea , adistrict ,code, placename,* from lc_propertydetails
EXEC	sp_helptext	mdSPDep_Adi_Insert_V2 
SELECT * FROM pos .. store
SELECT * FROM [CENTRALWH1\NODE].okmasterdata.dbo.mddep WHERE mdDepDS like  N'%فروشگاه مشهد امام%ه 56%' 

SELECT * FROM [CENTRALWH1\NODE].okmasterdata.dbo.mdCostCenterAX
--s.SName like  N'%فروشگاه اس%و خ%ابان ورزش%' 

SELECT * FROM [CENTRALWH1\NODE].okmasterdata.dbo.mdCostCenterAX

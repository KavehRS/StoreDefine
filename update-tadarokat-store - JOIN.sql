

SELECT TadarokatSN,Sharh,S.SCode,res1f, res3f,res5f,* FROM  Tadarokat.dbo.tTadarokat T 
INNER JOIN POS..Store S
ON T.Identifier = S.Identifier
WHERE res1f IS NULL



SELECT TadarokatSN,Sharh,S.SCode,res1f, res3f,res5f,* FROM  Tadarokat.dbo.tTadarokat T 
INNER JOIN POS..Store S
ON T.Identifier = S.Identifier
WHERE SCode IN (
10735
,10738
)
ORDER BY 3 





update tTadarokat set  res1f='10.196.34.200',res3f='OKS10735SRV',res5f='10.196.34.204'
where TadarokatSN =8619.199
update tTadarokat set  res1f='10.196.39.200',res3f='OKS10738SRV',res5f='10.196.39.204'
where TadarokatSN =8622.199
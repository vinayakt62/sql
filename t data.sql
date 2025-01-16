
INSERT INTO dbo.mf_GramPanchayat(PSId, GPName, IsActive)

SELECT PSId as PSId , GMPTName as GPName , 1 as IsActive
FROM a.dbo.mf_GramPanchayat

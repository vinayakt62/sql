


 SELECT  SurgeyProcedure  
      FROM mf_SurgeyProcMaster
      WHERE SurgeyProcId IN( SELECT CAST(Item AS varchar(max)) FROM dbo.SplitString('2,1', ','))



SELECT     	
	a.SurgeyProcId,

     	
(SELECT   STUFF((SELECT Distinct ',' + Cast( CAST(SurgeyProcedure AS varchar(max))   AS VARCHAR(max)) 
FROM         mf_SurgeyProcMaster   WHERE SurgeyProcId IN( SELECT CAST(Item AS varchar(max)) FROM dbo.SplitString(a.SurgeyProcId, ','))
    FOR XML PATH('')),1,1,'')) as a1,

ISNULL(STUFF((SELECT ',' + SurgeyProcedure FROM mf_SurgeyProcMaster WHERE SurgeyProcId in (SELECT CAST(Item AS varchar(max)) FROM dbo.SplitString(a.SurgeyProcId, ',')) FOR XML PATH('')), 1, 1, ''), '') AS SubjectList


FROM   
	mf_PatientPastHistory as a 




SELECT     	
	a.SurgeyProcId



FROM   
	mf_PatientPastHistory as a 




--SELECT CAST(Item AS INTEGER)+',' FROM dbo.SplitString('2,1', ',')

    	

		





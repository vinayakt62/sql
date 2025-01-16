
 (SELECT   STUFF((SELECT Distinct ', ' + Cast(ObjectionNos AS VARCHAR(10)) 
FROM         mf_AuditTrackNosSecond
    FOR XML PATH('')),1,1,''))

SELECT 
	SUM(a.Amount) AS Amount
FROM 
	SmartAgroSoft.dbo.mf_Voucher a 
UNION ALL 
SELECT 
	SUM(a.Amount) AS Amount
FROM 
	SmartAgroSoftBillType.dbo.mf_Voucher a 
UNION ALL 
SELECT 
	SUM(a.Amount) AS Amount
FROM 
	SmartAgroSoftGST.dbo.mf_Voucher a 
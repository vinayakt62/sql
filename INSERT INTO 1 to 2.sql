INSERT INTO mf_OpeningStock (
Product_Id,
Company_Id,
Qty,
BatchNo,
Exp_Date,
Purchase_Price,
TransactionYearId,
Date
)
SELECT     
	Product_Id as  Product_Id,
	Company_Id as Company_Id,
	Qty as Qty,
	BatchNo as BatchNo,
	Exp_Date as Exp_Date,
	Purchase_Price as Purchase_Price,
	2 as TransactionYearId,
	'04/01/2019'as Date
FROM         
		mf_Stock

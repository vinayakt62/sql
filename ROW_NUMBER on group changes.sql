SELECT	
CASE WHEN ROW_NUMBER()  OVER(PARTITION BY  	Account_Type ORDER BY 
	Account_Id   ) = 1 
	THEN  Account_Type  ELSE NULL END AS 'Account_Type',
CASE WHEN ROW_NUMBER()  OVER(PARTITION BY  	Account_Type ORDER BY 
	Account_Id   ) = 1 
	THEN  Account_Id  ELSE NULL END AS 'Account_Type',

 row_number () over (partition by Account_Type order by Account_Type) as row_num ,
	
	--Account_Type,  
	Account_Id, 
	Account_Name
FROM         
	mf_Account
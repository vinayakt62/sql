--SELECT CAST(DATEDIFF(yy, t.birthdatetime, t.visitdatetime) AS varchar(4)) +' year '+
--       CAST(DATEDIFF(mm, DATEADD(yy, DATEDIFF(yy, t.birthdatetime, t.visitdatetime), t.birthdatetime), t.visitdatetime) AS varchar(2)) +' month '+
--       CAST(DATEDIFF(dd, DATEADD(mm, DATEDIFF(mm, DATEADD(yy, DATEDIFF(yy, t.birthdatetime, t.visitdatetime), t.birthdatetime), t.visitdatetime), DATEADD(yy, DATEDIFF(yy, t.birthdatetime, t.visitdatetime), t.birthdatetime)), t.visitdatetime) AS varchar(2)) +' day' AS result
--  FROM (SELECT '2007-01-01' 'birthdatetime',
--         '2009-03-29' 'visitdatetime') t

--select  DATEPART ( datepart , date ) 

--DECLARE @ADate DATETIME
--
--SET @ADate = GETDATE()
--
--SELECT DAY(EOMONTH(@ADate)) AS DaysInMonth

-- SELECT 
--	DATEDIFF(day, ST,ET) AS DateDiff,
--	[Years] = datediff(year,0,ET-ST),
--    [Months]= datepart(month,ET-ST)-1,
--    [Days]	= datepart(day,ET-ST)-1
--        
--from
--        (
--        select  -- Test Data
--                ST = convert(datetime,'2018/01/01'),
--                ET = convert(datetime,'2021/01/08')
--        ) a

--WITH ex_table AS (
--  SELECT '09/13/2005' 'birthdatetime',
--         '10/14/2018' 'visitdatetime')
--SELECT CAST(DATEDIFF(yy, t.birthdatetime, t.visitdatetime) AS varchar(4)) +' year '+
--       CAST(DATEDIFF(mm, DATEADD(yy, DATEDIFF(yy, t.birthdatetime, t.visitdatetime), t.birthdatetime), t.visitdatetime) AS varchar(2)) +' month '+
--       CAST(DATEDIFF(dd, DATEADD(mm, DATEDIFF(mm, DATEADD(yy, DATEDIFF(yy, t.birthdatetime, t.visitdatetime), t.birthdatetime), t.visitdatetime), DATEADD(yy, DATEDIFF(yy, t.birthdatetime, t.visitdatetime), t.birthdatetime)), t.visitdatetime) AS varchar(2)) +' day' AS result
--  FROM ex_table t
--select  DATEPART ( '' , date ) 
--SELECT DATEDIFF(day, '2018/01/01','2020/01/01') AS DateDiff
--Declare @dateofbirth datetime
--Declare @currentdatetime datetime
--Declare @years varchar(4)
--Declare @month varchar(2)
--Declare @Day varchar(2)
--set @dateofbirth = '2018/01/01' --Birthdate
--set @currentdatetime  ='2020/10/01' --Current Datetime
--select @years = datediff(year,@dateofbirth,@currentdatetime)
--select @month = (datediff(month,@dateofbirth,@currentdatetime)/12)
--select @Day = (datediff(Day,@dateofbirth,@currentdatetime))
--select @years + ' Years '+  @month + ' Month '+ @Day   as years
--SELECT DATEDIFF(year, '2018/01/01','2020/01/01') AS DateDiff
--SELECT (DATEDIFF(month, '2018/01/01','2020/01/01')/10) AS DateDiff
--SELECT (DATEDIFF(day, '2018/01/01','2020/01/01')/30) AS DateDiff
--SELECT DATEDIFF(day, '2018/01/01','2020/01/01') AS DateDiff
--SELECT (DATEDIFF(day, '2018/01/01','2020/01/01')/365) AS DateDiff
--SELECT (DATEDIFF(day, '2018/01/01','2020/01/01')/12) AS DateDiff
--SELECT (DATEDIFF(day, '2018/01/01','2020/01/01')/365) AS DateDiff
--SELECT (DATEDIFF(day, Date1,Date)/365) from Table_1
--select  DATEPART ( datepart , date ) 







 --SELECT DATEDIFF(day, Date, Date1)  from Table_1 


--SELECT
--	SrNo,
--	Date,
--	Date1,
--	DATEDIFF(day, Date, Date1) as D_a_y
--from 
--Table_1


Declare @Day bigint
set @Day=4500

select 
	@Day as STR_Day,  
	(@Day/365)as STR_Year ,
	(((@Day)- (365*(@Day/365)))/30)as STR_Month ,
	(@Day-(365*(@Day/365)) -(30*(((@Day)- (365*(@Day/365)))/30)))as STR_Day 























  
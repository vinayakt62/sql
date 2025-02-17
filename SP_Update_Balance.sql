

ALTER PROC [dbo].[SP_Update_Balance]  --SP_Update_Balance @Tr_Date='2017/02/14',@Company_ID=1,@Current_TransactionAmt=1000,@OperationOn='CustTR'
@Tr_Date nvarchar(10),
@Company_ID int=null,
@Current_TransactionAmt decimal(18,2)=null,-- <--Current Transaction Amount
@OperationOn varchar(50)
AS
BEGIN
declare @Temp_BalUpdate table
(
Comp_ID int,
Bal_Date datetime,
OpenAmt decimal(18,2),
CloseAmt decimal(18,2)
)
declare @Bal_Date datetime
declare @Comp_ID int
declare @Opening_Balance decimal(18,2)
declare @Closing_Balance decimal(18,2)
declare @BackDate datetime

declare @count int
set @count=1
set @Bal_Date=(select Date from Opening_Balance where Org_ID=@Company_ID and Date=@Tr_Date)

insert into @Temp_BalUpdate 
select * from Opening_Balance where Date>=@Tr_Date order by Date
--select* from Opening_Balance where Date>='2017/02/20' order by Date
declare UpdateBal cursor for	
select * from @Temp_BalUpdate
where Bal_Date>=@Tr_Date

if @OperationOn='CustTR'
begin
	if exists(select 1 from Opening_Balance where Date=@Tr_Date)
	begin
		OPEN UpdateBal
				
		fetch next from UpdateBal into @Comp_ID,@Bal_Date,@Opening_Balance,@Closing_Balance
		while @@FETCH_STATUS=0
		begin
			set @Bal_Date=(select Bal_Date from @Temp_BalUpdate where Comp_ID=@Company_ID and Bal_Date=@Bal_Date)		
			set @Opening_Balance=(select OpenAmt from @Temp_BalUpdate where Bal_Date=@Bal_Date)
			set @Closing_Balance=(select CloseAmt from @Temp_BalUpdate where Bal_Date=@Bal_Date)
		
			if @Bal_Date=@Tr_Date
			begin
				set @count=1
			end
			if @count=1
			begin
				set @Closing_Balance=@Closing_Balance+@Current_TransactionAmt
				set @count=@count+1
			end
			else
			begin
				--set @Bal_Date=(select Bal_Date from @Temp_BalUpdate where Comp_ID=@Company_ID and Bal_Date=@Tr_Date)
				set @Opening_Balance=@Opening_Balance+@Current_TransactionAmt
				set @Closing_Balance=@Closing_Balance+@Current_TransactionAmt
			end
			
		UPDATE Opening_Balance set Opening_Amount=@Opening_Balance,Closing_Amount=@Closing_Balance
		where Org_ID=@Comp_ID and Date=@Bal_Date		
			
		fetch next from UpdateBal into @Comp_ID,@Bal_Date,@Opening_Balance,@Closing_Balance
		end
		Close UpdateBal
		Deallocate UpdateBal
	end
	else
	begin	  
	----declare @Current_ClosingAmt decimal(18,2)
	----set @Opening_Balance=(select Closing_Balance from Opening_Balance where Date=(select MAX(Date) from Opening_Balance))
	--
	--set @BackDate=(select MAX(Date) from Opening_Balance where Date<@Tr_Date)
	--set @Opening_Balance=(select Closing_Balance from Opening_Balance where Date=@BackDate)
	--set @Closing_Balance=@Current_TransactionAmt+@Opening_Balance
	--insert into Opening_Balance(Company_ID,Date,Opening_Balance,Closing_Balance)
	--values(@Company_ID,@Tr_Date,@Opening_Balance,@Closing_Balance)
		if not exists(select 1 from Opening_Balance where Date>@Tr_Date)
		begin
			set @BackDate=(select MAX(Date) from Opening_Balance where Date<=(select MAX(Date) from Opening_Balance))
			set @Opening_Balance=(select Closing_Amount from Opening_Balance where Date=@BackDate)
			set @Closing_Balance=@Opening_Balance+@Current_TransactionAmt
			insert into Opening_Balance(Org_ID,Date,Opening_Amount,Closing_Amount)
			values(@Company_ID,@Tr_Date,@Opening_Balance,@Closing_Balance)
		
		end
		else
		begin		
			OPEN UpdateBal
					
			fetch next from UpdateBal into @Comp_ID,@Bal_Date,@Opening_Balance,@Closing_Balance
			while @@FETCH_STATUS=0
			begin	
				--set @Bal_Date=(select Bal_Date from @Temp_BalUpdate where Comp_ID=@Company_ID and Bal_Date=@Tr_Date)
				if not exists(select Date from Opening_Balance where Org_ID=@Company_ID and Date=@Tr_Date)
				begin 
					set @count=1
					set @BackDate=(select MAX(Date) from Opening_Balance where Date<=@Tr_Date)
					set @Opening_Balance=(select Closing_Amount from Opening_Balance where Date=@BackDate)
					set @Closing_Balance=@Opening_Balance+@Current_TransactionAmt
					
					insert into Opening_Balance (Org_ID,Date,Opening_Amount,Closing_Amount)
					values(@Comp_ID,@Tr_Date,@Opening_Balance,@Closing_Balance)
					set @count=@count+1
				end 
				if @count<>1
				begin
					set @Bal_Date=(select Bal_Date from @Temp_BalUpdate where Comp_ID=@Company_ID and Bal_Date=@Bal_Date)		
					set @Opening_Balance=(select OpenAmt from @Temp_BalUpdate where Bal_Date=@Bal_Date)
					set @Closing_Balance=(select CloseAmt from @Temp_BalUpdate where Bal_Date=@Bal_Date)
					if @count=1
					begin
						set @Closing_Balance=@Closing_Balance+@Current_TransactionAmt
						set @count=@count+1
					end
					else
					begin
						--set @Bal_Date=(select Bal_Date from @Temp_BalUpdate where Comp_ID=@Company_ID and Bal_Date=@Tr_Date)
						set @Opening_Balance=@Opening_Balance+@Current_TransactionAmt
						set @Closing_Balance=@Closing_Balance+@Current_TransactionAmt
					end
					UPDATE Opening_Balance set Opening_Amount=@Opening_Balance,Closing_Amount=@Closing_Balance
					where Org_ID=@Comp_ID and Date=@Bal_Date
				end
			fetch next from UpdateBal into @Comp_ID,@Bal_Date,@Opening_Balance,@Closing_Balance
			end
			Close UpdateBal
			Deallocate UpdateBal
		end
	end
	delete from @Temp_BalUpdate
end
else
begin
	if exists(select 1 from Opening_Balance where Date=@Tr_Date)
	begin		
		OPEN UpdateBal
				
		fetch next from UpdateBal into @Comp_ID,@Bal_Date,@Opening_Balance,@Closing_Balance
		while @@FETCH_STATUS=0
		begin
			set @Bal_Date=(select Bal_Date from @Temp_BalUpdate where Comp_ID=@Company_ID and Bal_Date=@Bal_Date)		
			set @Opening_Balance=(select OpenAmt from @Temp_BalUpdate where Bal_Date=@Bal_Date)
			set @Closing_Balance=(select CloseAmt from @Temp_BalUpdate where Bal_Date=@Bal_Date)
		
			if @Bal_Date=@Tr_Date
			begin
				set @count=1
			end
			if @count=1
			begin
				set @Closing_Balance=@Closing_Balance-@Current_TransactionAmt
				set @count=@count+1
			end
			else
			begin
				--set @Bal_Date=(select Bal_Date from @Temp_BalUpdate where Comp_ID=@Company_ID and Bal_Date=@Tr_Date)
				set @Opening_Balance=@Opening_Balance-@Current_TransactionAmt
				set @Closing_Balance=@Closing_Balance-@Current_TransactionAmt
			end
			
		UPDATE Opening_Balance set Opening_Amount=@Opening_Balance,Closing_Amount=@Closing_Balance
		where Org_ID=@Comp_ID and Date=@Bal_Date		
			
		fetch next from UpdateBal into @Comp_ID,@Bal_Date,@Opening_Balance,@Closing_Balance
		end
		Close UpdateBal
		Deallocate UpdateBal
	end
	else
	begin
		if not exists(select 1 from Opening_Balance where Date>@Tr_Date)
		begin
			set @BackDate=(select MAX(Date) from Opening_Balance where Date<=(select MAX(Date) from Opening_Balance))
			set @Opening_Balance=(select Closing_Amount from Opening_Balance where Date=@BackDate)
			set @Closing_Balance=@Opening_Balance-@Current_TransactionAmt
			insert into Opening_Balance(Org_ID,Date,Opening_Amount,Closing_Amount)
			values(@Company_ID,@Tr_Date,@Opening_Balance,@Closing_Balance)
		
		end
		else
		begin		
			OPEN UpdateBal
					
			fetch next from UpdateBal into @Comp_ID,@Bal_Date,@Opening_Balance,@Closing_Balance
			while @@FETCH_STATUS=0
			begin	
				--set @Bal_Date=(select Bal_Date from @Temp_BalUpdate where Comp_ID=@Company_ID and Bal_Date=@Tr_Date)
				if not exists(select Bal_Date from @Temp_BalUpdate where Comp_ID=@Company_ID and Bal_Date=@Tr_Date)
				begin 
					set @count=1
					set @BackDate=(select MAX(Date) from Opening_Balance where Date<=@Tr_Date)
					set @Opening_Balance=(select Closing_Amount from Opening_Balance where Date=@BackDate)
					set @Closing_Balance=@Opening_Balance-@Current_TransactionAmt
					
					insert into Opening_Balance (Org_ID,Date,Opening_Amount,Closing_Amount)
					values(@Comp_ID,@Tr_Date,@Opening_Balance,@Closing_Balance)
					set @count=@count+1
				end 
				if @count<>1
				begin
					set @Bal_Date=(select Bal_Date from @Temp_BalUpdate where Comp_ID=@Company_ID and Bal_Date=@Bal_Date)		
					set @Opening_Balance=(select OpenAmt from @Temp_BalUpdate where Bal_Date=@Bal_Date)
					set @Closing_Balance=(select CloseAmt from @Temp_BalUpdate where Bal_Date=@Bal_Date)
					if @count=1
					begin
						set @Closing_Balance=@Closing_Balance-@Current_TransactionAmt
						set @count=@count+1
					end
					else
					begin
						--set @Bal_Date=(select Bal_Date from @Temp_BalUpdate where Comp_ID=@Company_ID and Bal_Date=@Tr_Date)
						set @Opening_Balance=@Opening_Balance-@Current_TransactionAmt
						set @Closing_Balance=@Closing_Balance-@Current_TransactionAmt
					end
					UPDATE Opening_Balance set Opening_Amount=@Opening_Balance,Closing_Amount=@Closing_Balance
					where Org_ID=@Comp_ID and Date=@Bal_Date
				end
			fetch next from UpdateBal into @Comp_ID,@Bal_Date,@Opening_Balance,@Closing_Balance
			end
			Close UpdateBal
			Deallocate UpdateBal
		end
		end
delete from @Temp_BalUpdate
end
END


CREATE TABLE [dbo].[Voucher_Modified](
	[Date] [datetime] NULL,
	[Voucher_Id] [bigint] NULL,
	[Voucher_Type] [bit] NULL,
	[Old_Amount] [decimal](18, 2) NULL,
	[Updated_Amount] [decimal](18, 2) NULL,
	[TransactionYearId] [int] NULL,
	[UserID] [int] NULL,
	[Actual_Date] [datetime] NULL
) ON [PRIMARY]

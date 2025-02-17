
CREATE TABLE [dbo].[Interest_Posting](
	[Post_No] [bigint] NOT NULL,
	[Posting_Date] [datetime] NOT NULL,
	[Posting_Type] [int] NOT NULL,
	[Account_No] [bigint] NOT NULL,
	[Interest_Amt] [decimal](18, 2) NULL,
	[Total_Amt] [decimal](18, 2) NULL,
 CONSTRAINT [PK_Interest_Posting] PRIMARY KEY CLUSTERED 
(
	[Post_No] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

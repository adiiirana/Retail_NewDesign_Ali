-- SumUpPayment: log of sales amounts posted to SumUp (listed in General Settings > SumUp Transactions)

IF OBJECT_ID('dbo.SumUpPayment', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[SumUpPayment](
        [ID] [int] IDENTITY(1,1) NOT NULL,
        [UserID] [int] NOT NULL CONSTRAINT [DF_SumUpPayment_UserID] DEFAULT (0),
        [InvoiceNo] [int] NOT NULL CONSTRAINT [DF_SumUpPayment_InvoiceNo] DEFAULT (0),
        [CheckoutReference] [nvarchar](64) NOT NULL CONSTRAINT [DF_SumUpPayment_Ref] DEFAULT (''),
        [CheckoutId] [nvarchar](64) NOT NULL CONSTRAINT [DF_SumUpPayment_CheckoutId] DEFAULT (''),
        [Amount] [decimal](18, 2) NOT NULL CONSTRAINT [DF_SumUpPayment_Amount] DEFAULT (0),
        [Currency] [nvarchar](3) NOT NULL CONSTRAINT [DF_SumUpPayment_Currency] DEFAULT ('GBP'),
        [Status] [nvarchar](20) NOT NULL CONSTRAINT [DF_SumUpPayment_Status] DEFAULT ('PENDING'),
        [TransactionCode] [nvarchar](40) NOT NULL CONSTRAINT [DF_SumUpPayment_TxnCode] DEFAULT (''),
        [ErrorMessage] [nvarchar](400) NOT NULL CONSTRAINT [DF_SumUpPayment_Error] DEFAULT (''),
        [CreatedOn] [datetime] NOT NULL CONSTRAINT [DF_SumUpPayment_CreatedOn] DEFAULT (GETDATE()),
        CONSTRAINT [PK_SumUpPayment] PRIMARY KEY CLUSTERED ([ID] ASC)
    )
END
GO

-- SumUpPayment: payment method (CHECKOUT / READER) and reader transaction id

IF COL_LENGTH('dbo.SumUpPayment', 'Method') IS NULL
BEGIN
    ALTER TABLE [dbo].[SumUpPayment]
    ADD [Method] [nvarchar](20) NOT NULL
        CONSTRAINT [DF_SumUpPayment_Method] DEFAULT ('CHECKOUT');
END
GO

IF COL_LENGTH('dbo.SumUpPayment', 'ClientTransactionId') IS NULL
BEGIN
    ALTER TABLE [dbo].[SumUpPayment]
    ADD [ClientTransactionId] [nvarchar](64) NOT NULL
        CONSTRAINT [DF_SumUpPayment_ClientTxnId] DEFAULT ('');
END
GO

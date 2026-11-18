-- SumUpPayment.PayUrl: SumUp hosted payment page for the checkout

IF COL_LENGTH('dbo.SumUpPayment', 'PayUrl') IS NULL
BEGIN
    ALTER TABLE [dbo].[SumUpPayment]
    ADD [PayUrl] [nvarchar](400) NOT NULL
        CONSTRAINT [DF_SumUpPayment_PayUrl] DEFAULT ('');
END
GO

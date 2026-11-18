-- SumUpInfo: which payment methods are used for SumUp posts (card details form / Solo card reader)

IF COL_LENGTH('dbo.SumUpInfo', 'UseCardForm') IS NULL
BEGIN
    ALTER TABLE [dbo].[SumUpInfo]
    ADD [UseCardForm] [char](1) NOT NULL
        CONSTRAINT [DF_SumUpInfo_UseCardForm] DEFAULT ('Y');
END
GO

IF COL_LENGTH('dbo.SumUpInfo', 'UseSoloReader') IS NULL
BEGIN
    ALTER TABLE [dbo].[SumUpInfo]
    ADD [UseSoloReader] [char](1) NOT NULL
        CONSTRAINT [DF_SumUpInfo_UseSoloReader] DEFAULT ('Y');
END
GO

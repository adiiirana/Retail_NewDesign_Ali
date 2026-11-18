-- SumUpInfo: keep SumUp settings per XEPOS user

IF COL_LENGTH('dbo.SumUpInfo', 'UserID') IS NULL
BEGIN
    ALTER TABLE [dbo].[SumUpInfo]
    ADD [UserID] [int] NOT NULL
        CONSTRAINT [DF_SumUpInfo_UserID] DEFAULT (0);
END
GO

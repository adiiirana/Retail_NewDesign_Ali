-- Setup.SubTotalWithQty: 0 = hide qty beside Sub total, 1 = show X and total qty

IF COL_LENGTH('dbo.Setup', 'SubTotalWithQty') IS NULL
BEGIN
    ALTER TABLE [dbo].[Setup]
    ADD [SubTotalWithQty] INT NOT NULL
        CONSTRAINT [DF_Setup_SubTotalWithQty] DEFAULT (0);
END
GO

-- SumUpInfo.PairingCode: last pairing code entered for the SumUp Solo reader

IF COL_LENGTH('dbo.SumUpInfo', 'PairingCode') IS NULL
BEGIN
    ALTER TABLE [dbo].[SumUpInfo]
    ADD [PairingCode] [nvarchar](20) NOT NULL
        CONSTRAINT [DF_SumUpInfo_PairingCode] DEFAULT ('');
END
GO

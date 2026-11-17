SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
Sync flags (isUpdated / UpdatedDate) are maintained from application inline UPDATE statements.
This script removes previously deployed AFTER UPDATE triggers that set those columns.
*/

IF OBJECT_ID('dbo.TR_Dept_SetUpdatedFlags', 'TR') IS NOT NULL DROP TRIGGER dbo.TR_Dept_SetUpdatedFlags;
GO
IF OBJECT_ID('dbo.TR_Category_SetUpdatedFlags', 'TR') IS NOT NULL DROP TRIGGER dbo.TR_Category_SetUpdatedFlags;
GO
IF OBJECT_ID('dbo.TR_Product_SetUpdatedFlags', 'TR') IS NOT NULL DROP TRIGGER dbo.TR_Product_SetUpdatedFlags;
GO
IF OBJECT_ID('dbo.TR_UOM_SetUpdatedFlags', 'TR') IS NOT NULL DROP TRIGGER dbo.TR_UOM_SetUpdatedFlags;
GO
IF OBJECT_ID('dbo.TR_Customer_SetUpdatedFlags', 'TR') IS NOT NULL DROP TRIGGER dbo.TR_Customer_SetUpdatedFlags;
GO
IF OBJECT_ID('dbo.TR_Employee_SetUpdatedFlags', 'TR') IS NOT NULL DROP TRIGGER dbo.TR_Employee_SetUpdatedFlags;
GO
IF OBJECT_ID('dbo.TR_Invoice_SetUpdatedFlags', 'TR') IS NOT NULL DROP TRIGGER dbo.TR_Invoice_SetUpdatedFlags;
GO
IF OBJECT_ID('dbo.TR_Item_SetUpdatedFlags', 'TR') IS NOT NULL DROP TRIGGER dbo.TR_Item_SetUpdatedFlags;
GO
IF OBJECT_ID('dbo.TR_Trans_SetUpdatedFlags', 'TR') IS NOT NULL DROP TRIGGER dbo.TR_Trans_SetUpdatedFlags;
GO
IF OBJECT_ID('dbo.TR_TransTypes_SetUpdatedFlags', 'TR') IS NOT NULL DROP TRIGGER dbo.TR_TransTypes_SetUpdatedFlags;
GO
IF OBJECT_ID('dbo.TR_Tender_SetUpdatedFlags', 'TR') IS NOT NULL DROP TRIGGER dbo.TR_Tender_SetUpdatedFlags;
GO
IF OBJECT_ID('dbo.TR_StockJournal_SetUpdatedFlags', 'TR') IS NOT NULL DROP TRIGGER dbo.TR_StockJournal_SetUpdatedFlags;
GO
IF OBJECT_ID('dbo.TR_TenderTypes_SetUpdatedFlags', 'TR') IS NOT NULL DROP TRIGGER dbo.TR_TenderTypes_SetUpdatedFlags;
GO
IF OBJECT_ID('dbo.TR_GroupMaster_SetUpdatedFlags', 'TR') IS NOT NULL DROP TRIGGER dbo.TR_GroupMaster_SetUpdatedFlags;
GO

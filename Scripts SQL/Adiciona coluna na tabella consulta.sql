
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Consulta_Dashboard]') AND type in (N'U'))
DROP TABLE [dbo].[Consulta_Dashboard]
GO
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE Consulta_Dashboard (
	CON_id INT PRIMARY KEY IDENTITY NOT NULL,
	CON_titulo VARCHAR (50) NULL,
	CON_sql TEXT NULL,
	CON_javascript TEXT NULL,
	CON_dataCriacao DateTime Default GetDate(),
	CON_dataAlteracao DateTime Default GetDate()
)
GO
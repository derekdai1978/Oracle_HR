 IF NOT EXISTS(SELECT * FROM sys.schemas WHERE [name] = N'HR')      
     EXEC (N'CREATE SCHEMA HR')                                   
 GO                                                               
IF EXISTS (SELECT * FROM sys.sequences seq JOIN sys.schemas sch ON seq.schema_id=sch.schema_id WHERE seq.name=N'DEPARTMENTS_SEQ'  AND sch.name=N'HR' )
 DROP SEQUENCE [HR].[DEPARTMENTS_SEQ]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE SEQUENCE [HR].[DEPARTMENTS_SEQ]
    AS numeric(28)
    START WITH 280
    INCREMENT BY 10
    MINVALUE 1
    MAXVALUE 9990
    NO CYCLE
    NO CACHE
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'HR.DEPARTMENTS_SEQ',
        N'SCHEMA', N'HR',
        N'SEQUENCE', N'DEPARTMENTS_SEQ'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO
IF EXISTS (SELECT * FROM sys.sequences seq JOIN sys.schemas sch ON seq.schema_id=sch.schema_id WHERE seq.name=N'EMPLOYEES_SEQ'  AND sch.name=N'HR' )
 DROP SEQUENCE [HR].[EMPLOYEES_SEQ]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE SEQUENCE [HR].[EMPLOYEES_SEQ]
    AS numeric(28)
    START WITH 207
    INCREMENT BY 1
    MINVALUE 1
    NO MAXVALUE
    NO CYCLE
    NO CACHE
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'HR.EMPLOYEES_SEQ',
        N'SCHEMA', N'HR',
        N'SEQUENCE', N'EMPLOYEES_SEQ'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO
IF EXISTS (SELECT * FROM sys.sequences seq JOIN sys.schemas sch ON seq.schema_id=sch.schema_id WHERE seq.name=N'LOCATIONS_SEQ'  AND sch.name=N'HR' )
 DROP SEQUENCE [HR].[LOCATIONS_SEQ]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE SEQUENCE [HR].[LOCATIONS_SEQ]
    AS numeric(28)
    START WITH 3300
    INCREMENT BY 100
    MINVALUE 1
    MAXVALUE 9900
    NO CYCLE
    NO CACHE
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'HR.LOCATIONS_SEQ',
        N'SCHEMA', N'HR',
        N'SEQUENCE', N'LOCATIONS_SEQ'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'COUNTRIES'  AND sc.name = N'HR'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'COUNTRIES'  AND sc.name = N'HR'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [HR].[COUNTRIES]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[HR].[COUNTRIES]
(
   [COUNTRY_ID] char(2)  NOT NULL,
   [COUNTRY_NAME] varchar(50)  NULL,

   /*
   *   SSMA warning messages:
   *   O2SS0356: Conversion from NUMBER datatype can cause data loss.
   */

   [REGION_ID] int  NULL
)
WITH (DATA_COMPRESSION = NONE)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'HR.COUNTRIES',
        N'SCHEMA', N'HR',
        N'TABLE', N'COUNTRIES'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'HR.COUNTRIES.COUNTRY_ID',
        N'SCHEMA', N'HR',
        N'TABLE', N'COUNTRIES',
        N'COLUMN', N'COUNTRY_ID'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'HR.COUNTRIES.COUNTRY_NAME',
        N'SCHEMA', N'HR',
        N'TABLE', N'COUNTRIES',
        N'COLUMN', N'COUNTRY_NAME'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'HR.COUNTRIES.REGION_ID',
        N'SCHEMA', N'HR',
        N'TABLE', N'COUNTRIES',
        N'COLUMN', N'REGION_ID'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'DEPARTMENTS'  AND sc.name = N'HR'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'DEPARTMENTS'  AND sc.name = N'HR'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [HR].[DEPARTMENTS]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[HR].[DEPARTMENTS]
(
   [DEPARTMENT_ID] int  NOT NULL,
   [DEPARTMENT_NAME] varchar(50)  NOT NULL,
   [MANAGER_ID] int  NULL,
   [LOCATION_ID] int  NULL
)
WITH (DATA_COMPRESSION = NONE)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'HR.DEPARTMENTS',
        N'SCHEMA', N'HR',
        N'TABLE', N'DEPARTMENTS'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'HR.DEPARTMENTS.DEPARTMENT_ID',
        N'SCHEMA', N'HR',
        N'TABLE', N'DEPARTMENTS',
        N'COLUMN', N'DEPARTMENT_ID'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'HR.DEPARTMENTS.DEPARTMENT_NAME',
        N'SCHEMA', N'HR',
        N'TABLE', N'DEPARTMENTS',
        N'COLUMN', N'DEPARTMENT_NAME'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'HR.DEPARTMENTS.MANAGER_ID',
        N'SCHEMA', N'HR',
        N'TABLE', N'DEPARTMENTS',
        N'COLUMN', N'MANAGER_ID'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'HR.DEPARTMENTS.LOCATION_ID',
        N'SCHEMA', N'HR',
        N'TABLE', N'DEPARTMENTS',
        N'COLUMN', N'LOCATION_ID'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'EMPLOYEES'  AND sc.name = N'HR'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'EMPLOYEES'  AND sc.name = N'HR'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [HR].[EMPLOYEES]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[HR].[EMPLOYEES]
(
   [EMPLOYEE_ID] int  NOT NULL,
   [FIRST_NAME] varchar(20)  NULL,
   [LAST_NAME] varchar(25)  NOT NULL,
   [EMAIL] varchar(25)  NOT NULL,
   [PHONE_NUMBER] varchar(20)  NULL,
   [HIRE_DATE] datetime  NOT NULL,
   [JOB_ID] varchar(10)  NOT NULL,
   [SALARY] numeric(8, 2)  NULL,
   [COMMISSION_PCT] numeric(2, 2)  NULL,
   [MANAGER_ID] int NULL,
   [DEPARTMENT_ID] int  NULL,
   [ROWID] uniqueidentifier  NOT NULL
)
WITH (DATA_COMPRESSION = NONE)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'HR.EMPLOYEES',
        N'SCHEMA', N'HR',
        N'TABLE', N'EMPLOYEES'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'HR.EMPLOYEES.EMPLOYEE_ID',
        N'SCHEMA', N'HR',
        N'TABLE', N'EMPLOYEES',
        N'COLUMN', N'EMPLOYEE_ID'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'HR.EMPLOYEES.FIRST_NAME',
        N'SCHEMA', N'HR',
        N'TABLE', N'EMPLOYEES',
        N'COLUMN', N'FIRST_NAME'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'HR.EMPLOYEES.LAST_NAME',
        N'SCHEMA', N'HR',
        N'TABLE', N'EMPLOYEES',
        N'COLUMN', N'LAST_NAME'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'HR.EMPLOYEES.EMAIL',
        N'SCHEMA', N'HR',
        N'TABLE', N'EMPLOYEES',
        N'COLUMN', N'EMAIL'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'HR.EMPLOYEES.PHONE_NUMBER',
        N'SCHEMA', N'HR',
        N'TABLE', N'EMPLOYEES',
        N'COLUMN', N'PHONE_NUMBER'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'HR.EMPLOYEES.HIRE_DATE',
        N'SCHEMA', N'HR',
        N'TABLE', N'EMPLOYEES',
        N'COLUMN', N'HIRE_DATE'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'HR.EMPLOYEES.JOB_ID',
        N'SCHEMA', N'HR',
        N'TABLE', N'EMPLOYEES',
        N'COLUMN', N'JOB_ID'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'HR.EMPLOYEES.SALARY',
        N'SCHEMA', N'HR',
        N'TABLE', N'EMPLOYEES',
        N'COLUMN', N'SALARY'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'HR.EMPLOYEES.COMMISSION_PCT',
        N'SCHEMA', N'HR',
        N'TABLE', N'EMPLOYEES',
        N'COLUMN', N'COMMISSION_PCT'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'HR.EMPLOYEES.MANAGER_ID',
        N'SCHEMA', N'HR',
        N'TABLE', N'EMPLOYEES',
        N'COLUMN', N'MANAGER_ID'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'HR.EMPLOYEES.DEPARTMENT_ID',
        N'SCHEMA', N'HR',
        N'TABLE', N'EMPLOYEES',
        N'COLUMN', N'DEPARTMENT_ID'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'JOB_HISTORY'  AND sc.name = N'HR'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'JOB_HISTORY'  AND sc.name = N'HR'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [HR].[JOB_HISTORY]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[HR].[JOB_HISTORY]
(
   [EMPLOYEE_ID] int  NOT NULL,
   [START_DATE] datetime  NOT NULL,
   [END_DATE] datetime  NOT NULL,
   [JOB_ID] varchar(10)  NOT NULL,
   [DEPARTMENT_ID] int  NULL
)
WITH (DATA_COMPRESSION = NONE)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'HR.JOB_HISTORY',
        N'SCHEMA', N'HR',
        N'TABLE', N'JOB_HISTORY'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'HR.JOB_HISTORY.EMPLOYEE_ID',
        N'SCHEMA', N'HR',
        N'TABLE', N'JOB_HISTORY',
        N'COLUMN', N'EMPLOYEE_ID'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'HR.JOB_HISTORY.START_DATE',
        N'SCHEMA', N'HR',
        N'TABLE', N'JOB_HISTORY',
        N'COLUMN', N'START_DATE'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'HR.JOB_HISTORY.END_DATE',
        N'SCHEMA', N'HR',
        N'TABLE', N'JOB_HISTORY',
        N'COLUMN', N'END_DATE'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'HR.JOB_HISTORY.JOB_ID',
        N'SCHEMA', N'HR',
        N'TABLE', N'JOB_HISTORY',
        N'COLUMN', N'JOB_ID'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'HR.JOB_HISTORY.DEPARTMENT_ID',
        N'SCHEMA', N'HR',
        N'TABLE', N'JOB_HISTORY',
        N'COLUMN', N'DEPARTMENT_ID'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'JOBS'  AND sc.name = N'HR'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'JOBS'  AND sc.name = N'HR'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [HR].[JOBS]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[HR].[JOBS]
(
   [JOB_ID] varchar(10)  NOT NULL,
   [JOB_TITLE] varchar(35)  NOT NULL,
   [MIN_SALARY] int  NULL,
   [MAX_SALARY] int  NULL
)
WITH (DATA_COMPRESSION = NONE)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'HR.JOBS',
        N'SCHEMA', N'HR',
        N'TABLE', N'JOBS'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'HR.JOBS.JOB_ID',
        N'SCHEMA', N'HR',
        N'TABLE', N'JOBS',
        N'COLUMN', N'JOB_ID'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'HR.JOBS.JOB_TITLE',
        N'SCHEMA', N'HR',
        N'TABLE', N'JOBS',
        N'COLUMN', N'JOB_TITLE'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'HR.JOBS.MIN_SALARY',
        N'SCHEMA', N'HR',
        N'TABLE', N'JOBS',
        N'COLUMN', N'MIN_SALARY'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'HR.JOBS.MAX_SALARY',
        N'SCHEMA', N'HR',
        N'TABLE', N'JOBS',
        N'COLUMN', N'MAX_SALARY'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'LOCATIONS'  AND sc.name = N'HR'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'LOCATIONS'  AND sc.name = N'HR'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [HR].[LOCATIONS]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[HR].[LOCATIONS]
(
   [LOCATION_ID] int NOT NULL,
   [STREET_ADDRESS] varchar(40)  NULL,
   [POSTAL_CODE] varchar(12)  NULL,
   [CITY] varchar(30)  NOT NULL,
   [STATE_PROVINCE] varchar(25)  NULL,
   [COUNTRY_ID] char(2)  NULL
)
WITH (DATA_COMPRESSION = NONE)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'HR.LOCATIONS',
        N'SCHEMA', N'HR',
        N'TABLE', N'LOCATIONS'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'HR.LOCATIONS.LOCATION_ID',
        N'SCHEMA', N'HR',
        N'TABLE', N'LOCATIONS',
        N'COLUMN', N'LOCATION_ID'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'HR.LOCATIONS.STREET_ADDRESS',
        N'SCHEMA', N'HR',
        N'TABLE', N'LOCATIONS',
        N'COLUMN', N'STREET_ADDRESS'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'HR.LOCATIONS.POSTAL_CODE',
        N'SCHEMA', N'HR',
        N'TABLE', N'LOCATIONS',
        N'COLUMN', N'POSTAL_CODE'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'HR.LOCATIONS.CITY',
        N'SCHEMA', N'HR',
        N'TABLE', N'LOCATIONS',
        N'COLUMN', N'CITY'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'HR.LOCATIONS.STATE_PROVINCE',
        N'SCHEMA', N'HR',
        N'TABLE', N'LOCATIONS',
        N'COLUMN', N'STATE_PROVINCE'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'HR.LOCATIONS.COUNTRY_ID',
        N'SCHEMA', N'HR',
        N'TABLE', N'LOCATIONS',
        N'COLUMN', N'COUNTRY_ID'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'REGIONS'  AND sc.name = N'HR'  AND type in (N'U'))
BEGIN

  DECLARE @drop_statement nvarchar(500)

  DECLARE drop_cursor CURSOR FOR
      SELECT 'alter table '+quotename(schema_name(ob.schema_id))+
      '.'+quotename(object_name(ob.object_id))+ ' drop constraint ' + quotename(fk.name) 
      FROM sys.objects ob INNER JOIN sys.foreign_keys fk ON fk.parent_object_id = ob.object_id
      WHERE fk.referenced_object_id = 
          (
             SELECT so.object_id 
             FROM sys.objects so JOIN sys.schemas sc
             ON so.schema_id = sc.schema_id
             WHERE so.name = N'REGIONS'  AND sc.name = N'HR'  AND type in (N'U')
           )

  OPEN drop_cursor

  FETCH NEXT FROM drop_cursor
  INTO @drop_statement

  WHILE @@FETCH_STATUS = 0
  BEGIN
     EXEC (@drop_statement)

     FETCH NEXT FROM drop_cursor
     INTO @drop_statement
  END

  CLOSE drop_cursor
  DEALLOCATE drop_cursor

  DROP TABLE [HR].[REGIONS]
END 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE 
[HR].[REGIONS]
(

   /*
   *   SSMA warning messages:
   *   O2SS0356: Conversion from NUMBER datatype can cause data loss.
   */

   [REGION_ID] int NOT NULL,
   [REGION_NAME] varchar(25)  NULL
)
WITH (DATA_COMPRESSION = NONE)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'HR.REGIONS',
        N'SCHEMA', N'HR',
        N'TABLE', N'REGIONS'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'HR.REGIONS.REGION_ID',
        N'SCHEMA', N'HR',
        N'TABLE', N'REGIONS',
        N'COLUMN', N'REGION_ID'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'HR.REGIONS.REGION_NAME',
        N'SCHEMA', N'HR',
        N'TABLE', N'REGIONS',
        N'COLUMN', N'REGION_NAME'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'COUNTRY_C_ID_PK'  AND sc.name = N'HR'  AND type in (N'PK'))
ALTER TABLE [HR].[COUNTRIES] DROP CONSTRAINT [COUNTRY_C_ID_PK]
 GO



ALTER TABLE [HR].[COUNTRIES]
 ADD CONSTRAINT [COUNTRY_C_ID_PK]
   PRIMARY KEY
   CLUSTERED ([COUNTRY_ID] ASC)
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'HR.COUNTRIES.COUNTRY_C_ID_PK',
        N'SCHEMA', N'HR',
        N'TABLE', N'COUNTRIES',
        N'CONSTRAINT', N'COUNTRY_C_ID_PK'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'DEPT_ID_PK'  AND sc.name = N'HR'  AND type in (N'PK'))
ALTER TABLE [HR].[DEPARTMENTS] DROP CONSTRAINT [DEPT_ID_PK]
 GO



ALTER TABLE [HR].[DEPARTMENTS]
 ADD CONSTRAINT [DEPT_ID_PK]
   PRIMARY KEY
   CLUSTERED ([DEPARTMENT_ID] ASC)
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'HR.DEPARTMENTS.DEPT_ID_PK',
        N'SCHEMA', N'HR',
        N'TABLE', N'DEPARTMENTS',
        N'CONSTRAINT', N'DEPT_ID_PK'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'EMP_EMP_ID_PK'  AND sc.name = N'HR'  AND type in (N'PK'))
ALTER TABLE [HR].[EMPLOYEES] DROP CONSTRAINT [EMP_EMP_ID_PK]
 GO



ALTER TABLE [HR].[EMPLOYEES]
 ADD CONSTRAINT [EMP_EMP_ID_PK]
   PRIMARY KEY
   CLUSTERED ([EMPLOYEE_ID] ASC)
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'HR.EMPLOYEES.EMP_EMP_ID_PK',
        N'SCHEMA', N'HR',
        N'TABLE', N'EMPLOYEES',
        N'CONSTRAINT', N'EMP_EMP_ID_PK'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'JHIST_EMP_ID_ST_DATE_PK'  AND sc.name = N'HR'  AND type in (N'PK'))
ALTER TABLE [HR].[JOB_HISTORY] DROP CONSTRAINT [JHIST_EMP_ID_ST_DATE_PK]
 GO



ALTER TABLE [HR].[JOB_HISTORY]
 ADD CONSTRAINT [JHIST_EMP_ID_ST_DATE_PK]
   PRIMARY KEY
   CLUSTERED ([EMPLOYEE_ID] ASC, [START_DATE] ASC)
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'HR.JOB_HISTORY.JHIST_EMP_ID_ST_DATE_PK',
        N'SCHEMA', N'HR',
        N'TABLE', N'JOB_HISTORY',
        N'CONSTRAINT', N'JHIST_EMP_ID_ST_DATE_PK'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'JOB_ID_PK'  AND sc.name = N'HR'  AND type in (N'PK'))
ALTER TABLE [HR].[JOBS] DROP CONSTRAINT [JOB_ID_PK]
 GO



ALTER TABLE [HR].[JOBS]
 ADD CONSTRAINT [JOB_ID_PK]
   PRIMARY KEY
   CLUSTERED ([JOB_ID] ASC)
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'HR.JOBS.JOB_ID_PK',
        N'SCHEMA', N'HR',
        N'TABLE', N'JOBS',
        N'CONSTRAINT', N'JOB_ID_PK'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'LOC_ID_PK'  AND sc.name = N'HR'  AND type in (N'PK'))
ALTER TABLE [HR].[LOCATIONS] DROP CONSTRAINT [LOC_ID_PK]
 GO



ALTER TABLE [HR].[LOCATIONS]
 ADD CONSTRAINT [LOC_ID_PK]
   PRIMARY KEY
   CLUSTERED ([LOCATION_ID] ASC)
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'HR.LOCATIONS.LOC_ID_PK',
        N'SCHEMA', N'HR',
        N'TABLE', N'LOCATIONS',
        N'CONSTRAINT', N'LOC_ID_PK'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'REG_ID_PK'  AND sc.name = N'HR'  AND type in (N'PK'))
ALTER TABLE [HR].[REGIONS] DROP CONSTRAINT [REG_ID_PK]
 GO



ALTER TABLE [HR].[REGIONS]
 ADD CONSTRAINT [REG_ID_PK]
   PRIMARY KEY
   CLUSTERED ([REGION_ID] ASC)
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'HR.REGIONS.REG_ID_PK',
        N'SCHEMA', N'HR',
        N'TABLE', N'REGIONS',
        N'CONSTRAINT', N'REG_ID_PK'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'EMP_EMAIL_UK'  AND sc.name = N'HR'  AND type in (N'UQ'))
ALTER TABLE [HR].[EMPLOYEES] DROP CONSTRAINT [EMP_EMAIL_UK]
 GO



ALTER TABLE [HR].[EMPLOYEES]
 ADD CONSTRAINT [EMP_EMAIL_UK]
 UNIQUE 
   NONCLUSTERED ([EMAIL] ASC)
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'HR.EMPLOYEES.EMP_EMAIL_UK',
        N'SCHEMA', N'HR',
        N'TABLE', N'EMPLOYEES',
        N'CONSTRAINT', N'EMP_EMAIL_UK'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH

GO

IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'ADD_JOB_HISTORY'  AND sc.name=N'HR'  AND type in (N'P',N'PC'))
 DROP PROCEDURE [HR].[ADD_JOB_HISTORY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE HR.ADD_JOB_HISTORY  
   @P_EMP_ID int,
   @P_START_DATE datetime,
   @P_END_DATE datetime,
   @P_JOB_ID varchar(10),
   @P_DEPARTMENT_ID int
AS 
   BEGIN
      INSERT HR.JOB_HISTORY(
         EMPLOYEE_ID, 
         START_DATE, 
         END_DATE, 
         JOB_ID, 
         DEPARTMENT_ID)
         VALUES (
            @P_EMP_ID, 
            @P_START_DATE, 
            @P_END_DATE, 
            @P_JOB_ID, 
            @P_DEPARTMENT_ID)
   END
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'HR.ADD_JOB_HISTORY',
        N'SCHEMA', N'HR',
        N'PROCEDURE', N'ADD_JOB_HISTORY'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc on so.schema_id = sc.schema_id WHERE so.name = N'InsteadOfDeleteOn$EMPLOYEES'  AND sc.name=N'HR'  AND type in (N'TR'))
 DROP TRIGGER [HR].[InsteadOfDeleteOn$EMPLOYEES]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER HR.InsteadOfDeleteOn$EMPLOYEES
   ON HR.EMPLOYEES
    INSTEAD OF DELETE
   AS 
      BEGIN

         SET  NOCOUNT  ON

         /* column variables declaration*/
         DECLARE
            @OLD$0 uniqueidentifier

         /* table-level triggers implementation: begin*/
         BEGIN
            BEGIN
               EXECUTE HR.SECURE_DML 
            END
         END
         /* table-level triggers implementation: end*/

         DECLARE
             ForEachDeletedRowTriggerCursor CURSOR LOCAL FORWARD_ONLY READ_ONLY FOR 
               SELECT ROWID
               FROM deleted

         OPEN ForEachDeletedRowTriggerCursor

         FETCH ForEachDeletedRowTriggerCursor
             INTO @OLD$0

         WHILE @@fetch_status = 0
         
            BEGIN

               /* DML-operation emulation*/
               DELETE HR.EMPLOYEES
               WHERE ROWID = @OLD$0

               FETCH ForEachDeletedRowTriggerCursor
                   INTO @OLD$0

            END

         CLOSE ForEachDeletedRowTriggerCursor

         DEALLOCATE ForEachDeletedRowTriggerCursor

      END
GO
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc on so.schema_id = sc.schema_id WHERE so.name = N'InsteadOfInsertOn$EMPLOYEES'  AND sc.name=N'HR'  AND type in (N'TR'))
 DROP TRIGGER [HR].[InsteadOfInsertOn$EMPLOYEES]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER HR.InsteadOfInsertOn$EMPLOYEES
   ON HR.EMPLOYEES
    INSTEAD OF INSERT
   AS 
      BEGIN

         SET  NOCOUNT  ON

         /* column variables declaration*/
         DECLARE
            @NEW$0 uniqueidentifier, 
            @NEW$EMPLOYEE_ID int, 
            @NEW$FIRST_NAME varchar(20), 
            @NEW$LAST_NAME varchar(25), 
            @NEW$EMAIL varchar(25), 
            @NEW$PHONE_NUMBER varchar(20), 
            @NEW$HIRE_DATE datetime, 
            @NEW$JOB_ID varchar(10), 
            @NEW$SALARY numeric(8, 2), 
            @NEW$COMMISSION_PCT numeric(2, 2), 
            @NEW$MANAGER_ID int, 
            @NEW$DEPARTMENT_ID int

         /* table-level triggers implementation: begin*/
         BEGIN
            BEGIN
               EXECUTE HR.SECURE_DML 
            END
         END
         /* table-level triggers implementation: end*/

         DECLARE
             ForEachInsertedRowTriggerCursor CURSOR LOCAL FORWARD_ONLY READ_ONLY FOR 
               SELECT 
                  ROWID, 
                  EMPLOYEE_ID, 
                  FIRST_NAME, 
                  LAST_NAME, 
                  EMAIL, 
                  PHONE_NUMBER, 
                  HIRE_DATE, 
                  JOB_ID, 
                  SALARY, 
                  COMMISSION_PCT, 
                  MANAGER_ID, 
                  DEPARTMENT_ID
               FROM inserted

         OPEN ForEachInsertedRowTriggerCursor

         FETCH ForEachInsertedRowTriggerCursor
             INTO 
               @NEW$0, 
               @NEW$EMPLOYEE_ID, 
               @NEW$FIRST_NAME, 
               @NEW$LAST_NAME, 
               @NEW$EMAIL, 
               @NEW$PHONE_NUMBER, 
               @NEW$HIRE_DATE, 
               @NEW$JOB_ID, 
               @NEW$SALARY, 
               @NEW$COMMISSION_PCT, 
               @NEW$MANAGER_ID, 
               @NEW$DEPARTMENT_ID

         WHILE @@fetch_status = 0
         
            BEGIN

               /* DML-operation emulation*/
               INSERT HR.EMPLOYEES(
                  ROWID, 
                  EMPLOYEE_ID, 
                  FIRST_NAME, 
                  LAST_NAME, 
                  EMAIL, 
                  PHONE_NUMBER, 
                  HIRE_DATE, 
                  JOB_ID, 
                  SALARY, 
                  COMMISSION_PCT, 
                  MANAGER_ID, 
                  DEPARTMENT_ID)
                  VALUES (
                     @NEW$0, 
                     @NEW$EMPLOYEE_ID, 
                     @NEW$FIRST_NAME, 
                     @NEW$LAST_NAME, 
                     @NEW$EMAIL, 
                     @NEW$PHONE_NUMBER, 
                     @NEW$HIRE_DATE, 
                     @NEW$JOB_ID, 
                     @NEW$SALARY, 
                     @NEW$COMMISSION_PCT, 
                     @NEW$MANAGER_ID, 
                     @NEW$DEPARTMENT_ID)

               FETCH ForEachInsertedRowTriggerCursor
                   INTO 
                     @NEW$0, 
                     @NEW$EMPLOYEE_ID, 
                     @NEW$FIRST_NAME, 
                     @NEW$LAST_NAME, 
                     @NEW$EMAIL, 
                     @NEW$PHONE_NUMBER, 
                     @NEW$HIRE_DATE, 
                     @NEW$JOB_ID, 
                     @NEW$SALARY, 
                     @NEW$COMMISSION_PCT, 
                     @NEW$MANAGER_ID, 
                     @NEW$DEPARTMENT_ID

            END

         CLOSE ForEachInsertedRowTriggerCursor

         DEALLOCATE ForEachInsertedRowTriggerCursor

      END
GO
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc on so.schema_id = sc.schema_id WHERE so.name = N'InsteadOfUpdateOn$EMPLOYEES'  AND sc.name=N'HR'  AND type in (N'TR'))
 DROP TRIGGER [HR].[InsteadOfUpdateOn$EMPLOYEES]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER HR.InsteadOfUpdateOn$EMPLOYEES
   ON HR.EMPLOYEES
    INSTEAD OF UPDATE
   AS 
      BEGIN

         SET  NOCOUNT  ON

         /* column variables declaration*/
         DECLARE
            @NEW$0 uniqueidentifier, 
            @NEW$EMPLOYEE_ID int, 
            @NEW$FIRST_NAME varchar(20), 
            @NEW$LAST_NAME varchar(25), 
            @NEW$EMAIL varchar(25), 
            @NEW$PHONE_NUMBER varchar(20), 
            @NEW$HIRE_DATE datetime, 
            @NEW$JOB_ID varchar(10), 
            @NEW$SALARY numeric(8, 2), 
            @NEW$COMMISSION_PCT numeric(2, 2), 
            @NEW$MANAGER_ID int, 
            @NEW$DEPARTMENT_ID int
         /* table-level triggers implementation: begin*/
         BEGIN
            BEGIN
               EXECUTE HR.SECURE_DML 
            END
         END
         /* table-level triggers implementation: end*/

         DECLARE
             ForEachInsertedRowTriggerCursor CURSOR LOCAL FORWARD_ONLY READ_ONLY FOR 
               SELECT 
                  ROWID, 
                  EMPLOYEE_ID, 
                  FIRST_NAME, 
                  LAST_NAME, 
                  EMAIL, 
                  PHONE_NUMBER, 
                  HIRE_DATE, 
                  JOB_ID, 
                  SALARY, 
                  COMMISSION_PCT, 
                  MANAGER_ID, 
                  DEPARTMENT_ID
               FROM inserted

         OPEN ForEachInsertedRowTriggerCursor

         FETCH ForEachInsertedRowTriggerCursor
             INTO 
               @NEW$0, 
               @NEW$EMPLOYEE_ID, 
               @NEW$FIRST_NAME, 
               @NEW$LAST_NAME, 
               @NEW$EMAIL, 
               @NEW$PHONE_NUMBER, 
               @NEW$HIRE_DATE, 
               @NEW$JOB_ID, 
               @NEW$SALARY, 
               @NEW$COMMISSION_PCT, 
               @NEW$MANAGER_ID, 
               @NEW$DEPARTMENT_ID

         WHILE @@fetch_status = 0
         
            BEGIN

               /* DML-operation emulation*/
               UPDATE HR.EMPLOYEES
                  SET 
                     EMPLOYEE_ID = @NEW$EMPLOYEE_ID, 
                     FIRST_NAME = @NEW$FIRST_NAME, 
                     LAST_NAME = @NEW$LAST_NAME, 
                     EMAIL = @NEW$EMAIL, 
                     PHONE_NUMBER = @NEW$PHONE_NUMBER, 
                     HIRE_DATE = @NEW$HIRE_DATE, 
                     JOB_ID = @NEW$JOB_ID, 
                     SALARY = @NEW$SALARY, 
                     COMMISSION_PCT = @NEW$COMMISSION_PCT, 
                     MANAGER_ID = @NEW$MANAGER_ID, 
                     DEPARTMENT_ID = @NEW$DEPARTMENT_ID
               WHERE ROWID = @NEW$0

               FETCH ForEachInsertedRowTriggerCursor
                   INTO 
                     @NEW$0, 
                     @NEW$EMPLOYEE_ID, 
                     @NEW$FIRST_NAME, 
                     @NEW$LAST_NAME, 
                     @NEW$EMAIL, 
                     @NEW$PHONE_NUMBER, 
                     @NEW$HIRE_DATE, 
                     @NEW$JOB_ID, 
                     @NEW$SALARY, 
                     @NEW$COMMISSION_PCT, 
                     @NEW$MANAGER_ID, 
                     @NEW$DEPARTMENT_ID

            END

         CLOSE ForEachInsertedRowTriggerCursor

         DEALLOCATE ForEachInsertedRowTriggerCursor

      END
GO
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'SECURE_DML'  AND sc.name=N'HR'  AND type in (N'P',N'PC'))
 DROP PROCEDURE [HR].[SECURE_DML]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE HR.SECURE_DML  
AS 
   BEGIN
      IF ssma_oracle.to_char_date(sysdatetime(), 'HH24:MI') NOT BETWEEN '08:00' AND '18:00' OR ssma_oracle.to_char_date(sysdatetime(), 'DY') IN ( 'SAT', 'SUN' )
         BEGIN

            DECLARE
               @db_raise_application_error_message nvarchar(4000)

            SET @db_raise_application_error_message = N'ORA' + CAST(-20205 AS nvarchar) + N': ' + N'You may only make changes during normal office hours'
; 
            THROW 59998, @db_raise_application_error_message, 1

         END
   END
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'HR.SECURE_DML',
        N'SCHEMA', N'HR',
        N'PROCEDURE', N'SECURE_DML'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO
IF  EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc on so.schema_id = sc.schema_id WHERE so.name = N'UPDATE_JOB_HISTORY$AfterUpdate'  AND sc.name=N'HR'  AND type in (N'TR'))
 DROP TRIGGER [HR].[UPDATE_JOB_HISTORY$AfterUpdate]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER HR.UPDATE_JOB_HISTORY$AfterUpdate
   ON HR.EMPLOYEES
    AFTER UPDATE
   AS 
      BEGIN

         SET  NOCOUNT  ON

         /* column variables declaration*/
         DECLARE
            @NEW$0 uniqueidentifier, 
            @OLD$0 uniqueidentifier, 
            @OLD$EMPLOYEE_ID int, 
            @OLD$HIRE_DATE datetime, 
            @OLD$JOB_ID varchar(10), 
            @OLD$DEPARTMENT_ID int

         DECLARE
             ForEachDeletedRowTriggerCursor CURSOR LOCAL FORWARD_ONLY READ_ONLY FOR 
               SELECT 
                  ROWID, 
                  EMPLOYEE_ID, 
                  HIRE_DATE, 
                  JOB_ID, 
                  DEPARTMENT_ID
               FROM deleted

         OPEN ForEachDeletedRowTriggerCursor

         FETCH ForEachDeletedRowTriggerCursor
             INTO 
               @OLD$0, 
               @OLD$EMPLOYEE_ID, 
               @OLD$HIRE_DATE, 
               @OLD$JOB_ID, 
               @OLD$DEPARTMENT_ID

         WHILE @@fetch_status = 0
         
            BEGIN

               /* trigger implementation: begin*/
               BEGIN
                  IF (UPDATE(JOB_ID) OR UPDATE(DEPARTMENT_ID))
                     BEGIN

                        DECLARE
                           @temp datetime2

                        SET @temp = sysdatetime()

                        EXECUTE HR.ADD_JOB_HISTORY 
                           @P_EMP_ID = @OLD$EMPLOYEE_ID, 
                           @P_START_DATE = @OLD$HIRE_DATE, 
                           @P_END_DATE = @temp, 
                           @P_JOB_ID = @OLD$JOB_ID, 
                           @P_DEPARTMENT_ID = @OLD$DEPARTMENT_ID

                     END
               END
               /* trigger implementation: end*/

               FETCH ForEachDeletedRowTriggerCursor
                   INTO 
                     @OLD$0, 
                     @OLD$EMPLOYEE_ID, 
                     @OLD$HIRE_DATE, 
                     @OLD$JOB_ID, 
                     @OLD$DEPARTMENT_ID

            END

         CLOSE ForEachDeletedRowTriggerCursor

         DEALLOCATE ForEachDeletedRowTriggerCursor

      END
GO
GO
IF  EXISTS (select * from sys.objects so join sys.schemas sc on so.schema_id = sc.schema_id where so.name = N'EMP_DETAILS_VIEW' and sc.name=N'HR' AND type in (N'V'))
 DROP VIEW [HR].[EMP_DETAILS_VIEW]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
*   SSMA warning messages:
*   O2SS0017: Attribute WITH READ ONLY cannot be converted. 
*    WITH READ ONLY
*/

CREATE VIEW HR.EMP_DETAILS_VIEW (
   EMPLOYEE_ID, 
   JOB_ID, 
   MANAGER_ID, 
   DEPARTMENT_ID, 
   LOCATION_ID, 
   COUNTRY_ID, 
   FIRST_NAME, 
   LAST_NAME, 
   SALARY, 
   COMMISSION_PCT, 
   DEPARTMENT_NAME, 
   JOB_TITLE, 
   CITY, 
   STATE_PROVINCE, 
   COUNTRY_NAME, 
   REGION_NAME)
AS 
   SELECT 
      E.EMPLOYEE_ID, 
      E.JOB_ID, 
      E.MANAGER_ID, 
      E.DEPARTMENT_ID, 
      D.LOCATION_ID, 
      L.COUNTRY_ID, 
      E.FIRST_NAME, 
      E.LAST_NAME, 
      E.SALARY, 
      E.COMMISSION_PCT, 
      D.DEPARTMENT_NAME, 
      J.JOB_TITLE, 
      L.CITY, 
      L.STATE_PROVINCE, 
      C.COUNTRY_NAME, 
      R.REGION_NAME
   FROM 
      HR.EMPLOYEES  AS E, 
      HR.DEPARTMENTS  AS D, 
      HR.JOBS  AS J, 
      HR.LOCATIONS  AS L, 
      HR.COUNTRIES  AS C, 
      HR.REGIONS  AS R
   WHERE 
      E.DEPARTMENT_ID = D.DEPARTMENT_ID AND 
      D.LOCATION_ID = L.LOCATION_ID AND 
      L.COUNTRY_ID = C.COUNTRY_ID AND 
      C.REGION_ID = R.REGION_ID AND 
      J.JOB_ID = E.JOB_ID
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'HR.EMP_DETAILS_VIEW',
        N'SCHEMA', N'HR',
        N'VIEW', N'EMP_DETAILS_VIEW'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO
IF EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'DEPARTMENTS'  AND sc.name = N'HR'  AND si.name = N'DEPT_LOCATION_IX' AND so.type in (N'U'))
   DROP INDEX [DEPT_LOCATION_IX] ON [HR].[DEPARTMENTS] 
GO
CREATE NONCLUSTERED INDEX [DEPT_LOCATION_IX] ON [HR].[DEPARTMENTS]
(
   [LOCATION_ID] ASC
)
WITH (DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'HR.DEPARTMENTS.DEPT_LOCATION_IX',
        N'SCHEMA', N'HR',
        N'TABLE', N'DEPARTMENTS',
        N'INDEX', N'DEPT_LOCATION_IX'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO
IF EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'EMPLOYEES'  AND sc.name = N'HR'  AND si.name = N'EMP_DEPARTMENT_IX' AND so.type in (N'U'))
   DROP INDEX [EMP_DEPARTMENT_IX] ON [HR].[EMPLOYEES] 
GO
CREATE NONCLUSTERED INDEX [EMP_DEPARTMENT_IX] ON [HR].[EMPLOYEES]
(
   [DEPARTMENT_ID] ASC
)
WITH (DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'HR.EMPLOYEES.EMP_DEPARTMENT_IX',
        N'SCHEMA', N'HR',
        N'TABLE', N'EMPLOYEES',
        N'INDEX', N'EMP_DEPARTMENT_IX'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO
IF EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'EMPLOYEES'  AND sc.name = N'HR'  AND si.name = N'EMP_JOB_IX' AND so.type in (N'U'))
   DROP INDEX [EMP_JOB_IX] ON [HR].[EMPLOYEES] 
GO
CREATE NONCLUSTERED INDEX [EMP_JOB_IX] ON [HR].[EMPLOYEES]
(
   [JOB_ID] ASC
)
WITH (DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'HR.EMPLOYEES.EMP_JOB_IX',
        N'SCHEMA', N'HR',
        N'TABLE', N'EMPLOYEES',
        N'INDEX', N'EMP_JOB_IX'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO
IF EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'EMPLOYEES'  AND sc.name = N'HR'  AND si.name = N'EMP_MANAGER_IX' AND so.type in (N'U'))
   DROP INDEX [EMP_MANAGER_IX] ON [HR].[EMPLOYEES] 
GO
CREATE NONCLUSTERED INDEX [EMP_MANAGER_IX] ON [HR].[EMPLOYEES]
(
   [MANAGER_ID] ASC
)
WITH (DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'HR.EMPLOYEES.EMP_MANAGER_IX',
        N'SCHEMA', N'HR',
        N'TABLE', N'EMPLOYEES',
        N'INDEX', N'EMP_MANAGER_IX'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO
IF EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'EMPLOYEES'  AND sc.name = N'HR'  AND si.name = N'EMP_NAME_IX' AND so.type in (N'U'))
   DROP INDEX [EMP_NAME_IX] ON [HR].[EMPLOYEES] 
GO
CREATE NONCLUSTERED INDEX [EMP_NAME_IX] ON [HR].[EMPLOYEES]
(
   [LAST_NAME] ASC,
   [FIRST_NAME] ASC
)
WITH (DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'HR.EMPLOYEES.EMP_NAME_IX',
        N'SCHEMA', N'HR',
        N'TABLE', N'EMPLOYEES',
        N'INDEX', N'EMP_NAME_IX'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO
IF EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'JOB_HISTORY'  AND sc.name = N'HR'  AND si.name = N'JHIST_DEPARTMENT_IX' AND so.type in (N'U'))
   DROP INDEX [JHIST_DEPARTMENT_IX] ON [HR].[JOB_HISTORY] 
GO
CREATE NONCLUSTERED INDEX [JHIST_DEPARTMENT_IX] ON [HR].[JOB_HISTORY]
(
   [DEPARTMENT_ID] ASC
)
WITH (DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'HR.JOB_HISTORY.JHIST_DEPARTMENT_IX',
        N'SCHEMA', N'HR',
        N'TABLE', N'JOB_HISTORY',
        N'INDEX', N'JHIST_DEPARTMENT_IX'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO
IF EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'JOB_HISTORY'  AND sc.name = N'HR'  AND si.name = N'JHIST_EMPLOYEE_IX' AND so.type in (N'U'))
   DROP INDEX [JHIST_EMPLOYEE_IX] ON [HR].[JOB_HISTORY] 
GO
CREATE NONCLUSTERED INDEX [JHIST_EMPLOYEE_IX] ON [HR].[JOB_HISTORY]
(
   [EMPLOYEE_ID] ASC
)
WITH (DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'HR.JOB_HISTORY.JHIST_EMPLOYEE_IX',
        N'SCHEMA', N'HR',
        N'TABLE', N'JOB_HISTORY',
        N'INDEX', N'JHIST_EMPLOYEE_IX'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO
IF EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'JOB_HISTORY'  AND sc.name = N'HR'  AND si.name = N'JHIST_JOB_IX' AND so.type in (N'U'))
   DROP INDEX [JHIST_JOB_IX] ON [HR].[JOB_HISTORY] 
GO
CREATE NONCLUSTERED INDEX [JHIST_JOB_IX] ON [HR].[JOB_HISTORY]
(
   [JOB_ID] ASC
)
WITH (DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'HR.JOB_HISTORY.JHIST_JOB_IX',
        N'SCHEMA', N'HR',
        N'TABLE', N'JOB_HISTORY',
        N'INDEX', N'JHIST_JOB_IX'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO
IF EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'LOCATIONS'  AND sc.name = N'HR'  AND si.name = N'LOC_CITY_IX' AND so.type in (N'U'))
   DROP INDEX [LOC_CITY_IX] ON [HR].[LOCATIONS] 
GO
CREATE NONCLUSTERED INDEX [LOC_CITY_IX] ON [HR].[LOCATIONS]
(
   [CITY] ASC
)
WITH (DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'HR.LOCATIONS.LOC_CITY_IX',
        N'SCHEMA', N'HR',
        N'TABLE', N'LOCATIONS',
        N'INDEX', N'LOC_CITY_IX'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO
IF EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'LOCATIONS'  AND sc.name = N'HR'  AND si.name = N'LOC_COUNTRY_IX' AND so.type in (N'U'))
   DROP INDEX [LOC_COUNTRY_IX] ON [HR].[LOCATIONS] 
GO
CREATE NONCLUSTERED INDEX [LOC_COUNTRY_IX] ON [HR].[LOCATIONS]
(
   [COUNTRY_ID] ASC
)
WITH (DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'HR.LOCATIONS.LOC_COUNTRY_IX',
        N'SCHEMA', N'HR',
        N'TABLE', N'LOCATIONS',
        N'INDEX', N'LOC_COUNTRY_IX'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO
IF EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'LOCATIONS'  AND sc.name = N'HR'  AND si.name = N'LOC_STATE_PROVINCE_IX' AND so.type in (N'U'))
   DROP INDEX [LOC_STATE_PROVINCE_IX] ON [HR].[LOCATIONS] 
GO
CREATE NONCLUSTERED INDEX [LOC_STATE_PROVINCE_IX] ON [HR].[LOCATIONS]
(
   [STATE_PROVINCE] ASC
)
WITH (DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF)
GO
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'HR.LOCATIONS.LOC_STATE_PROVINCE_IX',
        N'SCHEMA', N'HR',
        N'TABLE', N'LOCATIONS',
        N'INDEX', N'LOC_STATE_PROVINCE_IX'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH
GO
IF EXISTS (
       SELECT * FROM sys.objects  so JOIN sys.indexes si
       ON so.object_id = si.object_id
       JOIN sys.schemas sc
       ON so.schema_id = sc.schema_id
       WHERE so.name = N'EMPLOYEES'  AND sc.name = N'HR'  AND si.name = N'ROWID$INDEX' AND so.type in (N'U'))
   DROP INDEX [ROWID$INDEX] ON [HR].[EMPLOYEES] 
GO
CREATE UNIQUE NONCLUSTERED INDEX [ROWID$INDEX] ON [HR].[EMPLOYEES]
(
   [ROWID] ASC
)
WITH (DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF)
GO
GO
IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'COUNTR_REG_FK'  AND sc.name = N'HR'  AND type in (N'F'))
ALTER TABLE [HR].[COUNTRIES] DROP CONSTRAINT [COUNTR_REG_FK]
 GO



ALTER TABLE [HR].[COUNTRIES]
 ADD CONSTRAINT [COUNTR_REG_FK]
 FOREIGN KEY 
   ([REGION_ID])
 REFERENCES 
   [HR].[REGIONS]     ([REGION_ID])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'HR.COUNTRIES.COUNTR_REG_FK',
        N'SCHEMA', N'HR',
        N'TABLE', N'COUNTRIES',
        N'CONSTRAINT', N'COUNTR_REG_FK'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'DEPT_LOC_FK'  AND sc.name = N'HR'  AND type in (N'F'))
ALTER TABLE [HR].[DEPARTMENTS] DROP CONSTRAINT [DEPT_LOC_FK]
 GO



ALTER TABLE [HR].[DEPARTMENTS]
 ADD CONSTRAINT [DEPT_LOC_FK]
 FOREIGN KEY 
   ([LOCATION_ID])
 REFERENCES 
   [HR].[LOCATIONS]     ([LOCATION_ID])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'HR.DEPARTMENTS.DEPT_LOC_FK',
        N'SCHEMA', N'HR',
        N'TABLE', N'DEPARTMENTS',
        N'CONSTRAINT', N'DEPT_LOC_FK'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'DEPT_MGR_FK'  AND sc.name = N'HR'  AND type in (N'F'))
ALTER TABLE [HR].[DEPARTMENTS] DROP CONSTRAINT [DEPT_MGR_FK]
 GO



ALTER TABLE [HR].[DEPARTMENTS]
 ADD CONSTRAINT [DEPT_MGR_FK]
 FOREIGN KEY 
   ([MANAGER_ID])
 REFERENCES 
   [HR].[EMPLOYEES]     ([EMPLOYEE_ID])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'HR.DEPARTMENTS.DEPT_MGR_FK',
        N'SCHEMA', N'HR',
        N'TABLE', N'DEPARTMENTS',
        N'CONSTRAINT', N'DEPT_MGR_FK'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'EMP_MANAGER_FK'  AND sc.name = N'HR'  AND type in (N'F'))
ALTER TABLE [HR].[EMPLOYEES] DROP CONSTRAINT [EMP_MANAGER_FK]
 GO



ALTER TABLE [HR].[EMPLOYEES]
 ADD CONSTRAINT [EMP_MANAGER_FK]
 FOREIGN KEY 
   ([MANAGER_ID])
 REFERENCES 
   [HR].[EMPLOYEES]     ([EMPLOYEE_ID])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'HR.EMPLOYEES.EMP_MANAGER_FK',
        N'SCHEMA', N'HR',
        N'TABLE', N'EMPLOYEES',
        N'CONSTRAINT', N'EMP_MANAGER_FK'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'EMP_JOB_FK'  AND sc.name = N'HR'  AND type in (N'F'))
ALTER TABLE [HR].[EMPLOYEES] DROP CONSTRAINT [EMP_JOB_FK]
 GO



ALTER TABLE [HR].[EMPLOYEES]
 ADD CONSTRAINT [EMP_JOB_FK]
 FOREIGN KEY 
   ([JOB_ID])
 REFERENCES 
   [HR].[JOBS]     ([JOB_ID])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'HR.EMPLOYEES.EMP_JOB_FK',
        N'SCHEMA', N'HR',
        N'TABLE', N'EMPLOYEES',
        N'CONSTRAINT', N'EMP_JOB_FK'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'EMP_DEPT_FK'  AND sc.name = N'HR'  AND type in (N'F'))
ALTER TABLE [HR].[EMPLOYEES] DROP CONSTRAINT [EMP_DEPT_FK]
 GO



ALTER TABLE [HR].[EMPLOYEES]
 ADD CONSTRAINT [EMP_DEPT_FK]
 FOREIGN KEY 
   ([DEPARTMENT_ID])
 REFERENCES 
   [HR].[DEPARTMENTS]     ([DEPARTMENT_ID])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'HR.EMPLOYEES.EMP_DEPT_FK',
        N'SCHEMA', N'HR',
        N'TABLE', N'EMPLOYEES',
        N'CONSTRAINT', N'EMP_DEPT_FK'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'JHIST_DEPT_FK'  AND sc.name = N'HR'  AND type in (N'F'))
ALTER TABLE [HR].[JOB_HISTORY] DROP CONSTRAINT [JHIST_DEPT_FK]
 GO



ALTER TABLE [HR].[JOB_HISTORY]
 ADD CONSTRAINT [JHIST_DEPT_FK]
 FOREIGN KEY 
   ([DEPARTMENT_ID])
 REFERENCES 
   [HR].[DEPARTMENTS]     ([DEPARTMENT_ID])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'HR.JOB_HISTORY.JHIST_DEPT_FK',
        N'SCHEMA', N'HR',
        N'TABLE', N'JOB_HISTORY',
        N'CONSTRAINT', N'JHIST_DEPT_FK'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'JHIST_EMP_FK'  AND sc.name = N'HR'  AND type in (N'F'))
ALTER TABLE [HR].[JOB_HISTORY] DROP CONSTRAINT [JHIST_EMP_FK]
 GO



ALTER TABLE [HR].[JOB_HISTORY]
 ADD CONSTRAINT [JHIST_EMP_FK]
 FOREIGN KEY 
   ([EMPLOYEE_ID])
 REFERENCES 
   [HR].[EMPLOYEES]     ([EMPLOYEE_ID])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'HR.JOB_HISTORY.JHIST_EMP_FK',
        N'SCHEMA', N'HR',
        N'TABLE', N'JOB_HISTORY',
        N'CONSTRAINT', N'JHIST_EMP_FK'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'JHIST_JOB_FK'  AND sc.name = N'HR'  AND type in (N'F'))
ALTER TABLE [HR].[JOB_HISTORY] DROP CONSTRAINT [JHIST_JOB_FK]
 GO



ALTER TABLE [HR].[JOB_HISTORY]
 ADD CONSTRAINT [JHIST_JOB_FK]
 FOREIGN KEY 
   ([JOB_ID])
 REFERENCES 
   [HR].[JOBS]     ([JOB_ID])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'HR.JOB_HISTORY.JHIST_JOB_FK',
        N'SCHEMA', N'HR',
        N'TABLE', N'JOB_HISTORY',
        N'CONSTRAINT', N'JHIST_JOB_FK'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'LOC_C_ID_FK'  AND sc.name = N'HR'  AND type in (N'F'))
ALTER TABLE [HR].[LOCATIONS] DROP CONSTRAINT [LOC_C_ID_FK]
 GO



ALTER TABLE [HR].[LOCATIONS]
 ADD CONSTRAINT [LOC_C_ID_FK]
 FOREIGN KEY 
   ([COUNTRY_ID])
 REFERENCES 
   [HR].[COUNTRIES]     ([COUNTRY_ID])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'HR.LOCATIONS.LOC_C_ID_FK',
        N'SCHEMA', N'HR',
        N'TABLE', N'LOCATIONS',
        N'CONSTRAINT', N'LOC_C_ID_FK'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'EMP_SALARY_MIN'  AND sc.name = N'HR'  AND type in (N'C'))
ALTER TABLE [HR].[EMPLOYEES] DROP CONSTRAINT [EMP_SALARY_MIN]
 GO



ALTER TABLE [HR].[EMPLOYEES]
 ADD CONSTRAINT [EMP_SALARY_MIN]
 CHECK (SALARY > 0)
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'HR.EMPLOYEES.EMP_SALARY_MIN',
        N'SCHEMA', N'HR',
        N'TABLE', N'EMPLOYEES',
        N'CONSTRAINT', N'EMP_SALARY_MIN'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH

GO

IF EXISTS (SELECT * FROM sys.objects so JOIN sys.schemas sc ON so.schema_id = sc.schema_id WHERE so.name = N'JHIST_DATE_INTERVAL'  AND sc.name = N'HR'  AND type in (N'C'))
ALTER TABLE [HR].[JOB_HISTORY] DROP CONSTRAINT [JHIST_DATE_INTERVAL]
 GO



ALTER TABLE [HR].[JOB_HISTORY]
 ADD CONSTRAINT [JHIST_DATE_INTERVAL]
 CHECK (END_DATE > START_DATE)
BEGIN TRY
    EXEC sp_addextendedproperty
        N'MS_SSMA_SOURCE', N'HR.JOB_HISTORY.JHIST_DATE_INTERVAL',
        N'SCHEMA', N'HR',
        N'TABLE', N'JOB_HISTORY',
        N'CONSTRAINT', N'JHIST_DATE_INTERVAL'
END TRY
BEGIN CATCH
    IF (@@TRANCOUNT > 0) ROLLBACK
    PRINT ERROR_MESSAGE()
END CATCH

GO

ALTER TABLE  [HR].[EMPLOYEES]
 ADD DEFAULT (newid()) FOR [ROWID]
GO


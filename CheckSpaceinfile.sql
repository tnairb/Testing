--BACKUP LOG [Conversion] TO  [Conv] WITH truncate_only
GO

--select * from sys.databases


    SELECT name AS 'File Name' , physical_name AS 'Physical Name', size/128 AS 'Total Size in MB',   
    size/128.0 - CAST(FILEPROPERTY(name, 'SpaceUsed') AS int)/128.0 AS 'Available Space In MB'
	,max_size/128.0 as MaxSize
	,growth   
        ,CASE df.is_percent_growth
          WHEN 0 THEN STR(CAST((df.growth / 128.0) AS DECIMAL(10, 2))) + ' MB'
          WHEN 1 THEN STR(df.growth) + '%'
        END AS auto_grow_setting
    FROM sys.database_files df;  

--sp_helpfile

--dbcc checkdb

--dbcc opentran

--select * from sys.database_files

--SELECT DB_NAME(DATABASE_ID)DBNAME, [NAME] LOGICAL_FILENAME, [SIZE]*8/1024 SIZE_MB
--FROM MASTER.SYS.MASTER_FILES
--WHERE DB_NAME(DATABASE_ID) = 'TEMPDB'

--sp_updatestats


--checkpoint

--getting a list of all files
--

--    SELECT db_name(database_id) as DBName,name AS 'File Name' , physical_name AS 'Physical Name', size/128 AS 'Total Size in MB',   

----    size/128.0 - CAST(FILEPROPERTY(name, 'SpaceUsed') AS int)/128.0 AS 'Available Space In MB'
--	cast(0 as float) as 'Available Space in MB'
--	,max_size/128.0 as MaxSize,growth--, *  
--	into #tmp m
--    FROM sys.master_files  
--	order by database_id

--	select * from #tmp

--use cdwiapp
--create tmp table above
--run this against all databases
--update #tmp
--set [Available Space in MB] = 
--	(select 	size/128.0 - Cast(Fileproperty(name,'Spaceused') as int)/128.0
--	 from sys.database_files where physical_name = #tmp.[physical name])
--where #tmp.dbname = db_name()


declare @size as int, @name varchar(50)

select @size = size/128, @name = name from sys.database_files where name like '%log'
print 'dbcc loginfo'
print 'go'
print 'Use [' + db_name() + ']'
print 'go'
print 'dbcc shrinkfile (N''' + @name + ''',0,Truncateonly)'
print 'go'
print '/*'
print 'alter database ' + db_name()
print 'modify file ('
print 'name = ''' + @name + ''''
print ', size = ' + cast (@size as varchar) + ' )'
print '*/'

--Virtual log files
dbcc loginfo
--USE [CDAZAPP]
--GO
--DBCC SHRINKFILE (N'CDAZApp_Log' , 0, TRUNCATEONLY)
--GO

--ALTER DATABASE CDAZAPP
-- MODIFY FILE 
-- ( 
--       NAME = 'CDAZApp_Log'
--     , SIZE = 3000
--) 





/* 
Script: Ronald de Groot 
Author: ronald.de.groot@opendata.nl
Date: 2021-06-02

AMD Ryzen Threadripper 1950X 16-code / 128gb (122 gb for Sql Engine)
Disks 4 NVMe Samsung SSD 960 2Tb on PCi Card

select @@version
Microsoft SQL Server 2019 (RTM-GDR) (KB4583458) - 15.0.2080.9 (X64)   Nov  6 2020 16:50:01   
Copyright (C) 2019 Microsoft Corporation  Developer Edition (64-bit) 
	on Windows 10 Pro 10.0 <X64> (Build 19042: ) (Hypervisor) 

----------------------------------------------------------------------------------------------------
--// Source:  https://ola.hallengren.com                                                        //--
--// License: https://ola.hallengren.com/license.html                                           //--
--// GitHub:  https://github.com/olahallengren/sql-server-maintenance-solution                  //--
--// Version: 2020-12-31 18:58:56                                                               //--
----------------------------------------------------------------------------------------------------

Dynamic number of backup files (see: Pass 2020 Ola's (Many Thanks!) presentation: Getting the Most Out of the 'SQL Server Maintenance Solution').
Databases that are 10 gb or larger will be backed up to 4 files
Smaller databases will be backed up to 1 file
10240 = 10gb
1024  =  1gb

This determines the size 'Allocated extent page count'
(Ola displays the value when a full backup is made)

select * from StackOverflow2010.sys.database_files
size = 1260080 * 8 = 10.080.640 kb = 9844 mb = 9.61 gb
-- 9.61 gb

select sum(size) * 8 / 1024. /* mb */ / 1024. /* gb */ as size
from StackOverflow2013.sys.database_files
where type_desc = 'ROWS'
-- 55.78 gb

select sum(size) * 8 / 1024. /* mb */ / 1024. /* gb */ as size
from StackOverflow.sys.database_files
where type_desc = 'ROWS'
-- 380.80 gb
*/

/* StackOverflow2010 */

exec dbo.DatabaseBackup 
  @Databases =  'StackOverflow2010'
, @Directory = 'D:\backups'
, @BackupType = 'Full'
, @Compress = 'Y'
, @CheckSum = 'Y'

exec dbo.DatabaseBackup 
  @Databases =  'StackOverflow2010'
, @Directory = 'D:\backups'
, @BackupType = 'Full'
, @Compress = 'Y'
, @CheckSum = 'Y'
, @NumberOfFiles = 4
, @MinBackupSizeForMultipleFiles = 1024 -- Threshold in MB for when multiple files should be created

exec dbo.DatabaseBackup 
  @Databases =  'StackOverflow2010'
, @Directory = 'D:\backups'
, @BackupType = 'Full'
, @Compress = 'Y'
, @CheckSum = 'Y'
, @MaxFileSize = 1024 -- Threshold in MB for when multiple files should be created

/* StackOverflow2013 */

exec dbo.DatabaseBackup 
  @Databases =  'StackOverflow2013'
, @Directory = 'D:\backups'
, @BackupType = 'Full'
, @Compress = 'Y'
, @CheckSum = 'Y'

/*
Date and time: 2021-06-02 10:34:58
Database: [StackOverflow2013]
State: ONLINE
...
Allocated extent page count: 1168344 (9127.687500 MB)  <-- 
Modified extent page count: 40 (0.312500 MB)



*/

exec dbo.DatabaseBackup 
  @Databases =  'StackOverflow2013'
, @Directory = 'D:\backups'
, @BackupType = 'Full'
, @Compress = 'Y'
, @CheckSum = 'Y'
, @NumberOfFiles = 4
, @MinBackupSizeForMultipleFiles = 5120    -- Threshold in MB for when multiple files should be created
--, @MinBackupSizeForMultipleFiles = 10240 -- Threshold in MB for when multiple files should be created

/*
BACKUP DATABASE [StackOverflow2013] 
	TO DISK = N'D:\backups\WIN10\StackOverflow2013\Full\WIN10_StackOverflow2013_Full_20210602_104914_1.bak'
	 , DISK = N'D:\backups\WIN10\StackOverflow2013\Full\WIN10_StackOverflow2013_Full_20210602_104914_2.bak'
	 , DISK = N'D:\backups\WIN10\StackOverflow2013\Full\WIN10_StackOverflow2013_Full_20210602_104914_3.bak'
	 , DISK = N'D:\backups\WIN10\StackOverflow2013\Full\WIN10_StackOverflow2013_Full_20210602_104914_4.bak'
	 WITH CHECKSUM, COMPRESSION
*/

exec dbo.DatabaseBackup 
  @Databases =  'StackOverflow2013'
, @Directory = 'D:\backups'
, @BackupType = 'Full'
, @Compress = 'Y'
, @CheckSum = 'Y'
, @MaxFileSize = 2048 -- Threshold in MB for when multiple files should be created

/*
Date and time: 2021-06-02 11:08:37
Database context: [master]
Command: BACKUP DATABASE [StackOverflow2013] TO DISK = N'D:\backups\WIN10\StackOverflow2013\Full\WIN10_StackOverflow2013_Full_20210602_110837_1.bak', DISK = N'D:\backups\WIN10\StackOverflow2013\Full\WIN10_StackOverflow2013_Full_20210602_110837_2.bak', DISK = N'D:\backups\WIN10\StackOverflow2013\Full\WIN10_StackOverflow2013_Full_20210602_110837_3.bak', DISK = N'D:\backups\WIN10\StackOverflow2013\Full\WIN10_StackOverflow2013_Full_20210602_110837_4.bak', DISK = N'D:\backups\WIN10\StackOverflow2013\Full\WIN10_StackOverflow2013_Full_20210602_110837_5.bak' WITH CHECKSUM, COMPRESSION
Processed 1920616 pages for database 'StackOverflow2013', file 'StackOverflow2013_1' on file 1.
Processed 1793368 pages for database 'StackOverflow2013', file 'StackOverflow2013_2' on file 1.
Processed 1795104 pages for database 'StackOverflow2013', file 'StackOverflow2013_3' on file 1.
Processed 1795104 pages for database 'StackOverflow2013', file 'StackOverflow2013_4' on file 1.
Processed 1 pages for database 'StackOverflow2013', file 'StackOverflow2013_log' on file 1.
BACKUP DATABASE successfully processed 7304193 pages in 38.749 seconds (1472.657 MB/sec).
Outcome: Succeeded
Duration: 00:00:39
Date and time: 2021-06-02 11:09:16
*/

exec dbo.DatabaseBackup 
  @Databases =  'StackOverflow2013'
, @Directory = 'D:\backups'
, @BackupType = 'Full'
, @Compress = 'Y'
, @CheckSum = 'Y'
, @MaxFileSize = 2048 
, @BufferCount = 50
, @MaxTransferSize = 4194304

/*
Date and time: 2021-06-02 12:51:05
Database context: [master]
Command: BACKUP DATABASE [StackOverflow2013] TO DISK = N'D:\backups\WIN10\StackOverflow2013\Full\WIN10_StackOverflow2013_Full_20210602_125105_1.bak', DISK = N'D:\backups\WIN10\StackOverflow2013\Full\WIN10_StackOverflow2013_Full_20210602_125105_2.bak', DISK = N'D:\backups\WIN10\StackOverflow2013\Full\WIN10_StackOverflow2013_Full_20210602_125105_3.bak', DISK = N'D:\backups\WIN10\StackOverflow2013\Full\WIN10_StackOverflow2013_Full_20210602_125105_4.bak', DISK = N'D:\backups\WIN10\StackOverflow2013\Full\WIN10_StackOverflow2013_Full_20210602_125105_5.bak' WITH CHECKSUM, COMPRESSION, BUFFERCOUNT = 50, MAXTRANSFERSIZE = 4194304
Processed 1920616 pages for database 'StackOverflow2013', file 'StackOverflow2013_1' on file 1.
Processed 1793368 pages for database 'StackOverflow2013', file 'StackOverflow2013_2' on file 1.
Processed 1795104 pages for database 'StackOverflow2013', file 'StackOverflow2013_3' on file 1.
Processed 1795104 pages for database 'StackOverflow2013', file 'StackOverflow2013_4' on file 1.
Processed 1 pages for database 'StackOverflow2013', file 'StackOverflow2013_log' on file 1.
BACKUP DATABASE successfully processed 7304193 pages in 21.375 seconds (2669.660 MB/sec).
Outcome: Succeeded
Duration: 00:00:21
Date and time: 2021-06-02 12:51:26
*/


/* StackOverflow */

exec dbo.DatabaseBackup 
  @Databases =  'StackOverflow'
, @Directory = 'D:\backups'
, @BackupType = 'Full'
, @Compress = 'Y'
, @CheckSum = 'Y'

/*
Date and time: 2021-06-02 11:15:22
Database: [StackOverflow]
State: ONLINE
Standby: No
..
Allocated extent page count: 820744 (6412.062500 MB) <----
Modified extent page count:     200    (1.562500 MB)
*/

exec dbo.DatabaseBackup 
  @Databases =  'StackOverflow'
, @Directory = 'D:\backups'
, @BackupType = 'Full'
, @Compress = 'Y'
, @CheckSum = 'Y'
, @NumberOfFiles = 4
-- , @MinBackupSizeForMultipleFiles = 5120    -- Threshold in MB for when multiple files should be created
-- , @MinBackupSizeForMultipleFiles = 10240 -- Threshold in MB for when multiple files should be created
, @MinBackupSizeForMultipleFiles = 51200 -- Threshold in MB (50gb) for when multiple files should be created

/*
Date and time: 2021-06-02 12:05:05
Database context: [master]
Command: BACKUP DATABASE [StackOverflow] TO DISK = N'D:\backups\WIN10\StackOverflow\Full\WIN10_StackOverflow_Full_20210602_120505.bak' WITH CHECKSUM, COMPRESSION
Processed 12494872 pages for database 'StackOverflow', file 'StackOverflow_1' on file 1.
Processed 12429320 pages for database 'StackOverflow', file 'StackOverflow_2' on file 1.
Processed 12480856 pages for database 'StackOverflow', file 'StackOverflow_3' on file 1.
Processed 12494856 pages for database 'StackOverflow', file 'StackOverflow_4' on file 1.
Processed 4 pages for database 'StackOverflow', file 'StackOverflow_log' on file 1.
BACKUP DATABASE successfully processed 49899908 pages in 790.083 seconds (493.420 MB/sec).
Outcome: Succeeded
Duration: 00:13:10
Date and time: 2021-06-02 12:18:15
*/

exec dbo.DatabaseBackup 
  @Databases =  'StackOverflow'
, @Directory = 'D:\backups'
, @BackupType = 'Full'
, @Compress = 'Y'
, @CheckSum = 'Y'
, @MaxFileSize = 10240 -- Threshold in MB for when multiple files should be created

/*
Date and time: 2021-06-02 12:18:47
Database context: [master]
Command: BACKUP DATABASE [StackOverflow] TO DISK = N'D:\backups\WIN10\StackOverflow\Full\WIN10_StackOverflow_Full_20210602_121847.bak' WITH CHECKSUM, COMPRESSION
Processed 12494872 pages for database 'StackOverflow', file 'StackOverflow_1' on file 1.
Processed 12429320 pages for database 'StackOverflow', file 'StackOverflow_2' on file 1.
Processed 12480848 pages for database 'StackOverflow', file 'StackOverflow_3' on file 1.
Processed 12494856 pages for database 'StackOverflow', file 'StackOverflow_4' on file 1.
Processed 4 pages for database 'StackOverflow', file 'StackOverflow_log' on file 1.
BACKUP DATABASE successfully processed 49899900 pages in 810.474 seconds (481.006 MB/sec).
Outcome: Succeeded
Duration: 00:13:31
Date and time: 2021-06-02 12:32:18
*/

exec dbo.DatabaseBackup 
  @Databases =  'StackOverflow'
, @Directory = 'D:\backups'
, @BackupType = 'Full'
, @Compress = 'Y'
, @CheckSum = 'Y'
, @MaxFileSize = 5120 -- Threshold in MB for when multiple files should be created

/*
Date and time: 2021-06-02 12:32:50
Database context: [master]
Command: BACKUP DATABASE [StackOverflow] 
TO DISK = N'D:\backups\WIN10\StackOverflow\Full\WIN10_StackOverflow_Full_20210602_123250_1.bak', 
   DISK = N'D:\backups\WIN10\StackOverflow\Full\WIN10_StackOverflow_Full_20210602_123250_2.bak' WITH CHECKSUM, COMPRESSION
Processed 12494872 pages for database 'StackOverflow', file 'StackOverflow_1' on file 1.
Processed 12429320 pages for database 'StackOverflow', file 'StackOverflow_2' on file 1.
Processed 12480848 pages for database 'StackOverflow', file 'StackOverflow_3' on file 1.
Processed 12494856 pages for database 'StackOverflow', file 'StackOverflow_4' on file 1.
Processed 4 pages for database 'StackOverflow', file 'StackOverflow_log' on file 1.
BACKUP DATABASE successfully processed 49899900 pages in 568.148 seconds (686.164 MB/sec).
Outcome: Succeeded
Duration: 00:09:28
Date and time: 2021-06-02 12:42:18
*/

exec dbo.DatabaseBackup 
  @Databases =  'StackOverflow'
, @Directory = 'D:\backups'
, @BackupType = 'Full'
, @Compress = 'Y'
, @CheckSum = 'Y'
, @MaxFileSize = 5120 
, @BufferCount = 50
, @MaxTransferSize = 4194304

/*
Date and time: 2021-06-02 12:42:40
Database context: [master]
Command: BACKUP DATABASE [StackOverflow] TO DISK = N'D:\backups\WIN10\StackOverflow\Full\WIN10_StackOverflow_Full_20210602_124240_1.bak', DISK = N'D:\backups\WIN10\StackOverflow\Full\WIN10_StackOverflow_Full_20210602_124240_2.bak' WITH CHECKSUM, COMPRESSION, BUFFERCOUNT = 50, MAXTRANSFERSIZE = 4194304
Processed 12494864 pages for database 'StackOverflow', file 'StackOverflow_1' on file 1.
Processed 12429320 pages for database 'StackOverflow', file 'StackOverflow_2' on file 1.
Processed 12480808 pages for database 'StackOverflow', file 'StackOverflow_3' on file 1.
Processed 12494856 pages for database 'StackOverflow', file 'StackOverflow_4' on file 1.
Processed 1 pages for database 'StackOverflow', file 'StackOverflow_log' on file 1.
BACKUP DATABASE successfully processed 49899849 pages in 152.049 seconds (2563.927 MB/sec).
Outcome: Succeeded
Duration: 00:02:33
Date and time: 2021-06-02 12:45:13

BACKUP DATABASE successfully processed 49899900 pages in 810.474 seconds  (481.006 MB/sec).
BACKUP DATABASE successfully processed 49899849 pages in 152.049 seconds (2563.927 MB/sec).
BACKUP DATABASE successfully processed  7304193 pages in  21.375 seconds (2669.660 MB/sec).



*/ 
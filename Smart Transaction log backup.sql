/*
Script: Ronald de Groot 
Author: ronald.de.groot@opendata.nl / 06 51222023
Date: 2021-06-02

AMD Ryzen Threadripper 1950X 16-code / 128gb (122 gb for Sql Engine)
Disks 4 NVMe Samsung SSD 960 2Tb on PCi Card

select @@version
Microsoft SQL Server 2019 (RTM-GDR) (KB4583458) - 15.0.2080.9 (X64)   Nov  6 2020 16:50:01   
Copyright (C) 2019 Microsoft Corporation  Developer Edition (64-bit) 
	on Windows 10 Pro 10.0 <X64> (Build 19042: ) (Hypervisor) 

Smart Transaction log Backup
Perform a log backup when one of these conditions have been met:
 a) 100mb of log has been generated
 b) It is 300 seconds or more, since the last log backup 

 select log_since_last_log_backup_mb, total_log_size_mb, log_backup_time
 from sys.dm_db_log_stats(DB_ID('WideWorldImportersDW'));

*/

/*
log_since_last_log_backup_mb	total_log_size_mb	log_backup_time
0.841308						99.992187			2021-06-03 10:10:32.313
*/

execute dbo.DatabaseBackup 
  @Databases = 'WideWorldImportersDW'
, @Directory = 'D:\backups'
, @BackupType = 'Log'
, @Compress = 'Y'
, @CheckSum = 'Y'
, @LogSizeSinceLastLogBackup = 100
, @TimeSinceLastLogBackup = 300

/*
Date and time: 2021-06-03 10:11:13
Server: WIN10
Version: 15.0.2080.9
Edition: Developer Edition (64-bit)
Platform: Windows
Procedure: [msdb].[dbo].[DatabaseBackup]
Parameters: @Databases = 'WideWorldImportersDW'
	, @Directory = 'D:\backups'
	, @BackupType = 'Log'
	, @Verify = 'N'
	, @CleanupTime = NULL
	, @CleanupMode = 'AFTER_BACKUP'
	, @Compress = 'Y'
	, @CopyOnly = 'N'
	, @ChangeBackupType = 'N'
	, @BackupSoftware = NULL, @CheckSum = 'Y', @BlockSize = NULL, @BufferCount = NULL
	, @MaxTransferSize = NULL, @NumberOfFiles = NULL, @MinBackupSizeForMultipleFiles = NULL, @MaxFileSize = NULL, @CompressionLevel = NULL, @Description = NULL, @Threads = NULL, @Throttle = NULL, @Encrypt = 'N', @EncryptionAlgorithm = NULL, @ServerCertificate = NULL, @ServerAsymmetricKey = NULL, @EncryptionKey = NULL, @ReadWriteFileGroups = 'N', @OverrideBackupPreference = 'N', @NoRecovery = 'N', @URL = NULL, @Credential = NULL, @MirrorDirectory = NULL, @MirrorCleanupTime = NULL, @MirrorCleanupMode = 'AFTER_BACKUP', @MirrorURL = NULL, @AvailabilityGroups = NULL, @Updateability = 'ALL', @AdaptiveCompression = NULL, @ModificationLevel = NULL, @LogSizeSinceLastLogBackup = 100, @TimeSinceLastLogBackup = 300, @DataDomainBoostHost = NULL, @DataDomainBoostUser = NULL, @DataDomainBoostDevicePath = NULL, @DataDomainBoostLockboxPath = NULL, @DirectoryStructure = '{ServerName}${InstanceName}{DirectorySeparator}{DatabaseName}{DirectorySeparator}{BackupType}_{Partial}_{CopyOnly}', @AvailabilityGroupDirectoryStructure = '{ClusterName}${AvailabilityGroupName}{DirectorySeparator}{DatabaseName}{DirectorySeparator}{BackupType}_{Partial}_{CopyOnly}', @FileName = '{ServerName}${InstanceName}_{DatabaseName}_{BackupType}_{Partial}_{CopyOnly}_{Year}{Month}{Day}_{Hour}{Minute}{Second}_{FileNumber}.{FileExtension}', @AvailabilityGroupFileName = '{ClusterName}${AvailabilityGroupName}_{DatabaseName}_{BackupType}_{Partial}_{CopyOnly}_{Year}{Month}{Day}_{Hour}{Minute}{Second}_{FileNumber}.{FileExtension}', @FileExtensionFull = NULL, @FileExtensionDiff = NULL, @FileExtensionLog = NULL, @Init = 'N', @Format = 'N', @ObjectLevelRecoveryMap = 'N', @ExcludeLogShippedFromLogBackup = 'Y', @StringDelimiter = ',', @DatabaseOrder = NULL, @DatabasesInParall...
Version: 2020-12-31 18:58:56
Source: https://ola.hallengren.com
	
Date and time: 2021-06-03 10:11:13
Database: [WideWorldImportersDW]
State: ONLINE
Standby: No
Updateability: READ_WRITE
User access: MULTI_USER
Recovery model: FULL
Encrypted: No
Is accessible: Yes
Differential base LSN: 64000000253700001
Last log backup LSN: 64000000095200002
Last log backup: 2021-06-03 10:10:32				(now: 10:13  -> Skipped)
Log size since last log backup (MB): 0.841308		(under 100mb -> Skipped)
	
Date and time: 2021-06-03 10:11:13
	

Completion time: 2021-06-03T10:11:14.0020458+02:00
*/

execute dbo.DatabaseBackup 
  @Databases = 'WideWorldImportersDW'
, @Directory = 'D:\backups'
, @BackupType = 'Log'
, @Compress = 'Y'
, @CheckSum = 'Y'
, @LogSizeSinceLastLogBackup = 100
, @TimeSinceLastLogBackup = 300

/*
Date and time: 2021-06-03 10:53:02
Server: WIN10
Version: 15.0.2080.9
Edition: Developer Edition (64-bit)
Platform: Windows
Procedure: [msdb].[dbo].[DatabaseBackup]
Parameters: @Databases = 'WideWorldImportersDW', @Directory = 'D:\backups', @BackupType = 'Log', @Verify = 'N', @CleanupTime = NULL, @CleanupMode = 'AFTER_BACKUP', @Compress = 'Y', @CopyOnly = 'N', @ChangeBackupType = 'N', @BackupSoftware = NULL, @CheckSum = 'Y', @BlockSize = NULL, @BufferCount = NULL, @MaxTransferSize = NULL, @NumberOfFiles = NULL, @MinBackupSizeForMultipleFiles = NULL, @MaxFileSize = NULL, @CompressionLevel = NULL, @Description = NULL, @Threads = NULL, @Throttle = NULL, @Encrypt = 'N', @EncryptionAlgorithm = NULL, @ServerCertificate = NULL, @ServerAsymmetricKey = NULL, @EncryptionKey = NULL, @ReadWriteFileGroups = 'N', @OverrideBackupPreference = 'N', @NoRecovery = 'N', @URL = NULL, @Credential = NULL, @MirrorDirectory = NULL, @MirrorCleanupTime = NULL, @MirrorCleanupMode = 'AFTER_BACKUP', @MirrorURL = NULL, @AvailabilityGroups = NULL, @Updateability = 'ALL', @AdaptiveCompression = NULL, @ModificationLevel = NULL, @LogSizeSinceLastLogBackup = 100, @TimeSinceLastLogBackup = 300, @DataDomainBoostHost = NULL, @DataDomainBoostUser = NULL, @DataDomainBoostDevicePath = NULL, @DataDomainBoostLockboxPath = NULL, @DirectoryStructure = '{ServerName}${InstanceName}{DirectorySeparator}{DatabaseName}{DirectorySeparator}{BackupType}_{Partial}_{CopyOnly}', @AvailabilityGroupDirectoryStructure = '{ClusterName}${AvailabilityGroupName}{DirectorySeparator}{DatabaseName}{DirectorySeparator}{BackupType}_{Partial}_{CopyOnly}', @FileName = '{ServerName}${InstanceName}_{DatabaseName}_{BackupType}_{Partial}_{CopyOnly}_{Year}{Month}{Day}_{Hour}{Minute}{Second}_{FileNumber}.{FileExtension}', @AvailabilityGroupFileName = '{ClusterName}${AvailabilityGroupName}_{DatabaseName}_{BackupType}_{Partial}_{CopyOnly}_{Year}{Month}{Day}_{Hour}{Minute}{Second}_{FileNumber}.{FileExtension}', @FileExtensionFull = NULL, @FileExtensionDiff = NULL, @FileExtensionLog = NULL, @Init = 'N', @Format = 'N', @ObjectLevelRecoveryMap = 'N', @ExcludeLogShippedFromLogBackup = 'Y', @StringDelimiter = ',', @DatabaseOrder = NULL, @DatabasesInParall...
Version: 2020-12-31 18:58:56
Source: https://ola.hallengren.com
	
Date and time: 2021-06-03 10:53:02
Database: [WideWorldImportersDW]
State: ONLINE
Standby: No
Updateability: READ_WRITE
User access: MULTI_USER
Recovery model: FULL
Encrypted: No
Is accessible: Yes
Differential base LSN: 64000000253700001
Last log backup LSN: 64000000095200002
Last log backup: 2021-06-03 10:10:32
Log size since last log backup (MB): 1.58252
	
Date and time: 2021-06-03 10:53:02
Database context: [master]
Command: DECLARE @ReturnCode int EXECUTE @ReturnCode = dbo.xp_create_subdir N'D:\backups\WIN10\WideWorldImportersDW\Log' IF @ReturnCode <> 0 RAISERROR('Error creating directory.', 16, 1)
Outcome: Succeeded
Duration: 00:00:00
Date and time: 2021-06-03 10:53:02
	
Date and time: 2021-06-03 10:53:02
Database context: [master]
Command: BACKUP LOG [WideWorldImportersDW] 
	TO DISK = N'D:\backups\WIN10\WideWorldImportersDW\Log\WIN10_WideWorldImportersDW_Log_20210603_105302.trn' 
	WITH CHECKSUM, COMPRESSION
Processed 196 pages for database 'WideWorldImportersDW', file 'WWI_Log' on file 1.
BACKUP LOG successfully processed 196 pages in 0.037 seconds (41.187 MB/sec).
Outcome: Succeeded
Duration: 00:00:00
Date and time: 2021-06-03 10:53:02  (Not Skipped last log backup was: 2021-06-03 10:10:32)
	
Date and time: 2021-06-03 10:53:02

Completion time: 2021-06-03T10:53:02.9542027+02:00
*/

select log_since_last_log_backup_mb, total_log_size_mb, log_backup_time
from sys.dm_db_log_stats(DB_ID('WideWorldImportersDW'));

/*
log_since_last_log_backup_mb	total_log_size_mb	log_backup_time
0.112304						99.992187			2021-06-03 10:53:02.870
*/

-- Update statement to generate transaction log records
update WideWorldImportersDW.fact.[order]
set [description] = [description]
where [order date key] >= '2015-10-01'

select log_since_last_log_backup_mb, total_log_size_mb, log_backup_time
from sys.dm_db_log_stats(DB_ID('WideWorldImportersDW'));

/*
log_since_last_log_backup_mb	total_log_size_mb	log_backup_time
122.387695						291.992187			2021-06-03 10:53:02.870
*/

execute dbo.DatabaseBackup 
  @Databases = 'WideWorldImportersDW'
, @Directory = 'D:\backups'
, @BackupType = 'Log'
, @Compress = 'Y'
, @CheckSum = 'Y'
, @LogSizeSinceLastLogBackup = 100
, @TimeSinceLastLogBackup = 300

/*
Date and time: 2021-06-03 11:08:42
Server: WIN10
Version: 15.0.2080.9
Edition: Developer Edition (64-bit)
Platform: Windows
Procedure: [msdb].[dbo].[DatabaseBackup]
Parameters: @Databases = 'WideWorldImportersDW', @Directory = 'D:\backups', @BackupType = 'Log', @Verify = 'N', @CleanupTime = NULL, @CleanupMode = 'AFTER_BACKUP', @Compress = 'Y', @CopyOnly = 'N', @ChangeBackupType = 'N', @BackupSoftware = NULL, @CheckSum = 'Y', @BlockSize = NULL, @BufferCount = NULL, @MaxTransferSize = NULL, @NumberOfFiles = NULL, @MinBackupSizeForMultipleFiles = NULL, @MaxFileSize = NULL, @CompressionLevel = NULL, @Description = NULL, @Threads = NULL, @Throttle = NULL, @Encrypt = 'N', @EncryptionAlgorithm = NULL, @ServerCertificate = NULL, @ServerAsymmetricKey = NULL, @EncryptionKey = NULL, @ReadWriteFileGroups = 'N', @OverrideBackupPreference = 'N', @NoRecovery = 'N', @URL = NULL, @Credential = NULL, @MirrorDirectory = NULL, @MirrorCleanupTime = NULL, @MirrorCleanupMode = 'AFTER_BACKUP', @MirrorURL = NULL, @AvailabilityGroups = NULL, @Updateability = 'ALL', @AdaptiveCompression = NULL, @ModificationLevel = NULL, @LogSizeSinceLastLogBackup = 100, @TimeSinceLastLogBackup = 300, @DataDomainBoostHost = NULL, @DataDomainBoostUser = NULL, @DataDomainBoostDevicePath = NULL, @DataDomainBoostLockboxPath = NULL, @DirectoryStructure = '{ServerName}${InstanceName}{DirectorySeparator}{DatabaseName}{DirectorySeparator}{BackupType}_{Partial}_{CopyOnly}', @AvailabilityGroupDirectoryStructure = '{ClusterName}${AvailabilityGroupName}{DirectorySeparator}{DatabaseName}{DirectorySeparator}{BackupType}_{Partial}_{CopyOnly}', @FileName = '{ServerName}${InstanceName}_{DatabaseName}_{BackupType}_{Partial}_{CopyOnly}_{Year}{Month}{Day}_{Hour}{Minute}{Second}_{FileNumber}.{FileExtension}', @AvailabilityGroupFileName = '{ClusterName}${AvailabilityGroupName}_{DatabaseName}_{BackupType}_{Partial}_{CopyOnly}_{Year}{Month}{Day}_{Hour}{Minute}{Second}_{FileNumber}.{FileExtension}', @FileExtensionFull = NULL, @FileExtensionDiff = NULL, @FileExtensionLog = NULL, @Init = 'N', @Format = 'N', @ObjectLevelRecoveryMap = 'N', @ExcludeLogShippedFromLogBackup = 'Y', @StringDelimiter = ',', @DatabaseOrder = NULL, @DatabasesInParall...
Version: 2020-12-31 18:58:56
Source: https://ola.hallengren.com
	
Date and time: 2021-06-03 11:08:42
Database: [WideWorldImportersDW]
State: ONLINE
Standby: No
Updateability: READ_WRITE
User access: MULTI_USER
Recovery model: FULL
Encrypted: No
Is accessible: Yes
Differential base LSN: 64000000253700001
Last log backup LSN: 64000000407300001
Last log backup: 2021-06-03 10:53:02
Log size since last log backup (MB): 122.388  <---- exceeds the 100mb threshold
	
Date and time: 2021-06-03 11:08:42
Database context: [master]
Command: DECLARE @ReturnCode int EXECUTE @ReturnCode = dbo.xp_create_subdir N'D:\backups\WIN10\WideWorldImportersDW\Log' IF @ReturnCode <> 0 RAISERROR('Error creating directory.', 16, 1)
Outcome: Succeeded
Duration: 00:00:00
Date and time: 2021-06-03 11:08:42
	
Date and time: 2021-06-03 11:08:42
Database context: [master]
Command: BACKUP LOG [WideWorldImportersDW] 
	TO DISK = N'D:\backups\WIN10\WideWorldImportersDW\Log\WIN10_WideWorldImportersDW_Log_20210603_110842.trn' 
	WITH CHECKSUM, COMPRESSION
Processed 15650 pages for database 'WideWorldImportersDW', file 'WWI_Log' on file 1.
BACKUP LOG successfully processed 15650 pages in 0.242 seconds (505.203 MB/sec).
Outcome: Succeeded
Duration: 00:00:00
Date and time: 2021-06-03 11:08:42
	
Date and time: 2021-06-03 11:08:42

Completion time: 2021-06-03T11:08:42.7974429+02:00

*/
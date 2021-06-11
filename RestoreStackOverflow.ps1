$server = 'WIN10'

function Restore-StackOverflow {
    Param (
        [ValidateSet("StackOverflow","StackOverflow2013","StackOverflow2010")]
        [Parameter(Mandatory = $true)]
        [string]$database
        ,[ValidateRange(1,10)]
         [int]$count
    )
    Write-Host 'Database to restore:' $database
    Write-Host 'Aantal databases om aan te maken:' $count
    $source_db = [string]::Format("E:\databases\{0}.bak",$database)
    Write-Host 'Bron backup file:' $source_db
    $i = 0
    while ($i -lt $count) {

        $destination_db = [string]::Format("{0}_{1}",$database,$i)
        Write-Host 'Database: ' $destination_db -nonewline
        
        $restore2010_sql =
@"
USE MASTER
GO
DROP DATABASE IF EXISTS [$($destination_db)]
GO
RESTORE DATABASE [$($destination_db)] 
        FROM  DISK = N'$($source_db)' WITH  FILE = 1
        ,  MOVE N'$($database)' TO N'D:\databases\$($database)_$($i).mdf'
        ,  MOVE N'$($database)_log' TO N'D:\databases\$($database)_$($i)_log.ldf'
"@        
    $restore2013_sql =
@"
USE MASTER
GO
DROP DATABASE IF EXISTS [$($destination_db)]
GO
RESTORE DATABASE [$($destination_db)] FROM  DISK = N'$($source_db)' WITH  FILE = 1
,  MOVE N'$($database)_1' TO N'D:\databases\$($database)_$($i)_1.mdf'
,  MOVE N'$($database)_2' TO N'D:\databases\$($database)_$($i)_2.ndf'
,  MOVE N'$($database)_3' TO N'D:\databases\$($database)_$($i)_3.ndf'
,  MOVE N'$($database)_4' TO N'D:\databases\$($database)_$($i)_4.ndf'
,  MOVE N'$($database)_log' TO N'D:\databases\$($database)_$($i)_log.ldf'
"@

        $restore_sql =
@"
USE MASTER
GO
DROP DATABASE IF EXISTS [$($destination_db)]
GO
RESTORE DATABASE [$($destination_db)] FROM  DISK = N'$($source_db)' WITH  FILE = 1
,  MOVE N'$($database)_1' TO N'D:\databases\$($database)_$($i)_1.mdf'
,  MOVE N'$($database)_2' TO N'D:\databases\$($database)_$($i)_2.ndf'
,  MOVE N'$($database)_3' TO N'D:\databases\$($database)_$($i)_3.ndf'
,  MOVE N'$($database)_4' TO N'D:\databases\$($database)_$($i)_4.ndf'
,  MOVE N'$($database)_log' TO N'D:\databases\$($database)_$($i)_log.ldf'
"@
        if ($database -eq "StackOverflow") {
            $sql = $restore_sql
        } elseif ($database -eq "StackOverflow2013") {
            $sql = $restore2013_sql
        } else {
            $sql = $restore2010_sql
        } 
        $Time = [System.Diagnostics.Stopwatch]::StartNew()
        Invoke-Sqlcmd -ServerInstance $server -Database 'master' -Query $sql -QueryTimeout 0
        $CurrentTime = $Time.Elapsed
        write-host $([string]::Format(" klaar in: {0:d2}:{1:d2}:{2:d2}",
                                          $CurrentTime.hours,
                                          $CurrentTime.minutes,
                                          $CurrentTime.seconds)) 
        $i += 1;
    }
}

Restore-StackOverflow 'StackOverflow2010' 4
Restore-StackOverflow 'StackOverflow2013' 2
Restore-StackOverflow 'StackOverflow' 1

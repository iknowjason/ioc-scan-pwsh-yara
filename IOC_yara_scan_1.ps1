<#
IOC Enterprise Scanning Script
Created for Company
Author:  Jason Ostrom
#>

$Logfile = "ioc_log.log"
Function LogWrite
{
   Param ([string]$logstring)

   Add-content $Logfile -value $logstring
}

$dt = Get-Date
##$csv_file = Write-host "IOC_Report-$dt.csv"
$csv_file = ".\IOC_Report.csv"
Function CSVWrite
{
   Param ([string]$csvstring)

   Add-content $csv_file -value $csvstring
}

## Create header in CSV
CSVWrite "Host,Result"

##CSVWrite "Host1,Result1"
###CSVWrite "Host2,Result2"

$lines = Get-Content -Path targets.txt | Measure-Object -Line
$linecount = $lines.Lines
$time = Get-Date
Write-Output "[+] Starting IOC Scan ~ Parsed hosts: $linecount"
LogWrite "[+] $time Starting IOC Scan ~ Parsed hosts: $linecount"
$i = 1
get-content "targets.txt" | foreach-object { 
    $Comp = $_ 
    $time = Get-Date
    Write-Output "[+] Connecting to host ${i}:  $comp"
    LogWrite "[+] $time Connecting to host ${i}:  $comp"
    if (test-connection -computername $Comp -count 1 -quiet) 
    { 
                #Write-Output "  [+] Uploading Yara executable and yara rules to $comp"
                copy .\fin1.yara \\$comp\C$\Windows\temp\. 
                copy .\yara64.exe \\$comp\C$\Windows\temp\. 
                Write-Output "  [+] On $comp, Running IOC scan against C:\Users\*"
                $time = Get-Date
                LogWrite "  [+] $time On $comp, Running IOC scan against C:\Users\*"
                $remoteexitcode = Invoke-Command -ComputerName $comp -ErrorAction SilentlyContinue -ScriptBlock { c:\Windows\temp\yara64.exe c:\Windows\temp\fin1.yara -r c:\users\; Remove-Item -Path C:\Windows\temp\fin1.yara; Remove-Item -Path C:\Windows\temp\yara64.exe }
                if ($remoteexitcode){
                    $time = Get-Date
                    Write-Output "    [-] FOUND IOC! $remoteexitcode"
                    LogWrite "    $time [-] FOUND IOC! $remoteexitcode"
                    CSVWrite "$comp,IOC Found!"
                } else {
                    $time = Get-Date
                    Write-Output "    [+] Did not find IOC on host"
                    LogWrite "    $time [+] Did not find IOC on host"
                    CSVWrite "$comp,Not Found"
                   
                }
                #Write-Output "  [+] Deleting yara files from C:\Window\temp"

    } Else {
        Write-Warning "[-] Server '$Comp' is Unreachable hence Could not fetch data"
        CSVWrite "$comp,Server Unreachable"
    } 
    $i++
}
$time = Get-Date
Write-Output "[+] Finished IOC Scan"
LogWrite "[+] $time Finished IOC Scan"
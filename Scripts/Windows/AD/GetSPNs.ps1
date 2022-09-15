# Usage:
# powershell Set-ExecutionPolicy -ExecutionPolicy Unrestricted
# powershell Import-Module .\GetSPNs.ps1 

# Why:
# By enumerating all registered SPNs in the domain, we can obtain the IP address and port number of applications running on servers 
# integrated with the target Active Directory, limiting the need for a broad port scan.

cls 

$search = New-Object DirectoryServices.DirectorySearcher([ADSI]"") 
$search.filter = "(servicePrincipalName=*)" 

## You can use this to filter for OU's: 
## $results = $search.Findall() | ?{ $_.path -like '*OU=whatever,DC=whatever,DC=whatever*' } 
$results = $search.Findall() 

foreach ( $result in $results ) { 
    $userEntry = $result.GetDirectoryEntry() 
    Write-host "Object Name = " $userEntry.name -backgroundcolor "yellow" -foregroundcolor "black" 
    Write-host "DN      =      "  $userEntry.distinguishedName 
    Write-host "Object Cat. = "  $userEntry.objectCategory 
    Write-host "servicePrincipalNames" 

  

    $i = 1 
    foreach ( $SPN in $userEntry.servicePrincipalName ) { 
        Write-host "SPN(" $i ")   =      " $SPN 
        $s2 = $SPN 
        $s2 = $s2.split('/')[1]  
        $s2 = $s2.split(':')[0]  
        Write-host "Hostname = " $s2 
        $ipv4 = ([System.Net.DNS]::GetHostAddresses($s2) | Where-Object { $_.AddressFamily -eq "InterNetwork" } | select-object IPAddressToString)[0].IPAddressToString 
        Write-host "IP Address = "  $ipv4 
        $i += 1 
    } 

    Write-host "" 
} 
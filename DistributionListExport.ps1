#Use the interactive login prompt to input credentials of your Exchange/Global admin account
Connect-ExchangeOnline

$exportfilename = Read-Host "Give full path and name of csv file to export data to (include extension .csv)."

#Fetch all distribution groups from Exchange Online
$distribuitongroups = Get-DistributionGroup -ResultSize Unlimited #Add filter here if you don't want all distribution groups

#Main array that holds the object data to be exported to csv
$alldata = @()
foreach ($distrgr in $distribuitongroups) {
    $members = @()
    Get-DistributionGroupMember $distrgr.Name | foreach {

        $members += $_.PrimarySmtpAddress + " "
    }
    $alldata += New-Object psobject -Property @{
        DisplayName = $distrgr.DisplayName
        PrimarySmtpAddress = $distrgr.PrimarySmtpAddress
        Membership = [string]$members
    }
}

#We are exporting column values for DisplayName, PrimarySmtpAddress, and Membership (list of all distribution group members by email address)
$alldata.GetEnumerator() | Select-Object -Property DisplayName,PrimarySmtpAddress,Membership | Export-Csv -NoTypeInformation -Path "$exportfilename"
Write-Host -ForegroundColor Green "Data exported to $exportfilename."


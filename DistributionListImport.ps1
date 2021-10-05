#!!!Important!!! Make sure you already have all the contacts imported to Exchange Online contacts before you start the import
#This script will not create missing contacts for you, but you are free to modify it so it does if you need it to
#For best results use my other PS script to export data that you are importing in this script
#Csv needs to have a DisplayName, PrimarySmtpAddress, and Membership field

$pathtoimports = Read-Host "Input full path to csv file with distribution group information to import"
$ImportedDLs = Import-Csv $pathtoimports

foreach ($DLrow in $ImportedDLs) {
    New-DistributionGroup -Name $DLrow.DisplayName -DisplayName $DLrow.DisplayName -PrimarySmtpAddress $DLrow.PrimarySmtpAddress -Type "Distribution"
    $splitmembers = -split $DLrow.Membership
    foreach ($member in $splitmembers) {
        Add-DistributionGroupMember -Identity $DLrow.DisplayName -Member $member
        
    }
}
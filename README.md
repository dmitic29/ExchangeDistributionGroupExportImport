# ExchangeDistributionGroupExportImport
Powershell scripts for exporting and importing Exchange Online (Office 365) distribution groups with memberships.

You need to have the Exchange Online Powershell module installed. You can use the following command to do so:
Install-Module -Name ExchangeOnlineManagement

The Export script will spit out a CSV with columns **DisplayName**, **PrimarySmtpAddress**, and **Membership**
**DisplayName** - this is self explanatory
**PrimarySmtpAddress** - the email address associated with the distribution group
**Membership** - email addresses of members of given distribution group separated by spaces

Script requires you to provice Exchange admin or Global admin credentials.

For best results with the Import script, use my Export script to export the desired data beforehand.

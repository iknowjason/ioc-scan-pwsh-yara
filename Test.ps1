<# 
  Built for Company ~ Test script just to get subdomain.company.com domain systems
  Query all Active Directory computers, and return DNSHostnames
  Used as input for investigations
  Author:  Jason Ostrom
#>

Import-Module ActiveDirectory

Get-ADOrganizationalUnit -SearchBase 'DC=subdomain,DC=company,DC=com' -Filter * -Server AD1.subdomain.company.com -SearchScope Subtree | Select Name, DistinguishedName | foreach {

	$OU = $_.Name

	Get-ADComputer -Searchbase $_.DistinguishedName -Filter * -Server AD1.subdomain.company.com | Select -ExpandProperty DNSHostname

}

Start-Transcript -Path "C:\Logs\SSLCert.txt"

#Import ENV vars created
$importedsf = Import-Clixml "C:\Logs\sf-vars.xml"

$SSLCert = $importedsf.SSLCert
$CertPass = $importedsf.CertPass

# Import StoreFront modules. Required for versions of PowerShell earlier than 3.0 that do not support autoloading
Import-Module Citrix.StoreFront

#Add SSL Cert
$CertPath = "C:\Windows\Temp\$SSLCert"
$webServercert = Import-PfxCertificate -FilePath $CertPath -Password (ConvertTo-SecureString -String $CertPass -AsPlainText -Force) -CertStoreLocation Cert:\LocalMachine\My -Exportable
New-WebBinding -Name "Default Web Site" -IPAddress "*" -Port 443 -Protocol https
$bind = Get-WebBinding -Protocol https
$bind.AddSslCertificate($webServerCert.GetCertHashString(), "my")

Stop-Transcript
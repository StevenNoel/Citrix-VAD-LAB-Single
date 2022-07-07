  $vcenterurl = $env:cvad_vcenterurl
  $vcenteruser = $env:cvad_vcenteruser
  $vcenterpass = $env:cvad_vcenterpass
 
   
    asnp Citrix*
   
    write-host "Create hosting connection to $vCenterURL"
   
    $computername = (Get-WmiObject win32_computersystem).DNSHostName + "." + (Get-WmiObject win32_computersystem).Domain
    $URL = "$computername" + ":80"
    $path = $env:TEMP
    $Uri = $vCenterURL
    $Outputfile = "$path" + "\vmware.cer"
    $Testcertpath = $Outputfile | Test-Path
    if ($Testcertpath -eq "False"){
    write-host "Certificate already exsist will delete it"
    Remove-Item -Path $Outputfile -Force
    }
    $request = [System.Net.WebRequest]::Create($Uri)
    $Provider = New-Object Microsoft.CSharp.CSharpCodeProvider
    $Compiler = $Provider.CreateCompiler()
    $Params = New-Object System.CodeDom.Compiler.CompilerParameters
    $Params.GenerateExecutable = $False
    $Params.GenerateInMemory = $True
    $Params.IncludeDebugInformation = $False
    $Params.ReferencedAssemblies.Add("System.DLL") > $null
    $TASource = @'
      namespace Local.ToolkitExtensions.Net.CertificatePolicy {
        public class TrustAll : System.Net.ICertificatePolicy {
          public TrustAll() {
          }
          public bool CheckValidationResult(System.Net.ServicePoint sp,
            System.Security.Cryptography.X509Certificates.X509Certificate cert,
            System.Net.WebRequest req, int problem) {
            return true;
          }
        }
      }
'@
    $TAResults = $Provider.CompileAssemblyFromSource($Params, $TASource)
    $TAAssembly = $TAResults.CompiledAssembly
    $TrustAll = $TAAssembly.CreateInstance("Local.ToolkitExtensions.Net.CertificatePolicy.TrustAll")
    [System.Net.ServicePointManager]::CertificatePolicy = $TrustAll
    $servicePoint = $request.ServicePoint
    $response = $request.GetResponse()
    $certificate = $servicePoint.Certificate
    $certBytes = $certificate.Export(
    [System.Security.Cryptography.X509Certificates.X509ContentType]::Cert)
    [System.IO.File]::WriteAllBytes($OutputFile, $certBytes)
   
    $certPrint = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2
    $certPrint.Import("$path\vmware.cer")
    $Connectionuid = New-Item -ConnectionType "VCenter" -CustomProperties "" -HypervisorAddress "$vcenterurl/sdk" -Path @("XDHyp:\Connections\VMware") -Scope @() -Password $vcenterpass -UserName $vcenteruser -SSLThumbprint $certPrint.Thumbprint -persist | select HypervisorConnectionUid
    New-BrokerHypervisorConnection -AdminAddress "$URL" -HypHypervisorConnectionUid $connectionuid.HypervisorConnectionUid

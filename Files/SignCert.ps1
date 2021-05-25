# Kodsignering

# New-SelfSignedCertificate -CertStoreLocation cert:\currentuser\my -Subject "CN=Local Code Signing" -KeyAlgorithm RSA -KeyLength 2048 -Provider "Microsoft Enhanced RSA and AES Cryptographic Provider" -KeyExportPolicy Exportable -KeyUsage DigitalSignature -Type CodeSigningCert

# mmc
# certmgr /s my

# Expand the Personal folder, select Certificates. Right click the new Local Code Signing certificate, and Copy.

# Paste into Trusted Root Certification Authorities and into Trusted Publishers stores.


# Sign your Powershell script with the new cert
# From a Powershell prompt, run these two commands:

# $cert = @(Get-ChildItem cert:\CurrentUser\My -CodeSigning)[0] 
# Set-AuthenticodeSignature .\your-script.ps1 $cert

# vscode://vscode.github-authentication/did-authenticate?windowid=1&code=7a20156d79aaef6e205b&state=d38fbe65-dd3c-4e25-a7a8-cee27301cfbe

$cert = @(Get-ChildItem cert:\CurrentUser\My -CodeSigning)[0] 

Set-AuthenticodeSignature .\SignedPS.ps1 $cert

Write-Host $profile

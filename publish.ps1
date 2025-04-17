$ModulePath = "$PSScriptRoot\ppmnottheunit"
Publish-Module -Path $ModulePath -NuGetApiKey $env:APIKEY

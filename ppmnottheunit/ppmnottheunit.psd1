@{
  RootModule = 'ppmnottheunit.psm1'
  ModuleVersion = '2.0.0'
  GUID = '0207a754-f0f0-4fe9-9eb1-97ccd32a8c46'
  Author = 'nonepork'
  CompanyName = ''
  Copyright = '(c) nonepork. All rights reserved.'
  Description = 'A very minimalistic PowerShell module for managing projects with fzf integration.'
  RequiredModules = @('PSFzf')
  FunctionsToExport = @(
    'ppm'
  )
}


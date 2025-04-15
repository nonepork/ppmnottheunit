@{
  RootModule = 'ppmnottheunit.psm1'
  ModuleVersion = '1.0.0'
  GUID = '0207a754-f0f0-4fe9-9eb1-97ccd32a8c46'
  Author = 'nonepork'
  CompanyName = ''
  Copyright = '(c) nonepork. All rights reserved.'
  Description = 'Project management module for PowerShell, providing project listing, creation, renaming, and deletion with safety checks.'
  RequiredModules = @('PSFzf')
  FunctionsToExport = @(
    'ppm'
  )
}


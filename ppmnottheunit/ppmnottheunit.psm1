function ppm {
  param(
    [int]$Index = -1,
    [string]$Go
  )

  $config = Get-PPMConfig
  if ($Index -lt 0) {
    $config | ConvertTo-Json -Depth 3 | Write-Host
    return
  }

  $rootPath = $config.roots[$Index]

  if ($rootPath -eq $null) {
    Write-Warning "Please enter a valid index."
    return
  }

  if (-not (Test-Path $rootPath)) {
    Write-Warning "Project path does not exist or bad: $rootPath"
    return
  }

  if ($Go -eq "go") {
    Set-Location $rootPath
    return
  }
  elseif ([string]::IsNullOrEmpty($Go)) {
    $project = Get-ChildItem $rootPath -Directory | Invoke-Fzf
    if ($project) {
      Set-Location $project.FullName
    }
    return
  }
  else {
    Write-Warning "Invalid command. Use 'go' or leave empty."
    return
  }
}

function Get-PPMConfig {
  $configPath = Join-Path $HOME ".ppmnottheunit.json"

  if (-not (Test-Path $configPath)) {
    Write-Warning "Configuration file not found at $configPath, please configure before using."
    return
  }

  Get-Content $configPath | ConvertFrom-Json
}

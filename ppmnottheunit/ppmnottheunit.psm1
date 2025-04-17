function ppm()
{
  $baseDir = (Get-PPMConfig).BaseDir

  function RenderInterface()
  {
    Clear-Host
    Write-Host "Projects" -ForegroundColor Cyan
    Write-Host "==================" -ForegroundColor Cyan
    Write-Host ""

    $projects = Get-ChildItem $baseDir -Attributes Directory
    foreach ($project in $projects)
    {
      $name = Split-Path $project -Leaf
      $lastModified = (Get-Item $project).LastWriteTime.ToString("yyyy-MM-dd HH:mm")
      Write-Host "$name" -ForegroundColor Green -NoNewline
      Write-Host " - Last modified: $lastModified"
    }

    Write-Host "`n==================" -ForegroundColor Cyan
    Write-Host "[s] Select [c] Create [r] Rename [d] Delete [p] Path [q] Exit" -ForegroundColor Yellow
  }

  function HandleKeyPress()
  {
    $key = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

    switch ($key.Character)
    {
      'q'
      { return $false
      }
      's'
      { SelectProject;
      }
      'c'
      { CreateProject; return $true
      }
      'r'
      { RenameProject; return $true
      }
      'd'
      { DeleteProject; return $true
      }
      'p'
      { Set-PPMConfig; return $true
      }
      default
      { return $true 
      }
    }
  }

  $continue = $true
  while ($continue)
  {
    RenderInterface
    $continue = HandleKeyPress
  }

  Clear-Host
}

function Get-PPMConfig
{
  $configPath = Join-Path $HOME ".ppmnottheunit.json"

  if (-not (Test-Path $configPath))
  {
    $baseDir = Read-Host "Please enter the base directory path"

    while (-not (Test-Path $baseDir))
    {
      Write-Warning "Directory does not exist. Please try again."
      $baseDir = Read-Host "Please enter the base directory path"
    }

    @{
      BaseDir = $baseDir
    } | ConvertTo-Json | Out-File -FilePath $configPath -Encoding utf8

    return @{
      BaseDir = $baseDir
    }
  }

  Get-Content $configPath | ConvertFrom-Json
}


function Set-PPMConfig
{
  Write-Host "(type nothing to cancel)"
  $baseDir = Read-Host "Please enter the base directory path"

  if ([string]::IsNullOrWhiteSpace($baseDir))
  {
    Write-Host "No input provided. Configuration unchanged."
    return
  }

  while (-not (Test-Path $baseDir))
  {
    Write-Warning "Directory does not exist. Please try again."
    $baseDir = Read-Host "Please enter the base directory path"

    if ([string]::IsNullOrWhiteSpace($baseDir))
    {
      Write-Host "No input provided. Configuration unchanged."
      return
    }
  }

  @{
    BaseDir = $baseDir
  } | ConvertTo-Json | Out-File -FilePath $configPath -Encoding utf8
}


function SelectProject()
{
  $baseDir = (Get-PPMConfig).BaseDir
  $selectedProject = Get-ChildItem $baseDir -Attributes Directory | Invoke-Fzf
  if ($selectedProject)
  {
    Set-Location $selectedProject
    return $false;
  }
  return $true;
}

function CreateProject()
{
  $baseDir = (Get-PPMConfig).BaseDir
  Clear-Host
  Write-Host "Create new project (type nothing to cancel)" -ForegroundColor Cyan
  Write-Host "==================" -ForegroundColor Cyan
  $newFolderName = Read-Host "`nEnter new project name"

  if ($newFolderName)
  {
    $newPath = Join-Path -Path $baseDir -ChildPath $newFolderName
    if (!(Test-Path -Path $newPath))
    {
      New-Item -Path $newPath -ItemType Directory | Out-Null
      Write-Host "`nCreated project: $newFolderName" -ForegroundColor Green
    } else
    {
      Write-Host "`nProject already exists: $newFolderName" -ForegroundColor Yellow
    }
    Start-Sleep -Seconds 1
  }
}

function RenameProject()
{
  $baseDir = (Get-PPMConfig).BaseDir
  $selectedProject = Get-ChildItem $baseDir -Attributes Directory | Invoke-Fzf
  if ($selectedProject)
  {
    $newName = Read-Host "Enter new name for $selectedProject"
    Rename-Item -Path $selectedProject -NewName $newName
    Write-Host "Renamed project to: $newName" -ForegroundColor Green
    Start-Sleep -Seconds 1
  }
}

function DeleteProject()
{
  $baseDir = (Get-PPMConfig).BaseDir
  $selectedProject = Get-ChildItem $baseDir -Attributes Directory | Invoke-Fzf
  if ($selectedProject)
  {
    $projectName = Split-Path $selectedProject -Leaf
    $childFile = Join-Path $selectedProject -ChildPath "*"
    $containsFile = Test-Path -Path $childFile

    if (-Not ($containsFile))
    {
      $confirmation = Read-Host "Are you sure you want to delete empty project $projectName? (y/n)"
      if ($confirmation -eq 'y')
      {
        Remove-Item -Path $selectedProject -Force
        Write-Host "Deleted empty project: $projectName" -ForegroundColor Red
      } else
      {
        Write-Host "Deletion cancelled" -ForegroundColor Yellow
      }
    } else
    {
      Write-Host "Project $projectName contains files." -ForegroundColor Yellow
      $forceDelete = Read-Host "Do you want to force delete this non-empty project? (y/n)"
      if ($forceDelete -eq 'y')
      {
        $confirmForce = Read-Host "Please type the project's name ($projectName) to confirm action: "
        if ($confirmForce -eq $projectName)
        {
          Remove-Item -Path $selectedProject -Recurse -Force
          Write-Host "Force deleted project: $projectName" -ForegroundColor Red
        } else
        {
          Write-Host "Force deletion cancelled" -ForegroundColor Yellow
        }
      } else
      {
        Write-Host "Deletion cancelled" -ForegroundColor Yellow
      }
    }
    Start-Sleep -Seconds 1
  }
}

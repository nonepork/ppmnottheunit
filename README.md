<div align="center">

# ppmnottheunit
> A simple tui project manager in powershell

[![asciicast](https://asciinema.org/a/D5cUE1GpqjvEQ4s12AEeWqqQz.svg)](https://asciinema.org/a/D5cUE1GpqjvEQ4s12AEeWqqQz)

</div>

## Features
- Provides interactive selection of projects (via PSFzf)
- Creates new project directories
- Renames existing projects
- Deletes projects with safety checks for non-empty directories
- Keyboard shortcuts for all operations

## Prerequisites
- PowerShell 7+ recommended
- **PSFzf module** installed (`Install-Module PSFzf`)

## Installation
1. Ensure dependencies are installed:
   ```powershell
   Install-Module -Name PSFzf -Scope CurrentUser -Force
   ```
2. **Install via PowerShell Gallery**:
   ```powershell
   Install-Module -Name ppmnottheunit -Scope CurrentUser
   ```

## Usage
Run the main interface with:
```powershell
ppm
```
And enter the folder path that you would like to use as projects' root folder.

## Keyboard Shortcuts
- `s` - Select project (changes directory)
- `c` - Create new project
- `r` - Rename project
- `d` - Delete project (with confirmation steps)
- `q` - Quit interface

## Configurations
To change the base directory, edit .ppmnottheunit.json in your home directory.

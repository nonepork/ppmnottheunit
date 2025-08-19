<div align="center">

# ppmnottheunit

> A simple tui project manager in powershell

# TODO: record something here

</div>

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

Run the command below to fuzzy find projects in a root

```powershell
ppm 0
```

Run the command below to jump into that directory

```powershell
ppm 0 go
```

## Configurations

Define one or more project roots folder like below:

```json
{
  "roots": ["C:\\something\\here", "F:\\another folder\\here"]
}
```

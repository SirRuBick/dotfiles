# ####################
# Powershell Profile
# by: Alex Shan
# ####################

# General Settings
## UTF8
try {
    [Console]::InputEncoding  = [System.Text.Encoding]::UTF8
    [Console]::OutputEncoding = [System.Text.Encoding]::UTF8
    $OutputEncoding = [System.Text.UTF8Encoding]::new($false)
    chcp 65001 > $null
} catch {}

Clear-Host

# Alias
Set-Alias tt tree
Set-Alias ls Get-ChildItem
Set-Alias ll Get-ChildItem -Force
Set-Alias grep Select-String
Set-Alias cat Get-Content
Set-Alias clear Clear-Host
Set-Alias rm Remove-Item
Set-Alias touch New-Item
Set-Alias reboot Restart-Computer
Set-Alias vim nvim
Set-Alias v nvim
Set-Alias ff fastfetch
Set-Alias lg lazygit

# Git Aliases (mirrors common.sh)
function gs { git status }
function ga { git add $args }
function gp { git push $args }
function gpo { git push origin $args }
function gl { git log --graph --oneline --decorate }
function gc { git commit -m $args }
function gco { git checkout $args }
function gb { git branch $args }
function gd { git diff $args }

# System Helpers
function clip { $input | clip.exe }
function open { explorer.exe $args }


# Evnrionment Variables
$env:SHELL = "pwsh"

# Prompt
## FastFetch
if (Get-Command fastfetch -ErrorAction SilentlyContinue) {
    fastfetch -c "$env:USERPROFILE/.config/fastfetch/config.jsonc"
} else {
    Write-Host "FastFetch not found. Install it with: winget install fastfetch" -ForegroundColor Yellow
}
## Starship
if (Get-Command starship -ErrorAction SilentlyContinue) {
    Invoke-Expression (&starship init powershell)
} else {
    Write-Host "Starship not found. Install it with: winget install starship" -ForegroundColor Yellow
}
## Zoxide
# winget install ajeetdsouza.zoxide
if (Get-Command zoxide -ErrorAction SilentlyContinue) {
Invoke-Expression (& { (zoxide init powershell | Out-String) })
} else {
    Write-Host "Zoxide not found. Install it with: winget install ajeetdsouza.zoxide" -ForegroundColor Yellow
}
## FZF
# winget install fzf


# Modules
# Install-Module -Name Terminal-Icons -Repository PSGallery -Force
Import-Module Terminal-Icons
# Install-Module -Name z -Force
# Import-Module 
# Install-Module -Name PSReadLine -Scope CurrentUser -Force
# PSReadLine
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineKeyHandler -Key Tab -Function Complete
# Unbind Alt+1-9 from DigitArgument (conflicts with zellij)
1..9 | ForEach-Object { Remove-PSReadLineKeyHandler -Chord "Alt+$_" -ErrorAction SilentlyContinue }


# Functions
## whereis
function whereis ($command) {
  Get-Command -Name $command -ErrorAction SilentlyContinue |
  Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}
  ## Quick open recycle bin
function openRecycleBin(){
  start shell:RecycleBinFolder
}

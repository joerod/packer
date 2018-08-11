Set-ExecutionPolicy Bypass -Scope Process -Force
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

[Environment]::SetEnvironmentVariable("PATH",([Environment]::GetEnvironmentVariable("PATH","Machine"))+";C:\ProgramData\chocolatey\bin\choco.exe","Machine")
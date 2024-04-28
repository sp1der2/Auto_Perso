#1) Installation de l'OS
#2) Activation VPN
#3) Création Partion E:\
#4) Lancement du script
#5) Configuration des comptes
#6) Récupération data cloud
#7) Extension KeePass à installer dans Brave

#Installer winget 
if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {

    Set-Location "C:\Users\$env:USERNAME\Downloads"
    Write-Information "Downloading WinGet and its dependencies..."
    Invoke-WebRequest -Uri https://aka.ms/getwinget -OutFile Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle
    Invoke-WebRequest -Uri https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx -OutFile Microsoft.VCLibs.x64.14.00.Desktop.appx
    Invoke-WebRequest -Uri https://github.com/microsoft/microsoft-ui-xaml/releases/download/v2.8.6/Microsoft.UI.Xaml.2.8.x64.appx -OutFile Microsoft.UI.Xaml.2.8.x64.appx
    Add-AppxPackage Microsoft.VCLibs.x64.14.00.Desktop.appx
    Add-AppxPackage Microsoft.UI.Xaml.2.8.x64.appx
    Add-AppxPackage Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle
}

#Liste de dossiers à créer
$folders = @(
    "E:\VMWare Workstation Pro 17",
    "E:\Wireshark",
    "E:\ownCloud",
    "E:\VS Code",
    "E:\WinSCP"
)

winget update --accept-source-agreements
winget upgrade -r

# Pour chaque élément de la liste
foreach ($folder in $folders) {
    # Vérifie si le dossier existe
    if (-not (Test-Path -Path $folder -PathType Container)) {
        # Crée le dossier s'il n'existe pas
        New-Item -Path $folder -ItemType Directory
        Write-Host "Le dossier $folder a été créé."
    } else {
        Write-Host "Le dossier $folder existe déjà."
    }
}

#liste des application par nom
winget install --id=WireGuard.WireGuard -h -e 
winget install --id=WiresharkFoundation.Wireshark -h -e --location 'E:\Wireshark'
winget install --id=Brave.Brave -h -e  
winget install --id=Discord.Discord -h -e  
winget install --id=Microsoft.Teams -h -e  
winget install --id=ownCloud.ownCloudDesktop -h -e --location 'E:\ownCloud'
winget install --id=PlayStation.PSRemotePlay -h -e  
winget install --id=KeePassXCTeam.KeePassXC -h -e  
winget install --id=VMware.WorkstationPro -h -e --location 'E:\VMWare Workstation Pro 17' --accept-package-agreements
winget install --id=Microsoft.VisualStudioCode -h -e --location 'E:\VS Code'
winget install --id=WinSCP.WinSCP -h -e --location 'E:\WinSCP'

#Install extensions vscode

Set-Location 'E:\VS Code\bin'
.\code --install-extension ms-vscode.powershell
.\code --install-extension ms-azuretools.vscode-docker
.\code --install-extension github.copilot

#Suppression packages winget
Set-Location "C:\Users\$env:USERNAME\Downloads"
$packages_to_delete = @(
    "Microsoft.VCLibs.x64.14.00.Desktop.appx",
    "Microsoft.UI.Xaml.2.8.x64.appx",
    "Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"
)

foreach ($package in $packages_to_delete) {
    Remove-Item -Path $package
}

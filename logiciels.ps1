#1) Installation de l'OS
#2) Activation VPN
#3) Création Partion E:\
#4) Lancement du script
#5) Configuration des comptes

#Extensions VS Code à installer

#Installer winget 
if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {

    Write-Information "Downloading WinGet and its dependencies..."
    Invoke-WebRequest -Uri https://aka.ms/getwinget -OutFile Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle
    Invoke-WebRequest -Uri https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx -OutFile Microsoft.VCLibs.x64.14.00.Desktop.appx
    Invoke-WebRequest -Uri https://github.com/microsoft/microsoft-ui-xaml/releases/download/v2.8.6/Microsoft.UI.Xaml.2.8.x64.appx -OutFile Microsoft.UI.Xaml.2.8.x64.appx
    Add-AppxPackage Microsoft.VCLibs.x64.14.00.Desktop.appx
    Add-AppxPackage Microsoft.UI.Xaml.2.8.x64.appx
    Add-AppxPackage Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle
}

echo "Mise à jour des dépôts"
winget source update

#spécifier source "winget" à utiliser
winget source set "winget"

#Liste de dossiers à créer
$folders = @(
    "E:\VMWare Workstation Pro 17",
    "E:\Wireshark",
    "E:\ownCloud",
    "E:\VS Code",
    "E:\WinSCP"
)

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


#liste des application par "id"
$apps = @(
    "Wireguard.Wireguard",
    "WiresharkFoundation.Wireshark -e --location 'E:\Wireshark'",
    "Brave.Brave", 
    "Discord.Discord",
    "Microsoft.Teams",
    "ownCloud.ownCloudDesktop -e --location 'E:\ownCloud'",
    "PlayStation.PSRemotePlay",
    "KeePassXCTeam.KeePassXC",
    "VMware.WorkstationPro -e --location 'E:\VMWare Workstation Pro 17'",
    "Microsoft.VisualStudioCode -e --location 'E:\VS Code'",
    "WinSCP.WinSCP -e --location 'E:\WinSCP'"
)

foreach ($app in $apps) {
    #Installation des applications
    winget install --id $app
}

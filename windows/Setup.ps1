Write-Output 'starting windows setup'

if (-Not(Get-Command choco.exe -ErrorAction SilentlyContinue))
{
    Write-Output 'installing choco...'
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}
else
{
    Write-Output 'skipping choco install. already exists.'
}

$ChocoPackages = 'googlechrome', 'git', 'vscode', 'conemu', '7zip.install', 'jdk8', 'pasteboard', 'python2', 'vcredist2012', 'vcredist2013', 'firacode', '1password', 'slack', 'dropbox', 'visualstudio2017enterprise'
ForEach ($PackageName in $ChocoPackages)
{
    Write-Output "installing choco package $PackageName"
    choco install $PackageName -y
}

Import-Module "$env:ChocolateyInstall\helpers\chocolateyInstaller.psm1"
Update-SessionEnvironment


if (-Not(Get-Command scoop -ErrorAction SilentlyContinue))
{
    Write-Output 'installing scoop...'
    iex (new-object net.webclient).downloadstring('https://get.scoop.sh')
}
else
{
    Write-Output 'skipping scoop install. already exists.'
}

$ScoopPackages = 'dig', 'jq', 'sudo'
ForEach ($PackageName in $ScoopPackages)
{
    Write-Output "installing scoop package $PackageName"
    scoop install $PackageName
}

Install-PackageProvider -Name NuGet -Force
Install-Module posh-git -Scope CurrentUser -Force
Install-Module oh-my-posh -Scope CurrentUser -Force

if (-Not( Test-Path "C:\Windows\fonts\Hack-*"))
{
    Write-Output 'installing powerline Hack font...'
    git clone https://github.com/powerline/fonts.git --depth=1
    cd fonts
    ./install.ps1 Hack-*
    cd ..
    Remove-Item fonts -Force -Recurse
}

Write-Output 'copying configs...'
cp config/ConEmu.xml "$ENV:APPDATA\ConEmu.xml"
cp config/PSProfile $PROFILE
cp config/VSCode.json "$ENV:APPDATA\Code\User\settings.json"


Write-Output 'done'
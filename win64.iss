#define VERSION "5.0.0"

[Setup]
OutputBaseFilename=FFmpeg_{#VERSION}_for_Audacity_on_Windows_x86_64
SolidCompression=yes
ArchitecturesInstallIn64BitMode=x64

AppName=FFmpeg for Audacity
AppVerName=FFmpeg {#VERSION} for Audacity - x86_64
AppPublisherURL=https://audacityteam.org
AppSupportURL=https://audacityteam.org
AppUpdatesURL=https://audacityteam.org
ChangesAssociations=no
DefaultDirName={commonpf}\FFmpeg For Audacity
AppendDefaultDirName=no
DirExistsWarning=no
DisableProgramGroupPage=yes
LicenseFile=build\win64\bin\LICENSE.md
MinVersion=0,6.0
UninstallFilesDir="{app}"

[Registry]
Root: HKLM; Subkey: "Software\FFmpeg for Audacity"; ValueType: string; ValueName: "InstallPath"; ValueData: "{app}"; Flags: uninsdeletekeyifempty uninsdeletevalue;

[InstallDelete]
Type: files; Name: "{app}\*"

[Files]
Source: "build\win64\bin\*" ; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

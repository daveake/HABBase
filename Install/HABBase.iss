[Setup]
AppName=HAB Base
AppVersion=1.5.0
WizardStyle=modern
DefaultDirName=c:\HAB\Base
DefaultGroupName=HAB
UninstallDisplayIcon={app}\HABBase.exe
Compression=lzma2
SolidCompression=yes
OutputBaseFilename=HABBaseInstaller

[Files]
Source: "HABBase.exe"; DestDir: "{app}"; Flags: replacesameversion restartreplace
Source: "settings.json"; DestDir: "{app}"; Flags: onlyifdoesntexist
Source: "sources.json"; DestDir: "{app}"; Flags: onlyifdoesntexist
Source: "whitelist.json"; DestDir: "{app}"; Flags: onlyifdoesntexist
Source: "Images\*"; DestDir: "{app}\Images"; Flags: onlyifdoesntexist
Source: "C:\Users\dave\AppData\Local\tmssoftware\registered\TMS VCL UI Pack\Edge Support\x86\WebView2Loader_x86.dll"; DestDir: "{sys}"; Flags: 32bit


[Icons]
Name: "{group}\HAB Base"; Filename: "{app}\HABBase.exe"
Name: "{commondesktop}\HAB Base"; Filename: "{app}\HABBase.exe"

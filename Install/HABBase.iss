[Setup]
AppName=HAB Base
AppVersion=1.7.6
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
Source: "OpenSSL\libeay32.dll"; DestDir: "{app}"; Flags: 32bit
Source: "OpenSSL\ssleay32.dll"; DestDir: "{app}"; Flags: 32bit
Source: "EdgeSupport\WebView2Loader_x86.dll"; DestDir: "{app}"; Flags: 32bit
Source: "EdgeSupport\MicrosoftEdgeWebview2Setup.exe"; DestDir: "{app}"; Flags: 32bit


[Icons]
Name: "{group}\HAB Base"; Filename: "{app}\HABBase.exe"
Name: "{commondesktop}\HAB Base"; Filename: "{app}\HABBase.exe"


[Run]
Filename: {app}\MicrosoftEdgeWebview2Setup.exe; Parameters: "/silent /install"; WorkingDir: {app}; Flags: skipifsilent;
; TODO: https://blogs.msdn.microsoft.com/davidrickard/2015/07/17/installing-net-framework-4-5-automatically-with-inno-setup/

#define MyAppName "Piecy"
#define MyAppPublisher "Jens Bråkenhielm"
#define MyAppURL "afolse"
#define MyAppExeName "Piecy.exe"

#include "AssemblyInfo.txt"

[Setup]
AppId={{F95C559A-6DA8-46A3-9353-1128B72D9B2C}
AppName={#MyAppName}
AppVersion={#ASSEMBLY_VERSION_SHORT} (build {#ASSEMBLY_VERSION_BUILD})
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={pf}\{#MyAppName}
DefaultGroupName={#MyAppName}
AllowNoIcons=yes
OutputDir=.
OutputBaseFilename={#MyAppName}Setup
;SetupIconFile=..\Piecy\PiecyLogo.ico
SolidCompression=yes
InternalCompressLevel=ultra64

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
Name: "quicklaunchicon"; Description: "{cm:CreateQuickLaunchIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked; OnlyBelowVersion: 0,6.1

[Files]
Source: "..\Piecy\bin\Release\Piecy.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\Piecy\bin\Release\*.txt"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{commondesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: quicklaunchicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent


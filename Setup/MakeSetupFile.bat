@echo off

rem ===============================================================================================
rem Constants

rem Paths to executables used
set MSBUILD="c:\Program Files (x86)\MSBuild\14.0\Bin\MSBuild.exe"
set GETASSEMBLYINFO=GetAssemblyInfo
set INNOCOMPILE="c:\Program Files (x86)\Inno Setup 5\compil32.exe"
set ZIP="C:\Program Files\7-Zip\7z.exe"


rem Files used
set ASSEMBLYINFO=AssemblyInfo.txt
set SETUPTARGET=PiecySetup
set ASSEMBLYEXE=..\Piecy\bin\Release\Piecy.exe

rem ===============================================================================================
rem Step 1: Build the code in release mode

echo *** BUILDING CODE...

%MSBUILD% /v:Quiet /t:Rebuild /p:Configuration=Release ..\Piecy.sln > nul

rem ===============================================================================================
rem Step 2: Produce setup file

echo *** BUILDING SETUP...

%GETASSEMBLYINFO% %ASSEMBLYEXE% %ASSEMBLYINFO%
%INNOCOMPILE% /cc PiecySetup.iss

rem ===============================================================================================
rem Step 3: Compress setup and set version in zip file name

echo *** ZIPPING...

rem First find line with string "VERSION_SHORT" in assembly info file
rem Then get third (3) token separated by default separator ' ' which is version number
for /f "tokens=3" %%a in ('findstr /C:"VERSION_SHORT" %ASSEMBLYINFO%') do set ver=%%a

rem Remove quotes by replacing " with nothing
set version=%ver:"=%

rem Compress with version number in name: add archive, answer yes, maximum compression, stderr to nul
SET SETUPZIP=Releases\%SETUPTARGET%-%version%.zip
%ZIP% a -y -mx9 %SETUPZIP% %SETUPTARGET%.exe > nul

rem ===============================================================================================
rem Step 4: Done

rem clean setup exe
del /Q %SETUPTARGET%.exe

echo *** DONE...
echo Output: %SETUPZIP%


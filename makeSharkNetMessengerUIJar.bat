@echo off
rem Builds SharkNetMessengerCLI.jar from the sources in src\.
rem Run this script from the project root folder (where this file lives).
cd /d "%~dp0"

rem 1. compile sources into out\production\SharkMessenger
if exist out\production\SharkMessenger rmdir /s /q out\production\SharkMessenger
mkdir out\production\SharkMessenger
dir /s /b src\*.java > sources.txt
javac --release 21 -nowarn -encoding UTF-8 -cp "libs/*" -d out\production\SharkMessenger @sources.txt
if errorlevel 1 (
    echo compilation failed
    del sources.txt
    exit /b 1
)
del sources.txt

rem 2. pack compiled classes and libraries into one runnable jar
if exist tempLibBuildFolder rmdir /s /q tempLibBuildFolder
mkdir tempLibBuildFolder
cd tempLibBuildFolder
jar -x -f ..\libs\ASAPJava.jar
jar -x -f ..\libs\ASAPHub.jar
jar -x -f ..\libs\SharkPeer.jar
jar -x -f ..\libs\SharkPKI.jar
if exist META-INF rmdir /s /q META-INF
mkdir META-INF
echo Manifest-Version: 1.0> META-INF\MANIFEST.MF
echo Main-Class: net.sharksystem.ui.messenger.cli.ProductionUI>> META-INF\MANIFEST.MF
echo Created-By: Shared Knowledge>> META-INF\MANIFEST.MF
xcopy /S /Q /Y ..\out\production\SharkMessenger\* . > nul
jar cmf META-INF\MANIFEST.MF SharkNetMessengerCLI.jar *
cd ..
move /Y tempLibBuildFolder\SharkNetMessengerCLI.jar . > nul
rmdir /s /q tempLibBuildFolder
if not exist playground mkdir playground
if not exist __bugfixing mkdir __bugfixing
copy /Y SharkNetMessengerCLI.jar playground > nul
copy /Y SharkNetMessengerCLI.jar __bugfixing > nul
echo done: SharkNetMessengerCLI.jar created. Run it with: java -jar SharkNetMessengerCLI.jar ^<peerName^>

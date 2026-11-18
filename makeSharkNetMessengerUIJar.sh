#!/bin/sh
# Builds SharkNetMessengerCLI.jar from the sources in src/.
# Run this script from the project root folder (where this file lives).
set -e
cd "$(dirname "$0")"

# 1. compile sources into out/production/SharkMessenger
rm -rf out/production/SharkMessenger
mkdir -p out/production/SharkMessenger
find src -name '*.java' > sources.txt
javac --release 21 -nowarn -encoding UTF-8 -cp "libs/*" -d out/production/SharkMessenger @sources.txt
rm sources.txt

# 2. pack compiled classes and libraries into one runnable jar
rm -rf tempLibBuildFolder
mkdir tempLibBuildFolder
cd tempLibBuildFolder
jar -x -f ../libs/ASAPJava.jar
jar -x -f ../libs/ASAPHub.jar
jar -x -f ../libs/SharkPeer.jar
jar -x -f ../libs/SharkPKI.jar
rm -rf META-INF/
mkdir META-INF/
echo Manifest-Version: 1.0 > META-INF/MANIFEST.MF
echo Main-Class: net.sharksystem.ui.messenger.cli.ProductionUI >> META-INF/MANIFEST.MF
echo Created-By: Shared Knowledge >> META-INF/MANIFEST.MF
cp -r ../out/production/SharkMessenger/* .
jar cmf META-INF/MANIFEST.MF SharkNetMessengerCLI.jar *
cd ..
mv tempLibBuildFolder/SharkNetMessengerCLI.jar .
rm -r tempLibBuildFolder/
mkdir -p playground
mkdir -p __bugfixing
cp SharkNetMessengerCLI.jar playground/
cp SharkNetMessengerCLI.jar __bugfixing/
echo "done: SharkNetMessengerCLI.jar created. Run it with: java -jar SharkNetMessengerCLI.jar <peerName>"

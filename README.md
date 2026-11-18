# SharkMessenger

## SharkMessenger command-line interface

### Build
You need a JDK (Java 21 or newer). Run the build script in the project root folder:

- Windows: `makeSharkNetMessengerUIJar.bat`
- Linux / macOS: `./makeSharkNetMessengerUIJar.sh`

The script compiles all sources in `src` and produces `SharkNetMessengerCLI.jar`
in the project root (copies are also placed in `playground` and `__bugfixing`).

### Run
```
java -jar SharkNetMessengerCLI.jar <peerName>
```
Type `help` to see all commands. Peer data is stored in the current folder,
so start different peers in different folders. Have fun.

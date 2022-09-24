# Flutter implementation of retkipaikka-app

### Local development

1. Clone the git repository ```git clone https://github.com/partio-scout/retkipaikka-frontend-flutter.git```

2. Install Flutter and Visual Studio Code and recommended extensions for VS Code
  * Flutter:   https://docs.flutter.dev/get-started/install/windows
  * Visual Studio Code: **https://code.visualstudio.com/**
    * Dart extension
    * Flutter extension
3. Open the cloned repository in VS Code
4. Run ```flutter pub get``` to install needed dependencies
5. Press ctrl+shift+p in VS Code to open the command palette and type "flutter: select device" and select Chrome
6. You should be able to run the project now by opening main.dart and pressing the run button in top right corner
7. Use develop-branch if you need to make changes
8. On default the app will use heroku backend, you can change the baseurl in constants.dart


### Building the project for github pages

1. Run command in project root
```shell
flutter build web --web-renderer html --base-href /retkipaikka-frontend-flutter/
```
2. Flutter will build the files to build/web directory, 
3. Move files from this folder and assets and icons folder to /docs folder

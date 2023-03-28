# Flutter-Login-and-Registration-Form
Hello, This is a sample login and registartion form in flutter and firebase as a backend. However, before using this code you have to install firebase and create your project in firebase

Before getting started, you are able to create (or have an existing) Flutter project and also have an active Firebase account.
Before any Firebase services can be used, you must first install the firebase_core plugin, which is responsible for connecting your application to Firebase.
Install the plugin by running the following command from the project root:
# flutter pub add firebase_core

Before any of the Firebase services can be used, FlutterFire needs to be initialized (you can think of this process as FlutterFire "bootstrapping" itself). The initialization step is asynchronous, meaning you'll need to prevent any FlutterFire related usage until the initialization is completed. Before this you have to be install Node.js using nvm-windows (the Node Version Manager). Installing Node.js automatically installs the npm command tools. 
# npm install -g firebase-tools
Next, install the FlutterFire CLI by running the following command:
# dart pub global activate flutterfire_cli
In the root of your application, run the configure command:
# flutterfire configure
The next step is Log in and test the Firebase CLI
After installing the CLI, you must authenticate. Then you can confirm authentication by listing your Firebase projects.
Log into Firebase using your Google account by running the following command:
# firebase login
Test that the CLI is properly installed and accessing your account by listing your Firebase projects. Run the following command:
# firebase projects:list

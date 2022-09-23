![Nevis Logo](https://www.nevis.net/hubfs/Nevis/images/logotype.svg)

# Nevis Mobile Authentication SDK Flutter Example Application

This repository contains the example application demonstrating how to use the Nevis Mobile Authentication SDK Flutter plugin in a Flutter application.
The Nevis Mobile Authentication SDK allows you to integrate FIDO UAF 1.1 based authentication in your mobile application. 

Some features demonstrated in this example application are:

* Registering with QR code
* Simulating in-band authentication after registration
* Deregistering a registered account
* Changing the PIN of the PIN authenticator
* Changing the device information
* Registering using the Auth Cloud API (app link URIs)

Please note that the example application only demonstrates a subset of the SDK features. The main purpose is to demonstrate how the SDK can be used and not to cover all supported scenarios and use cases.

## Getting Started

Before you can actually start compiling and using the example applications please ensure you have the following ready:

* An [Authentication Cloud](https://docs.nevis.net/authcloud/) instance provided by Nevis.
* An [access key](https://docs.nevis.net/authcloud/access-app/access-key) to use with the authentication cloud.
* The archive containing the Nevis Mobile Authentication SDK Flutter plugin, binaries and SDK installer

Your development setup has to meet the following prerequisites:

* Xcode 13, including Swift 5.5.2 or later
* Android 6 or later, with API level 23 -or-
* Android 10 or later, with API level 29, for the biometric authenticator to work
* Gradle 7.4 or later

### Initialization

The flutter plugin installation is handed by an SDK installer.

During the installation the following changes are made directly in the Flutter example application project. The paths are relative to the project.

The following build related files are modified:

- `pubspec.yaml`
- `android/build.gradle`
- `android/gradle.properties`
- `android/app/build.gradle`
- `ios/Podfile`

The build script modifications are made between `NEVIS_SDK_INSTALLER_PATCH` and `NEVIS_SDK_INSTALLER_PATCH_END` comments.

The following folders and content will be added to your Flutter application:

- `plugin`
- `android/native-dependencies`
- `android/app/nevis-sdk-dependencies.gradle`
- `ios/native-dependencies`

#### Installation

1. Unpack the received SDK package called `nevis-mobile-authentication-sdk-installer-flutter-FLUTTER_PLUGIN_VERSION.tar.gz`. The suffix `FLUTTER_PLUGIN_VERSION` in the name is replaced with the actual version of the contained Flutter Plugin.

   ```bash
   tar -xvf nevis-mobile-authentication-sdk-installer-flutter-FLUTTER_PLUGIN_VERSION.tar.gz
   ```

2. Change into the directory `nevis-mobile-authentication-sdk-installer-flutter-FLUTTER_PLUGIN_VERSION` and use it as your working directory.
3. Run the SKD installer command:

   ```bash
   ./sdkinstall for-framework Flutter FLUTTER_APP_PROJECT_DIR
   ```

   `FLUTTER_APP_PROJECT_DIR` is your project directory, the path of your Flutter application project, for example: `~/Projects/Flutter/nevis-mobile-authentication-sdk-example-app-flutter`.

   You can run the following command to get the full list of available arguments and options of `sdkinstall` tool:

   ```shell
   ./sdkinstall for-framework --help
   ```

4. Run the `flutter pub get` command in your `FLUTTER_APP_PROJECT_DIR` directory.
5. Run `pod install` in your `FLUTTER_APP_PROJECT_DIR/ios` directory.
6. Synchronize your `FLUTTER_APP_PROJECT_DIR/android` project if opened in Android Studio.

#### Troubleshooting

In case of any error during the installation, check the console log and the created `install.log` file beside the `sdkinstall` tool for more detailed errors.

### Configuration

Before being able to use the example application with your Nevis Customer Authentication cloud instance, you'll need to update the configuration file with the right host information.

Edit the `assets/config_cloud.json` file and replace the host name information with your cloud instance:

```json
{
  "login": {
    "loginRequestURL": "https://<YOUR INSTANCE>.mauth.nevis.cloud/_app/auth/pwd"
  },
  "sdk": {
    "hostname": "<YOUR INSTANCE>.mauth.nevis.cloud",
    ...
  }
}
```

### Build

Now you're ready to build the example application by running:

```bash
flutter build ios
```

```bash
flutter build android
```

### Run

In order to run the Flutter application, you'll need a running emulator or simulator instance or a phone connected to your computer.

You start the application by running:

```bash
flutter run
```

### Try it out 

Now that the Flutter example application is up and running, it's time to try it out!

2. Visit `https://<your-cloud-instance>.mauth.nevis.cloud/test.html`
3. Expand the **Setup & Tokens** panel, and provide your access key in the *Access Token* text field.
4. Click on **Check + Continue**. The message "Provided token and URL are valid, you are good to go!" appears.
5. Expand the **Enroll a new authenticator** panel.
6. Select (if needed) the **App/Push** tab.
7. Provide a username (any username will work for testing purposes) in the **Username** text field.
8. Click on **Enroll**. A QR code is displayed.
9. Scan the QR code with the previously built application and proceed with the registration process.
10. Expand the **Sign an Approval (that is, transaction or login)** panel.
11. Select (if needed) the **App/Push** tab.
12. Provide the username that was given during registration in the **Username** text field.
13. Select **QR Code** in the **Approval Method** drop down menu.
14. Click on **Send Approval**. A QR code is displayed.
15. Scan the QR code with the previously built application and proceed with the authentication.

### Where to go from here?

Check out our comprehensive [Nevis Mobile Authentication SDK documentation](https://docs.nevis.net/mobilesdk/).

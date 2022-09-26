![Nevis Logo](https://www.nevis.net/hubfs/Nevis/images/logotype.svg)

# Nevis Mobile Authentication SDK Flutter Example App

This repository contains the example app demonstrating how to use the Nevis Mobile Authentication SDK Flutter plugin in a Flutter app.
The Nevis Mobile Authentication SDK allows you to integrate passwordless authentication to your existing mobile app, backed by FIDO UAF 1.1. 

Some features demonstrated in this example app are:

* Registering with QR code & app link URIs
* Simulating in-band authentication after registration
* Deregistering a registered account
* Changing the PIN of the PIN authenticator
* Changing the device information
* Using the SDK with the Authentication Cloud

Please note that the example app only demonstrates a subset of the SDK features. The main purpose is to demonstrate how the SDK can be used and not to cover all supported scenarios and use cases.

## Getting Started

Before you can actually start compiling and using the example applications please ensure you have the following ready:

* An [Authentication Cloud](https://docs.nevis.net/authcloud/) instance provided by Nevis.
* An [access key](https://docs.nevis.net/authcloud/access-app/access-key) to use with the Authentication Cloud.
* The archive containing the Nevis Mobile Authentication SDK Flutter plugin, binaries and SDK installer

Your development setup has to meet the following prerequisites:

* iOS 12 or later
* Xcode 13, including Swift 5.5.2 or later
* Android 6 or later, with API level 23 -or-
* Android 10 or later, with API level 29, for the biometric authenticator to work
* Gradle 7.4 or later
* Flutter SDK 3.0.x, stable channel

### Initialization

The Flutter plugin installation is handed by an SDK installer.

During the installation the following changes are made directly in the Flutter example app project. The paths are relative to the project.

The following build related files are modified:

- `pubspec.yaml`
- `android/build.gradle`
- `android/gradle.properties`
- `android/app/build.gradle`
- `ios/Podfile`

The build script modifications are made between `NEVIS_SDK_INSTALLER_PATCH` and `NEVIS_SDK_INSTALLER_PATCH_END` comments.

The following folders and content will be added to your Flutter app:

- `plugin`
- `android/native-dependencies`
- `android/app/nevis-sdk-dependencies.gradle`
- `ios/native-dependencies`

#### Installation

1. Unpack the received SDK package called `nevis-mobile-authentication-sdk-installer-flutter-FLUTTER_PLUGIN_VERSION.tar.gz`. The suffix `FLUTTER_PLUGIN_VERSION` in the name is replaced with the actual version of the contained Flutter plugin.

   ```bash
   tar -xvf nevis-mobile-authentication-sdk-installer-flutter-FLUTTER_PLUGIN_VERSION.tar.gz
   ```

2. Change into the directory `nevis-mobile-authentication-sdk-installer-flutter-FLUTTER_PLUGIN_VERSION` and use it as your working directory.
3. Run the SDK installer command:

   ```bash
   ./sdkinstall for-framework Flutter EXAMPLE_APP_PROJECT_DIR
   ```

   `EXAMPLE_APP_PROJECT_DIR` is the path where this repository has been checked out. For example: `~/Projects/Flutter/nevis-mobile-authentication-sdk-example-app-flutter`:
   
   ```bash
   ./sdkinstall for-framework Flutter ~/Projects/Flutter/nevis-mobile-authentication-sdk-example-app-flutter
   ```

   You can run the following command to get the full list of available arguments and options of `sdkinstall` tool:

   ```shell
   ./sdkinstall for-framework --help
   ```

   > **Warning**
   >
   > The `sdkinstall` command assumes that the `flutter` binary is accessible from your `PATH` environment variable.

4. Run the `flutter pub get` command in your `EXAMPLE_APP_PROJECT_DIR` directory.
5. Run the `flutter pub run build_runner build --delete-conflicting-outputs` command in your `EXAMPLE_APP_PROJECT_DIR` directory.
6. Run `pod install` in your `EXAMPLE_APP_PROJECT_DIR/ios` directory.
7. Synchronize your `EXAMPLE_APP_PROJECT_DIR/android` project if opened in Android Studio.

#### Troubleshooting

In case of any error during the installation, check the console log and the created `install.log` file beside the `sdkinstall` tool for more detailed errors.

### Configuration

Before being able to use the example app with your Authentication Cloud instance, you'll need to update the configuration file with the right host information.

Edit the `assets/config_cloud.json` file and replace
- the host name information with your Authentication Cloud instance
- the FacetId with your Android FacetId

```json
{
  "login": {
    "loginRequestURL": "https://<YOUR INSTANCE>.mauth.nevis.cloud/_app/auth/pwd"
  },
  "sdk": {
    "hostname": "<YOUR INSTANCE>.mauth.nevis.cloud",
    "facetId": "<YOUR ANDROID FACET_ID>",
     ...
  }
}
```

#### Change configuration

The example apps are supporting two kinds of configuration: `cloud` and `onPremise`.

> **_NOTE_**  
> Only *build-time* configuration change is supported.


To change the configuration open the [getit_root.dart](lib/getit_root.dart) file which describes the dependency injection related configuration using the `get_it` dart package.
The `environment` parameter should be changed to one of the values already mentioned.

### Build

Now you're ready to build the example app by running:

```bash
flutter build ios --no-codesign
```

```bash
flutter build apk --debug
```

### Run

In order to run the Flutter example app, you'll need a running emulator or simulator instance or a phone connected to your computer.

You start the application by running:

```bash
flutter run
```

> **_NOTE_**  
> Running the app on an iOS device required codesign setup.


### Try it out 

Now that the Flutter example app is up and running, it's time to try it out!

Check out our [Quickstart Guide](https://docs.nevis.net/mobilesdk/quickstart).

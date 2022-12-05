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

Your development setup has to meet the following prerequisites:

* iOS 12 or later
* Xcode 14.x, including Swift 5.7 or later
* Android 6 or later, with API level 23 -or-
* Android 10 or later, with API level 29, for the biometric authenticator to work
* Gradle 7.4 or later
* Flutter SDK 3.0.x, stable channel

### Initialization

Open a terminal and run the `flutter pub get` command in the root directory to get the dependencies.

<details>
<summary>Android</summary>

1. The Nevis Mobile Authentication Client SDK for Android is published as a GitHub package. In order to be able to download it please edit your [build.gradle](/android/build.gradle) file and add your GitHub username and personal access token:

```groovy
allprojects {
    repositories {
        google ()
        mavenCentral ()
        maven {
            url "https://maven.pkg.github.com/nevissecurity/nevis-mobile-authentication-sdk-android-package"
            credentials {
                username = <GITHUB_USERNAME>
                password = <GITHUB_PERSONAL_ACCESS_TOKEN>
            }
        }
    }
}
```

> **Note**  
> Accessing GitHub packages requires you to have a GitHub account. You must provide a Personal Access Token, as described [here](https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-gradle-registry#using-a-published-package).

2. Synchronize your [android](/android) project if opened in Android Studio.

> **Warning**  
> The package repository only exposes the `debug` flavor. To use the `release` flavor contact us on [sales@nevis.net](mailto:sales@nevis.net).

</details>

<details>
<summary>iOS</summary>

Run `pod install` in your [iOS](/ios) directory.
</details>

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

The example apps are supporting two kinds of configuration: `authenticationCloud` and `identitySuite`.

> **Note**  
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

> **Note**  
> Running the app on an iOS device required codesign setup.


### Try it out 

Now that the Flutter example app is up and running, it's time to try it out!

Check out our [Quickstart Guide](https://docs.nevis.net/mobilesdk/quickstart).

© 2022 made with ❤ by Nevis
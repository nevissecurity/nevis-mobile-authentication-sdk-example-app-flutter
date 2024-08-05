![Nevis Logo](https://www.nevis.net/hubfs/Nevis/images/logotype.svg)

# Nevis Mobile Authentication SDK Flutter Example App

[![Pull Request](https://github.com/nevissecurity/nevis-mobile-authentication-sdk-example-app-flutter/actions/workflows/pr.yml/badge.svg)](https://github.com/nevissecurity/nevis-mobile-authentication-sdk-example-app-flutter/actions/workflows/pr.yml)
[![Develop Branch Commit](https://github.com/nevissecurity/nevis-mobile-authentication-sdk-example-app-flutter/actions/workflows/develop.yml/badge.svg)](https://github.com/nevissecurity/nevis-mobile-authentication-sdk-example-app-flutter/actions/workflows/develop.yml)
[![Release Candidate Build](https://github.com/nevissecurity/nevis-mobile-authentication-sdk-example-app-flutter/actions/workflows/release.yml/badge.svg)](https://github.com/nevissecurity/nevis-mobile-authentication-sdk-example-app-flutter/actions/workflows/release.yml)
[![Main Branch Commit](https://github.com/nevissecurity/nevis-mobile-authentication-sdk-example-app-flutter/actions/workflows/main.yml/badge.svg)](https://github.com/nevissecurity/nevis-mobile-authentication-sdk-example-app-flutter/actions/workflows/main.yml)

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
* Xcode 15.x, including Swift 5.7 or later
* Android 6 or later, with API level 23 -or-
* Android 10 or later, with API level 29, for the biometric authenticator to work
* Gradle 7.4 or later
* Android Gradle Plugin `com.android.tools.build:gradle` 7.0.0 or later
* Kotlin Gradle Plugin `org.jetbrains.kotlin:kotlin-gradle-plugin` 1.8.0 or later
* Dart SDK 3.3.0 or later

### Initialization

Open a terminal and run the `flutter pub get` command in the root directory to get the dependencies.

<details>
<summary>Android</summary>

1. The Nevis Mobile Authentication Client SDK for Android is published as a GitHub package. In order to be able to download it a valid GitHub account and a Personal Access Token is needed. Please define these in one of the following ways:
    * as environment variables.
    * in `gradle.properties` in `GRADLE_USER_HOME` directory or in Gradle installation directory.
    ```properties
    GITHUB_USERNAME=<YOUR USERNAME>
    GITHUB_PERSONAL_ACCESS_TOKEN=<YOUR PERSONAL ACCESS TOKEN>
    ```  

2. Synchronize your [android](/android) project if opened in Android Studio.

> [!WARNING]
> The package repository only exposes the `debug` flavor. To use the `release` flavor contact us on [sales@nevis.net](mailto:sales@nevis.net).

</details>

<details>
<summary>iOS</summary>

Run `pod install` in your [iOS](/ios) directory.
</details>

### Configuration

Before being able to use the example app with your Authentication Cloud instance, you'll need to update the configuration file with the right host information.

Edit the `assets/config_authentication_cloud.json` file and replace
- the host name information with your Authentication Cloud instance

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

#### Change configuration

The example apps are supporting two kinds of configuration: `authenticationCloud` and `identitySuite`.

> [!NOTE]
> Only *build-time* configuration change is supported.


To change the configuration open the [getit_root.dart](lib/getit_root.dart) file which describes the dependency injection related configuration using the `get_it` dart package.
The `environment` parameter should be changed to one of the values already mentioned.

#### Android Manifest XML

The example applications handle deep links those contain a valid `dispatchTokenResponse` query parameter of an out-of-band operation. The related configuration located in the [AndroidManifest.xml](android/app/src/main/AndroidManifest.xml) for [MainActivity](android/app/src/main/kotlin/ch/nevis/nevis_mobile_authentication_sdk_example_app_flutter/MainActivity.kt) with action `android.intent.action.VIEW`.

##### Deep links

Change the `nevisaccess` scheme value in the following `intent-filter` with the right scheme information of your environment.

```xml
<intent-filter>
    <action android:name="android.intent.action.VIEW" />

    <category android:name="android.intent.category.DEFAULT" />
    <category android:name="android.intent.category.BROWSABLE" />

    <data android:scheme="nevisaccess" />
</intent-filter>
```

> [!NOTE]
> For more information about deep links, visit the official [Android guide](https://developer.android.com/training/app-links).

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

> [!NOTE]
> Running the app on an iOS device required codesign setup.

#### Troubleshooting

##### Not enough space on Android emulator

When the Android emulator has insufficient internal memory the installation may fail with the error:

```bash
android.os.ParcelableException: java.io.IOException: Requested internal only, but not enough space
```

The solution is to increase the internal memory. In Android Studio
* Open the Virtual Device Manager.
* Select the emulator which you want to make changes then click on the edit button associated to it.
* Click on _Show Advanced Settings_ button to expose hidden things.
* Scroll down to the _Memory and Storage_ section and increase the amount of _Internal Storage_.
* Finally, hit the _Finish_ button to apply the changes. Reboot the Android emulator to ensure everything will work as expected.

### Try it out 

Now that the Flutter example app is up and running, it's time to try it out!

Check out our [Quickstart Guide](https://docs.nevis.net/mobilesdk/quickstart).

## Used Components, Concepts

### Nevis Mobile Authentication SDK Flutter Plugin

The most important component/dependency of the example application is the [Nevis Mobile Authentication SDK Flutter Plugin](https://pub.dev/packages/nevis_mobile_authentication_sdk). It provides the Flutter/Dart API for the native [Nevis Mobile Authentication SDK](https://docs.nevis.net/mobilesdk/) implementations.

### Flutter Bloc

[Flutter Bloc](https://pub.dev/packages/flutter_bloc) is used to implement `BLoC` Design Pattern (Business Logic Component).

### GetIt

[GetIt](https://pub.dev/packages/get_it) **Service Locator** is used to ease accessing use-cases/providers/BLoCs from Flutter Views.

## Integration Notes

In this section you can find hints about how the Nevis Mobile Authentication SDK is integrated into the example app.

* `MobileAuthenticationClient` initialization (which is the entry point to the SDK) is implemented in [ClientProvider](lib/domain/client_provider/client_provider.dart) class.
* All SDK operation invocation is implemented in the corresponding use-case class in [usecase](lib/domain/usecase) folder.
* All SDK specific user interaction related interface implementation can be found in the [interaction](lib/domain/interaction) folder.

### Initialization

The [HomeBloc](lib/ui/screens/home/home_bloc.dart) class is responsible for creating and initializing a `MobileAuthenticationClient` instance (which is the entry point to the SDK) by calling the init method of [ClientProvider](lib/domain/client_provider/client_provider.dart) class. Later this `MobileAuthenticationClient` instance can be used to start the different operations, it is accessible as the `client` property of the [ClientProvider](lib/domain/client_provider/client_provider.dart) class.
The default implementation of [ClientProvider](lib/domain/client_provider/client_provider.dart) is [ClientProviderImpl](lib/domain/client_provider/client_provider.dart), it is injected into all use-case, user interaction related interface implementation where it is needed.

### Registration

Before being able to authenticate using the Nevis Mobile Authentication SDK, go through the registration process. Depending on the use case, there are two types of registration: [in-app registration](#in-app-registration) and [out-of-band registration](#out-of-band-registration).

#### In-app registration

If the application is using a backend using the Nevis Authentication Cloud, the [AuthCloudApiRegisterUseCase](lib/domain/usecase/auth_cloud_api_register_usecase.dart) class will be used by passing the `enrollResponse` response or an `appLinkUri`.

When the backend used by the application does not use the Nevis Authentication Cloud the [RegistrationUseCase](lib/domain/usecase/registration_usecase.dart) class will be used. If authorization is required by the backend to register, provide an `AuthorizationProvider`.  
In the example app a `CookieAuthorizationProvider` is used from the [Credentials](lib/domain/model/login/credentials.dart) object returned by the `execute` method of [LoginUseCase](lib/domain/usecase/login_usecase.dart). Behind the scenes it is created from the cookies obtained by the [LoginDataSource](lib/data/datasource/login/login_datasource.dart) class.  
To see the whole process check [LegacyLoginBloc](lib/ui/screens/legacy_login/legacy_login_bloc.dart) implementation.

#### Out-of-band registration

When the registration is initiated in another device or application, the information required to process the operation is transmitted through a QR code or a link. After the payload obtained from the QR code or the link the [OobProcessUseCase](lib/domain/usecase/oob_process_usecase.dart) is used to start the out-of-band operation. Behind the scenes before calling the out-of-band operation [OobPayloadDecodeUseCase](lib/domain/usecase/oob_payload_decode_usecase.dart) is used to decode the `OutOfBandPayload` object from the received payload data.

### Authentication

Using the authentication operation, you can verify the identity of the user using an already registered authenticator. Depending on the use case, there are two types of authentication: [in-app authentication](#in-app-authentication) and [out-of-band authentication](#out-of-band-authentication).

#### In-app authentication

For the application to trigger the authentication, the name of the user is provided to the [AuthenticateUseCase](lib/domain/usecase/authenticate_usecase.dart) class.

#### Out-of-band authentication

When the authentication is initiated in another device or application, the information required to process the operation is transmitted through a QR code or a link. After the payload obtained from the QR code or the link the [OobProcessUseCase](lib/domain/usecase/oob_process_usecase.dart) is used to start the out-of-band operation. Behind the scenes before calling the out-of-band operation [OobPayloadDecodeUseCase](lib/domain/usecase/oob_payload_decode_usecase.dart) is used to decode the `OutOfBandPayload` object from the received payload data.

#### Transaction confirmation

There are cases when specific information is to be presented to the user during the user verification process, known as transaction confirmation. The `AuthenticatorSelectionContext` and the `AccountSelectionContext` contain a byte array with the information. In the example app it is handled in the [AccountSelectorImpl](lib/domain/interaction/account_selector.dart) class.

### Deregistration

The [DeregisterUseCase](lib/domain/usecase/deregister_usecase.dart) and [DeregisterAllUseCase](lib/domain/usecase/deregister_all_usecase.dart) classes is responsible for deregistering either a user or all of the registered users from the device.

### Other operations

#### Change PIN

With the change PIN operation you can modify the PIN of a registered PIN authenticator for a given user. It is implemented in the [ChangePinUseCase](lib/domain/usecase/change_pin_usecase.dart) class.

#### Decode out-of-band payload

Out-of-band operations occur when a message is delivered to the application through an alternate channel like a push notification, a QR code, or a deep link. With the help of the [OobPayloadDecodeUseCase](lib/domain/usecase/oob_payload_decode_usecase.dart) class the application can create an `OutOfBandPayload` either from a JSON or a Base64 URL encoded String. The `OutOfBandPayload` is then used to start an `OutOfBandOperation`, see chapters [Out-of-Band Registration](#out-of-band-registration) and [Out-of-Band Authentication](#out-of-band-authentication).

#### Change device information

During registration, the device information can be provided that contains the name identifying your device, and also the Firebase Cloud Messaging registration token. Updating both the name and the token is implemented in the [ChangeDeviceInformationUseCase](lib/domain/usecase/change_device_information_usecase.dart) class.

© 2023 made with ❤ by Nevis

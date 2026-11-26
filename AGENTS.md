# Nevis Mobile Authentication SDK Flutter Example App

## Project Overview

A Flutter (Dart) example app for Android and iOS. It shows how to integrate the Nevis Mobile Authentication SDK Flutter plugin, a FIDO UAF 1.1 based SDK for passwordless authentication. It is meant as a learning resource and a source of integration code for customer apps. It is not a production-ready app.

Flows demonstrated:

- Client initialization (`MobileAuthenticationClientInitializer`)
- Registration
  - in-app with Authentication Cloud (`authCloudApiRegistration`, using an enrollment response or an `appLinkUri`)
  - in-app with an Identity Suite backend (`registration` with a `CookieAuthorizationProvider` after a username/password login)
  - out-of-band through a QR code, a deep link or pending operations
- Authentication: in-band, out-of-band (QR code / deep link), and transaction confirmation
- Deregistration of one account or all accounts, and deleting local authenticators
- Changing the PIN and the password
- Changing device information
- Fetching pending out-of-band operations
- Reading local data, `MetaData` (SDK version, facet ID, signing certificate) and device capabilities (FIDO UAF attestation support)

Paradigm: **BLoC** (`flutter_bloc`) for the screens, a **use case layer** that wraps the SDK's callback-based Dart API, and **get_it + injectable** for dependency injection (`lib/getit_root.dart`, generated `lib/getit_root.config.dart`). The SDK's interaction callbacks are connected to the UI through a shared state repository and a global `DomainBloc`; see "Architecture".

The example covers only part of the SDK. For features that are not shown here, use the documentation at https://docs.nevis.net/mobilesdk. Don't infer SDK behavior from memory.

## SDK & Related Resources

How the SDK is consumed:

- **Flutter plugin** from pub.dev: [`nevis_mobile_authentication_sdk`](https://pub.dev/packages/nevis_mobile_authentication_sdk), constrained in `pubspec.yaml` (currently `'>=4.9.0 <4.10.0'`).
- The plugin wraps the native SDKs, and **the app has to add the native SDKs itself**:
  - **Android**: `ch.nevis:nevis-mobile-authentication-sdk-android-debug`, declared as `debugImplementation` in `android/app/build.gradle.kts`, with the version in `android/gradle/libs.versions.toml`. It comes from GitHub Packages at `https://maven.pkg.github.com/nevissecurity/nevis-mobile-authentication-sdk-android-package` (declared in `android/build.gradle.kts`), which needs `GH_USERNAME` and `GH_PERSONAL_ACCESS_TOKEN` (a token with the `read:packages` scope). That repository only hosts the **debug flavor**; see `README.md` for how to get the release flavor.
  - **iOS**: Swift Package Manager, via the public package https://github.com/nevissecurity/nevis-mobile-authentication-sdk-ios-package (referenced in `ios/Runner.xcodeproj`). The `Runner` target links `NevisMobileAuthentication-Debug`, and the `Runner_Prod` target links the release flavor `NevisMobileAuthentication`. `README.md` § "Linking the Release Flavor (Target Duplication)" explains this setup.
- The plugin and the native SDKs don't necessarily share the same version number. Look up which native SDK versions belong to a plugin version in the [support matrix](https://docs.nevis.net/configurationguide/nevis-lifecycle/Support-Policies-for-Third-Party-Software/access-app-and-mobile-sdk#flutter-plugin).
- See the [Flutter installation guide](https://docs.nevis.net/mobilesdk/guide/installation/flutter-installation) and [SDK flavors](https://docs.nevis.net/mobilesdk/guide/introduction#sdk-flavors).

Documentation (https://docs.nevis.net):

- [Quickstart: build the example and use it](https://docs.nevis.net/mobilesdk/quickstart)
- [Requirements](https://docs.nevis.net/mobilesdk/guide/requirements) and [device support](https://docs.nevis.net/mobilesdk/guide/device-support)
- [Configuration](https://docs.nevis.net/mobilesdk/guide/configuration) (Authentication Cloud, Identity Suite, custom backend, facet ID)
- [Initialization](https://docs.nevis.net/mobilesdk/guide/initialization)
- Operations: [registration](https://docs.nevis.net/mobilesdk/guide/operation/registration), [authentication](https://docs.nevis.net/mobilesdk/guide/operation/authentication), [deregistration](https://docs.nevis.net/mobilesdk/guide/operation/deregistration), [other operations](https://docs.nevis.net/mobilesdk/guide/operation/other-operations)
- [Error handling](https://docs.nevis.net/mobilesdk/guide/error-handling), [best practices](https://docs.nevis.net/mobilesdk/guide/best-practices), [troubleshooting](https://docs.nevis.net/mobilesdk/appendixes/troubleshooting)
- Integration scenarios: [Authentication Cloud](https://docs.nevis.net/mobilesdk/integration-scenarios/authentication-cloud), [Identity Suite](https://docs.nevis.net/mobilesdk/integration-scenarios/identity-suite)
- [Push support](https://docs.nevis.net/mobilesdk/guide/push_support) (not implemented in this example)
- [Flutter API reference](https://docs.nevis.net/mobilesdk/api-references/flutter/nevis_mobile_authentication_sdk/), [all API references](https://docs.nevis.net/mobilesdk/reference/api-references)
- [Flutter release notes](https://docs.nevis.net/mobilesdk/release_notes/flutter-release-notes)
- [Authentication Cloud documentation](https://docs.nevis.net/authcloud/)

Example apps on other platforms (same feature set, useful for comparison):

- Android: https://github.com/nevissecurity/nevis-mobile-authentication-sdk-example-app-android
- Android, Kotlin Coroutines: https://github.com/nevissecurity/nevis-mobile-authentication-sdk-example-app-android-coroutines
- iOS: https://github.com/nevissecurity/nevis-mobile-authentication-sdk-example-app-ios
- iOS, RxSwift: https://github.com/nevissecurity/nevis-mobile-authentication-sdk-example-app-ios-rx
- React Native: https://github.com/nevissecurity/nevis-mobile-authentication-sdk-example-app-react

## Prerequisites & Configuration

Backend: either a **Nevis Authentication Cloud** instance (with an access key to start enrollments), or an **Identity Suite** setup (nevisFIDO behind nevisProxy/nevisAuth). See `README.md` § "Getting Started".

All configuration is **build-time only**. To point the app at your own environment:

1. **Pick the environment.** In `lib/getit_root.dart`, change `environment: 'authenticationCloud'` to `'identitySuite'` if needed. The injectable environment selects the matching `ConfigurationLoader` implementation (`@authenticationCloud` / `@identitySuite` in `lib/configuration/configuration_loader.dart`).
2. **Backend settings.** These live in `assets/`:
   - `config_authentication_cloud.json`: replace `myinstance.mauth.nevis.cloud` in `sdk.hostname` and `login.loginRequestURL`.
   - `config_identity_suite.json`: set `sdk.hostname` and `login.loginRequestURL`. The SDK `Configuration` is built in `ConfigurationLoader.sdkConfiguration()`: `Configuration.authCloudBuilder()` for Authentication Cloud, and `Configuration.admin4PatternBuilder()` (default Identity Suite paths) for Identity Suite. If your endpoints differ, change the builder there. See [Configuration](https://docs.nevis.net/mobilesdk/guide/configuration).
   - Both files contain `authenticatorAllowlist`, the AAIDs that may be offered:
     - Android: `F1D0#0001` PIN, `#0002` fingerprint, `#0003` biometric, `#0004` device passcode, `#0005` password.
     - iOS: `F1D0#1001` PIN, `#1002` Touch ID, `#1003` Face ID, `#1004` device passcode, `#1005` password.
   - `allowClass2Sensors` (Android face unlock on Class 2 devices) is also set in these files.
3. **Identity Suite login (in-app registration only).** `lib/data/datasource/login/login_datasource.dart` (Dio + cookie manager) posts to `loginRequestURL` with nevisAuth form fields. The cookies it receives become a `CookieAuthorizationProvider`. Adapt this to your login flow.
4. **Deep links.** Change the `nevisaccess` custom scheme in two places:
   - **Android**: in `android/app/src/main/AndroidManifest.xml`, the `MainActivity` `VIEW` intent filter.
   - **iOS**: in `ios/Runner/Info.plist`, under `CFBundleURLTypes` → `CFBundleURLSchemes`.

   The native code (`MainActivity.kt` / `DeepLinkReceiver.kt` on Android, `DeepLinkPlugin.swift` on iOS) forwards URLs to Dart through the `nevis_mobile_authentication_sdk_example/deeplink_method_channel` (initial link) and `…/deeplink_event_channel` (later links). `DeepLinkRepository` passes them on, and only the `dispatchTokenResponse` query parameter is processed. For verified App Links / Universal Links, add an https host with `assetlinks.json` (Android) or Associated Domains with `apple-app-site-association` (iOS).
5. **App identifiers and facet IDs.** The Android `applicationId` is `ch.nevis.nevis_mobile_authentication_sdk_example`, and the iOS bundle ID is `ch.nevis.mobile.authentication.sdk.flutter.example`. The backend must know **both** facet IDs (`android:apk-key-hash:…` and `ios:bundle-id:…`), or operations fail with an untrusted facet ID error. The Home screen shows the facet ID of the running build (from `MetaData`). On Android the facet ID is derived from the signing certificate, so builds signed with different keys have different facet IDs; register the facet ID of every certificate you use. See [Facet ID](https://docs.nevis.net/mobilesdk/guide/configuration#facet-id).
6. **iOS signing.** Set your own development team in Xcode to run on a device.

## Build & Run Commands

`README.md` has the full setup (toolchain versions, GitHub token, the iOS release-flavor target). Quick reference:

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs   # regenerate getit_root.config.dart and *.g.dart after changing @injectable / @JsonSerializable code
flutter run                                                # run on a connected device / emulator / simulator
flutter build apk --debug
flutter build ios --no-codesign
dart format .                                              # formatting (enforced in CI with --set-exit-if-changed)
flutter analyze                                            # lints (analysis_options.yaml, flutter_lints)
```

Requirements: the Flutter and Dart SDK versions in `pubspec.yaml` (`environment`), Java 17, and Xcode with Swift Package Manager. Localized strings are generated from `lib/l10n/app_en.arb` (`flutter: generate: true`, `l10n.yaml`). `test/widget_test.dart` is leftover template code, so there are no meaningful automated tests; to verify changes, run the app against a backend.

## Architecture

### Source layout (`lib/`)

```
main.dart                 configureDependencies(), MaterialApp with the global navigator key
getit_root.dart           get_it/injectable setup and environment selection (generated: getit_root.config.dart)
configuration/            ConfigurationLoader (per environment), AppConfiguration / SdkConfiguration / LoginConfiguration (json_serializable)
data/
  cache/, repository/     StateRepository: in-memory holder of the running operation's state (handlers, contexts)
  datasource/deep_link/   Method/Event channel bridge to the native deep link code
  datasource/login/       Identity Suite login over Dio (demo only)
domain/
  client_provider/        ClientProvider: initializes MobileAuthenticationClient and registers it in get_it
  usecase/                One use case per SDK operation or user step (execute(...))
  interaction/            SDK callback implementations: account/authenticator selectors (separate ones for registration and
                          authentication), PIN/password enroller, verifier and changer, biometric/fingerprint/device passcode verifiers
  blocs/domain_state/     DomainBloc: global bus for "SDK needs user input" states
  blocs/local_data/       LocalDataBloc: accounts and authenticators
  validation/             AuthenticatorValidator, AccountValidator, PasswordPolicyImpl
  model/, error/, extension/
navigation/               AppNavigation (routes), GlobalNavigationManager (navigation without BuildContext)
ui/
  app_state/              AppBloc: listens to DomainBloc and navigates through GlobalNavigationManager
  screens/<name>/         <name>_screen.dart + _bloc/_event/_state + navigation/ (route + parameter)
  theme/, widgets/
android/                  Native Android host (MainActivity, deep link receiver, Gradle with the native SDK dependency)
ios/                      Native iOS host (AppDelegate, DeepLinkPlugin, SPM dependency, Runner and Runner_Prod targets)
```

### How SDK callbacks reach the UI

1. A screen BLoC calls a use case, for example `AuthenticateUseCaseImpl.execute(...)`. The use case saves the operation type in `StateRepository<OperationType>` and starts the SDK operation with the interaction objects that get_it injects.
2. When the SDK needs user input, the interaction implementation (for example `AuthenticatorSelectorImpl.selectAuthenticator`) stores the SDK **context and handler** in `StateRepository<UserInteractionOperationState>` and adds an event to `DomainBloc` (for example `SelectAuthenticatorEvent`).
3. `AppBloc` listens to `DomainBloc` states and pushes the right screen through `GlobalNavigationManager`.
4. That screen's BLoC calls the next use case (for example `SelectAuthenticatorUseCaseImpl.execute(aaid, …)`), which reads the handler from the state repository and completes it (`handler.aaid(...)`).
5. The operation's `onSuccess` / `onError` callbacks add a `ResultEvent` / `AuthenticationSucceededEvent` to `DomainBloc` or hand the error to `ErrorHandler`, and the state is reset.

Other details:

- **Named bindings**: there are two `AuthenticatorSelector` instances, `@Named("auth_selector_reg")` and `@Named("auth_selector_auth")`. They filter differently through `AuthenticatorValidator`.
- **Cancellation**: `CancelUserInteractionOperationUseCase` and `CancelCredentialOperationUseCase` cancel the pending handler when the user leaves a screen.
- **Biometric, fingerprint and device passcode prompts**: the confirmation screen pauses and resumes the SDK's OS authentication listen handler on app lifecycle changes (`PauseListeningUseCase` / `ResumeListeningUseCase`, `ConfirmationScreen.didChangeAppLifecycleState`).
- **Initialization**: `HomeBloc` calls `ClientProvider.init(...)`, which registers the `MobileAuthenticationClient` as a get_it singleton.
- **Environment-specific behavior**: with Identity Suite, deregistration works on one account at a time and starts with account selection. With Authentication Cloud, all accounts are deregistered directly (see `HomeBloc`).

## Integration Guidance

When moving code into your own app:

| If you want to… | Look at | Notes |
|---|---|---|
| Add the SDK | `pubspec.yaml`, `android/app/build.gradle.kts`, `android/gradle/libs.versions.toml`, `ios/Runner.xcodeproj` (SPM) | Both the plugin **and** the native SDKs are needed. For release builds, add the release flavor on both platforms; see [Flutter installation](https://docs.nevis.net/mobilesdk/guide/installation/flutter-installation). |
| Configure the backend | `assets/config_*.json`, `ConfigurationLoader` | [Configuration](https://docs.nevis.net/mobilesdk/guide/configuration) |
| Initialize the SDK once | `ClientProvider` | |
| Bridge SDK callbacks to UI | `domain/interaction/`, `StateRepository`, `DomainBloc`, `AppBloc` | Reusable pattern; replace BLoC or navigation with your own state management if needed. |
| Register with Authentication Cloud | `AuthCloudApiRegisterUseCase`, `auth_cloud_api_registration/` | Your backend gets the enrollment response / `appLinkUri` from Authentication Cloud. |
| Register with Identity Suite | `RegistrationUseCase`, `LoginUseCase`, `LegacyLoginBloc` | Replace the login call with your own; keep the `AuthorizationProvider` idea. |
| Handle QR codes / deep links | `OobPayloadDecodeUseCase`, `OobProcessUseCase`, `data/datasource/deep_link/`, native `MainActivity.kt` / `DeepLinkPlugin.swift` | QR scanning (`read_qr_code/`, `mobile_scanner`) is demo scaffolding. |
| Authenticate in-band | `AuthenticateUseCase` | |
| Pick the authenticator | `AuthenticatorSelectorImpl` and subclasses, `SelectAuthenticatorUseCase`, `AuthenticatorValidator` | Reusable filtering logic; replace the UI. |
| Enroll, verify or change a PIN/password | `pin_*_impl.dart`, `password_*.dart`, `EnrollCredentialUseCase`, `VerifyCredentialUseCase`, `ChangePinUseCase`, `ChangePasswordUseCase`, `credential/` | Recoverable errors and protection status (lockout/cool-down) are shown on the credential screen. |
| Biometric / fingerprint / device passcode | `*_user_verifier_impl.dart`, `*ListenForOsCredentialsUseCase`, `confirmation/` | Customize the prompt texts. |
| Transaction confirmation | `AccountSelectorImpl`, `transaction_confirmation/` | [Transaction confirmation](https://docs.nevis.net/mobilesdk/concept/operations/transaction-confirmation) |
| Deregister / delete authenticators / device info | `DeregisterUseCase`, `DeregisterAllUseCase`, `DeleteAuthenticatorsUseCase`, `ChangeDeviceInformationUseCase` | |
| Pending out-of-band operations | `PendingOutOfBandOperationsUseCase` | |
| Push notifications | Not implemented | See [Push support](https://docs.nevis.net/mobilesdk/guide/push_support). |

Demo-only code that should not be copied as is:

- showing raw technical errors to users (see [Error handling](https://docs.nevis.net/mobilesdk/guide/error-handling))
- the hard-coded login request
- the UI widgets and theme
- the placeholder URL scheme and host names

If something isn't covered here, check https://docs.nevis.net (guide + Flutter API reference) before you write code. Don't guess the API.

## Conventions & Gotchas

- **Native SDK versions**: the plugin version (`pubspec.yaml`), the Android SDK version (`libs.versions.toml`) and the iOS package version (SPM in the Xcode project) are configured separately. They don't necessarily share the same version number, so use the [support matrix](https://docs.nevis.net/configurationguide/nevis-lifecycle/Support-Policies-for-Third-Party-Software/access-app-and-mobile-sdk#flutter-plugin) and the [Flutter release notes](https://docs.nevis.net/mobilesdk/release_notes/flutter-release-notes) to select compatible native SDK versions for the plugin before upgrading.
- **Release flavor**: the Android release flavor is not in the public package repository, and only the `Runner_Prod` iOS target links the release flavor. The release flavor detects emulators, simulators, debuggers and root/jailbreak, and refuses to run there. `flutter run` with the default target uses the debug flavor.
- **Fatal initialization errors (Android)**: for some `InitializationDeviceProtectionError`s, `ClientProviderImpl` calls `exit(-1)`. Other fatal initialization results are shown on the result screen, whose confirm button also exits the app. This is deliberate demo behavior after the SDK reports a compromised environment; decide how your own app should react.
- **Generated code**: after changing `@injectable` / `@singleton` / `@Named` annotations or `@JsonSerializable` models, run `build_runner`. The `*.g.dart` and `getit_root.config.dart` files are committed; don't edit them by hand.
- **Minimum OS**: the iOS deployment target is 15.5, and the Android `minSdk` comes from Flutter's default (`flutter.minSdkVersion`). The SDK itself needs Android 7 (API 24) or later. The Android biometric authenticator needs API 29+, and the device passcode authenticator needs API 30+.
- **Device lock and enrollment**: biometric, fingerprint and device passcode authenticators need a secure lock screen / device passcode and enrolled biometrics. Simulate them in the Android emulator's extended controls or with the iOS simulator's *Features → Face ID / Touch ID*.
- **`NSFaceIDUsageDescription` and `NSCameraUsageDescription`** must stay in `ios/Runner/Info.plist`. Without them, iOS terminates the app when Face ID or the QR scanner is used.
- **Handlers are single-use**: every SDK handler must be completed or cancelled exactly once. Clear it from the state repository after use, as the existing use cases do.
- **Code style**: `dart format` and `flutter analyze` must pass. Use `debugPrint` for logs; `main.dart` silences it in release mode.
- **Never commit secrets**: `android/keystore.properties`, `android/local.properties` and `.env` files are git-ignored and must stay that way. Don't commit GitHub tokens or keystores that hold real signing keys either.

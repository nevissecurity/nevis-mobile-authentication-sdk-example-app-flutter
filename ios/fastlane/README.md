fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## iOS

### ios pr

```sh
[bundle exec] fastlane ios pr
```

Pull request build



### ios develop

```sh
[bundle exec] fastlane ios develop
```

Continuous build

#### Options

 * **`version`**: The version of the application.

 * **`build_number`**: The build number of the application.



### ios main

```sh
[bundle exec] fastlane ios main
```

Release build

#### Options

 * **`version`**: The version of the application.

 * **`build_number`**: The build number of the application.



----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).

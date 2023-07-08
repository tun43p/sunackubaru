# Sunackubaru

## Table of contents

- [Sunackubaru](#sunackubaru)
  - [Table of contents](#table-of-contents)
  - [Gettings started](#gettings-started)
    - [Install project dependencies](#install-project-dependencies)
    - [Run the application](#run-the-application)
      - [Run in debug mode](#run-in-debug-mode)
      - [Run in release mode](#run-in-release-mode)
    - [Analyze the application](#analyze-the-application)
    - [Test the application](#test-the-application)
    - [Build generated files](#build-generated-files)
  - [Add translations](#add-translations)
  - [Thanks to](#thanks-to)
  - [License](#license)

## Gettings started

> If you want to run pubspec scripts, you can install the following package globally by running `dart pub global activate rps`

### Install project dependencies

To install project dependencies, you can run the following command:

```bash
flutter pub get
```

Or, with the RPS:

```bash
rps get
```

### Run the application

#### Run in debug mode

To run the application in debug mode, you can run the following command:

```bash
flutter run -d macos --dart-define-from-file=env.json
```

Or, with the RPS:

```bash
rps || rps run || rps start debug
```

#### Run in release mode

To run the application in release mode, you can run the following command:

```bash
flutter run -d macos --dart-define-from-file=env.json --release
```

Or, with the RPS:

```bash
rps start release
```

### Analyze the application

To analyze the application, you can run the following command:

```bash
flutter analyze
```

Or, with the RPS:

```bash
rps analyze
```

### Test the application

To test the application, you can run the following command:

```bash
flutter test -d macos --dart-define-from-file=env.json
```

Or, with the RPS:

```bash
rps test
```

### Build generated files

To build generative files, you can run the following command:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

Or, with the RPS:

```bash
rps gen build
```

Otherwise, you can run the following command to watch for changes:

```bash
flutter pub run build_runner watch --delete-conflicting-outputs
```

Or, with the RPS:

```bash
rps gen watch
```

## Add translations

To generate new translations, you need to edit the `json` files in the `i18n` folders. The `lib/core/i18n` folder contains the global translations of the application _(if they are used in several places)_, otherwise, you can create an `i18n` folder in your feature folder and create the `feature_name_fr.i18n.json` and `feature_name_en.i18n.json` files. It is also important to know that the base language of the application is French, that's why we force French in the tests. Otherwise, the language of the application will adapt directly to the language of your phone.

## Thanks to

[Flutter on Top: Elevate Your App to the macOS Status Bar - Sudhanshu Kumar Yadav](https://dev.to/sky1095/flutter-on-top-elevate-your-app-to-the-macos-status-bar-1lfh)

## License

MIT License

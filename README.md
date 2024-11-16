# wild_rice_locator

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

Flutter 3.24.2 • channel stable • https://github.com/flutter/flutter.git
Framework • revision 4cf269e36d (2 months ago) • 2024-09-03 14:30:00 -0700
Engine • revision a6bd3f1de1
Tools • Dart 3.5.2 • DevTools 2.37.2

## Android Setup

1. In your `android/app/src/main/AndroidManifest.xml` file, replace the `<meta-data>` tag for the Google Maps API key with the following:

   ```xml
   <meta-data
       android:name="com.google.android.geo.API_KEY"
       android:value="${GOOGLE_MAPS_API_KEY}" />
   ```

2. In your project-level `android/gradle.properties` file, add the following line:

   ```
   GOOGLE_MAPS_API_KEY=YOUR_API_KEY_HERE
   ```

   Replace `YOUR_API_KEY_HERE` with your actual Google Maps API key.

3. Make sure to add `android/gradle.properties` to your `.gitignore` file so that your API key is not committed to your Git repository.

## iOS Setup

1. In your `ios/Runner/AppDelegate.swift` file, replace the `GMSServices.provideAPIKey()` call with the following:

   ```swift
   if let apiKey = ProcessInfo.processInfo.environment["GOOGLE_MAPS_API_KEY"] {
       GMSServices.provideAPIKey(apiKey)
   }
   ```

2. In your project-level `ios/Flutter/flutter_export_environment.sh` file, add the following line:

   ```
   export "GOOGLE_MAPS_API_KEY=YOUR_API_KEY_HERE"
   ```

   Replace `YOUR_API_KEY_HERE` with your actual Google Maps API key.

3. Make sure to add `ios/Flutter/flutter_export_environment.sh` to your `.gitignore` file so that your API key is not committed to your Git repository.

By using environment variables, you can keep your sensitive API keys secure while still allowing others to build and run your Flutter app. Remember to update the API key values in the appropriate files and to ignore the files containing the API keys in your `.gitignore`.

# Kwanu

Kwanu is a Flutter mobile app prototype for finding rental homes in Malawi.

## Overview

The app currently includes:
- Landing screen with sign up/login forms
- Rental listings feed with search and category filters
- House detail pages
- Favorites toggling (local state)
- Map view using OpenStreetMap via `flutter_map`
- “More” and profile/edit-profile UI screens

## Tech Stack

- Flutter (Material 3)
- Dart
- `flutter_map`
- `latlong2`

## Project Structure

Key folders/files:
- `lib/main.dart` – app entry point and routes
- `lib/screens/` – UI screens (home, listings, map, details, profile, etc.)
- `lib/models/house.dart` – rental house model
- `assets/` – logos, background image, and house photos
- `pubspec.yaml` – dependencies and asset/font configuration

## Prerequisites

- Flutter SDK installed
- Dart SDK (bundled with Flutter)
- Android Studio/Xcode or a connected emulator/device

## Getting Started

From the project root:

```bash
flutter pub get
flutter run
```

## Common Commands

```bash
flutter analyze
flutter test
```

## Current Status / Notes

- This is an early-stage prototype with mostly local/demo data.
- Authentication and backend integration are not yet implemented.
- Some actions (for example customer support, posting listings, contact landlord) are placeholders.

## App Identity

- App name (UI): **Kwanu**
- Package name in map user agent: `com.kwanu.app`

# ElectroPi

ElectroPi is a Flutter-based project management application developed as part of an assessment.

The application allows users to authenticate, manage projects and tasks, update profiles, and interact with data through API integration while providing a responsive and smooth user experience.

## Features

* User Login & Registration
* Form Validation
* API Integration using Dio
* Error Handling & Loading States
* Project Listing
* Project Search
* Task Management
* Profile Update
* Local Storage using SharedPreferences
* Dark Mode Support
* Responsive UI
* State Management using BLoC

## Screenshots

### Application Preview

|                       |                       |
| --------------------- | --------------------- |
| ![](assets/SS/1.jpg)  | ![](assets/SS/2.jpg)  |
| ![](assets/SS/3.jpg)  | ![](assets/SS/4.jpg)  |
| ![](assets/SS/5.jpg)  | ![](assets/SS/6.jpg)  |
| ![](assets/SS/7.jpg)  | ![](assets/SS/8.jpg)  |
| ![](assets/SS/9.jpg)  | ![](assets/SS/10.jpg) |
| ![](assets/SS/11.jpg) | ![](assets/SS/12.jpg) |
| ![](assets/SS/13.jpg) | ![](assets/SS/14.jpg) |
| ![](assets/SS/15.jpg) | ![](assets/SS/16.jpg) |

<p align="center">
  <img src="assets/SS/17.jpg" width="300"/>
</p>

---

## Getting Started

This project is a starting point for a Flutter application.

### Prerequisites

Make sure you have installed:

* Flutter SDK
* Dart SDK
* Android Studio / VS Code
* Emulator or Physical Device

Check installation:

```bash
flutter doctor
```

---

## Installation

Clone the repository:

```bash
git clone https://github.com/MahmoudTareek/ElectroPi.git
```

Move to project directory:

```bash
cd ElectroPi
```

Install dependencies:

```bash
flutter pub get
```

Run the application:

```bash
flutter run
```

---

## Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter

  flutter_bloc:
  dio:
  shared_preferences:
  fluttertoast:
  smooth_page_indicator:
  webview_flutter:
  conditional_builder_null_safety:
```

Install packages:

```bash
flutter pub get
```

---

## Project Structure

```plaintext
lib
│
├── cubit/
│   ├── cubit.dart
│   └── states.dart
│
├── models/
│
├── modules/
│
├── shared/
│   ├── components.dart
│   ├── network/
│   └── styles/
│
├── layout/
│
└── main.dart
```

---

## Built With

* Flutter
* Dart
* BLoC
* Dio
* SharedPreferences

---

For help getting started with Flutter development, view the official documentation:

https://docs.flutter.dev/

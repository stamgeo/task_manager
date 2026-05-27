# Task Manager

![Flutter CI](https://github.com/stamgeo/task_manager/actions/workflows/flutter-ci.yml/badge.svg)

A personal Flutter project built for learning purposes. Every line of code is written by hand to get hands-on experience with Flutter, Dart, and app architecture. AI is used only as a tutor, documentation reference, and code reviewer.

## About

- **Goal:** become comfortable with Flutter by building a real app from scratch
- **Architecture:** MVVM with `provider` for state management
- **Testing:** unit tests with `flutter_test` and `test`

## Getting Started

Requirements:
- Flutter 3.41.7 (stable)
- Dart 3.11.5

```bash
flutter pub get
flutter run
```

Run tests and analyze:

```bash
flutter test
flutter analyze
```

## CI

GitHub Actions runs `flutter analyze` and `flutter test` on every push to `main` and on pull requests. See [.github/workflows/flutter-ci.yml](.github/workflows/flutter-ci.yml).


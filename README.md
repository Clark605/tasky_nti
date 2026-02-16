# Tasky ✅


## What the project does 🚀
Tasky is a Flutter task management app focused on polished onboarding, authentication, and a clean empty-state home screen. It demonstrates a production-style UI flow with reusable widgets, centralized theming, and form validation.

## Why the project is useful 🌟
- Provides a complete UI starter for task apps with splash, onboarding, auth, and home screens.
- Shows how to build consistent design systems with shared colors, fonts, and widgets.
- Demonstrates form validation patterns for email, password, and phone fields.
- Serves as a solid base for adding task CRUD, APIs, and persistence.

## A Picture of whole app UI 🖼️
![Tasky App UI](assets/images/Tasky.png)

## Folder Structure 📁
```
lib/
  core/
    constants/
      app_constants.dart
    theme/
      app_colors.dart
      app_fonts.dart
    utils/
      validator.dart
    widgets/
      app_button.dart
      app_text_form_field.dart
  feature/
    auth/
      login_screen.dart
      register_screen.dart
      widgets/
        signing_nav.dart
    home/
      home_screen.dart
    onboarding/
      onboarding_data.dart
      onboarding_screen.dart
      widgets/
        custom_animated_widget.dart
        onboarding_button.dart
        onboarding_indicator.dart
    splash/
      splash.dart
assets/
  images/
    onboarding/
    splash/
```

## Technologies Used 🧰
- Flutter (Material)
- Dart
- animate_do (UI animations)
- smooth_page_indicator (onboarding indicators)
- flutter_native_splash (native splash screens)
- Firebase (Auth/Firestore planned for backend integration)
- Firebase Crashlytics (planned for crash reporting)

## github workflow 🔁
- Default branch: `master`
- Integration branch: `develop`
- Create feature branches off `develop` using `feature/your-scope`.
- Open a pull request into `develop` for review.
- Cut a release PR from `develop` into `master` when ready.

## skills learned 🧠
- Flutter navigation with named routes
- Form validation with reusable validators
- Building reusable UI components
- Consistent theming with shared colors and typography
- Asset management and onboarding flows
- Splash screen configuration and animation



## How users can get started 🧩
### Prerequisites ✅
- Flutter SDK (3.9 or later)
- Dart SDK (bundled with Flutter)

### Setup ⚙️
```bash
flutter pub get
```

If you change splash assets or configuration, regenerate the splash:
```bash
flutter pub run flutter_native_splash:create
```

### Run ▶️
```bash
flutter run
```

### Usage example 🧭
The app starts at the splash screen and follows this flow:
```
Splash -> Onboarding -> Login/Register -> Home
```

For navigation routes, see [lib/main.dart](lib/main.dart).

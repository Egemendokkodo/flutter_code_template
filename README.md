# Flutter Code Template

A modern, scalable, and reusable **Flutter application skeleton** to quickly bootstrap new projects.
It comes with a clean layered architecture, service & repository structure, logger, viewmodel layer, and shared UI widgets to help you move fast with a maintainable codebase.

---

## 🎯 Goal

- **Reusable structure**: A ready-to-use template you can copy & reuse for new projects.
- **Readable architecture**: Clear separation into core, data, and feature layers.
- **Easy to extend**: Add new features, services, and screens without breaking the structure.

---

## 🧱 Architecture Overview

This template is roughly organized into the following layers:

- **`lib/core`**: Application-wide infrastructure code
  - `app/` – Router, theme, global assets/config management
  - `constants/` – Constants (e.g. API URLs)
  - `di/` – Dependency injection / provider setup
  - `exceptions/` – Custom exception types
  - `extensions/` – Helpful Flutter extensions used across the app
  - `logger/` – Logging services (e.g. console logger)
  - `network/` – API client, interceptors, API state models
  - `widgets/` – Shared UI components such as buttons, scaffolds, etc.

- **`lib/data`**: Data & domain logic layer
  - `models/` – API and domain models (e.g. `user_model.dart`)
  - `repository/` – Service/repository interfaces and their implementations
  - `viewmodel/` – Base viewmodel layer

- **`lib/feature`**: Feature / screen based modules
  - For example, under `auth/` you will find the login page(view folder), login viewmodel(viewmodel folder) and feature specific widgets (auth/widgets/example.dart).

- **`lib/main.dart`**: Application entrypoint, DI & router initialization.

---

## 📂 Folder Structure (Summary)

```text
lib/
  core/
    app/
      assets/
      router/
      theme/
    constants/
    di/
    exceptions/
    extensions/
    logger/
    network/
    widgets/
  data/
    models/
    repository/
    viewmodel/
  feature/
    auth/
        view/
        viewmodel/
        widgets/
  main.dart
```

---

## 🚀 Getting Started

### 1. Clone the repository

```bash
git clone https://github.com/Egemendokkodo/flutter_code_template.git
cd flutter_code_template
```

### 2. Install dependencies

```bash
flutter pub get
```

### 3. Run the app

```bash
# For Android / iOS / Web
flutter run

# Example: run on Web
flutter run -d chrome
```

---


## 🧩 Example: Adding a New Feature

As an example, to add a `profile` feature, you would typically:

1. Create `lib/feature/profile/` with the following folders:
   - `view/` – Screens (e.g. `profile_page.dart`)
   - `viewmodel/` – State management & business logic
   - `widgets/` – Feature-specific UI components
2. If needed, add models and services under `lib/data/models/` and `lib/data/repository/`.
3. Register the route for your new page in the router under `core/app/router`.
4. Register new services/viewmodels in the DI layer (`core/di/di_providers.dart`).

---

## 🛠 Tech Stack

- **Flutter** – Multi-platform UI toolkit
- **Dart** – Programming language
- **Layered / clean architecture style** (core / data / feature)
- **ViewModel-based state management** (simple but extensible base layer)


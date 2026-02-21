# News App - Route Flutter Course Assignment

A comprehensive Flutter application developed as part of the **Route Flutter Course**. This project demonstrates the implementation of a modern news application, integrating REST APIs, clean architecture principles, and a polished UI/UX.

## 🚀 Features

*   **Dynamic Categories:** Browse news across various categories (Sports, Politics, Science, Health, Business, Environment).
*   **Real-time News:** Fetches the latest news articles using a News API.
*   **Search Functionality:** Easily search for specific news topics.
*   **Custom Drawer:** Navigation drawer for easy access to categories and settings.
*   **Theming:** Support for Dark and Light modes.
*   **Responsive UI:** Designed to look great on various screen sizes.
*   **Splash Screen:** Custom branded splash screen with dark mode support.

## 🛠️ Tech Stack & Libraries

*   **Framework:** [Flutter](https://flutter.dev/)
*   **Language:** [Dart](https://dart.dev/)
*   **Network:** [http](https://pub.dev/packages/http) for API requests.
*   **Image Loading:** [cached_network_image](https://pub.dev/packages/cached_network_image) for efficient image caching and loading.
*   **Icons & Assets:** 
    *   [flutter_svg](https://pub.dev/packages/flutter_svg) for high-quality vector graphics.
    *   [flutter_gen](https://pub.dev/packages/flutter_gen) for type-safe asset management.
*   **Animations:** [flutter_bounceable](https://pub.dev/packages/flutter_bounceable) for interactive UI elements.

## 📂 Project Structure

The project follows a modular and organized folder structure:

```text
lib/
├── core/                # Core configurations, themes, and route management
│   ├── config/          # App routing and theme data
│   └── gen/             # Auto-generated assets files
├── models/              # Data models for API responses and app logic
├── modules/             # UI Modules (Features)
│   ├── home/            # Home screen and its components
│   └── splash/          # Splash screen
├── network_handler/     # API constants and networking logic
└── main.dart            # Entry point of the application
```

## ⚙️ Setup and Installation

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/your-username/news_app.git
    ```
2.  **Navigate to the project directory:**
    ```bash
    cd news_app
    ```
3.  **Install dependencies:**
    ```bash
    flutter pub get
    ```
4.  **Generate assets (if using flutter_gen):**
    ```bash
    dart run build_runner build
    ```
5.  **Run the application:**
    ```bash
    flutter run
    ```

## 📝 Assignment Details

*   **Course:** Route Flutter Course
*   **Task:** News Application Implementation

[//]: # (*   **Objective:** To practice API integration, state management &#40;inferred&#41;, and advanced UI components in Flutter.)

---
*Developed by Amira Gabr*

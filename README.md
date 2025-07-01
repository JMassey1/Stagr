# Stagr 🎤

Stagr is a local-first iOS app built with SwiftUI that helps festival-goers plan which shows to attend. Designed with simplicity and offline functionality in mind, Stagr lets users create and manage their own custom festival schedules, track their favorite artists, and prepare for their event experience.

## ✨ Features

- 📅 Create and browse festivals
- 🎶 Add shows with time, location, and artist details
- ⭐ Mark shows you're interested in
- 🧳 Custom packing list for each festival
- ☀️ Weather integration (coming soon)
- 🔒 Local-only storage using SwiftData
- 🧪 Unit tested with Swift Testing
- 🧱 Feature-first folder structure for maintainability

## 🛠 Architecture

Stagr follows a **feature-based architecture**, organizing models, views, and logic per feature. Shared utilities live in `Common/` and data models are in `Data/`.

Key Technologies:
- **SwiftUI** – Declarative UI
- **SwiftData** – Local persistence
- **Swift Testing** – Built-in unit testing
- **Modern Swift paradigms** – Value types, previews, and property wrappers

## 📸 Screenshots

*Coming soon…*

## 🧪 Running Tests

```sh
⌘ + U
````

All tests are written using the new Swift Testing framework. Coverage is tracked and maintained for all key logic.

## 🚧 Roadmap

* ⛅️ Add weather forecasts to festival detail pages
* ⏰ Smart show conflict alerts
* 🧭 Festival map integration
* 🌐 Export & share your schedule with friends
* ☁️ Optional cloud sync
# 📔 Flutter Diary App

A clean, intuitive Flutter diary application for recording personal journal entries. Create, edit, view, and delete entries with smooth animations and persistent local storage.

---

## Features

- Add, edit, and delete diary entries
- View detailed entry information
- Smooth hero animations for seamless transitions
- Persistent local storage (JSON-based)
- Entries automatically sorted by date (newest first)
- Organized entry structure with:
  - **Date & Time**: Full timestamp of when the entry was created/edited
  - **Pressure Line**: Quick snapshot or title for the entry
  - **Output**: Main thoughts or reflections
  - **Friction**: Challenges or obstacles encountered
  - **Correction**: Solutions or learnings

---

## Project Structure

```
lib/
├── main.dart                    # App entry point
├── pages/
│   ├── homepage.dart            # List of all entries (with sorting)
│   ├── view_entry.dart          # Detailed entry view
│   ├── entry_editor.dart        # Create/edit entry screen
│   ├── models.dart              # DiaryEntry data model
│   ├── todo_model.dart          # Todo-related models
│   └── todo_page.dart           # (Optional) Todo feature
├── services/
│   ├── storage.dart             # Generic storage service
│   └── todo_storage.dart        # Todo storage service
└── theme/
    └── colors.dart              # App color scheme
```

---

## Tech Stack

- **Framework**: Flutter
- **Language**: Dart
- **State Management**: `setState()`
- **Storage**: Local JSON file storage
- **UI Animations**: Hero widget for smooth transitions

---

## Getting Started

### Prerequisites

- Flutter SDK installed: [flutter.dev/docs/get-started/install](https://flutter.dev/docs/get-started/install)
- Basic Dart knowledge

### Steps

1. **Clone or open the project**

```bash
cd flutter_application_1
```

2. **Install dependencies**

```bash
flutter pub get
```

3. **Run the app**

```bash
flutter run
```

4. **Develop with hot reload**
   - Press `r` in the terminal to hot reload
   - Press `R` for hot restart

---

## Notes

- **Date Formatting**: Entries display with full month names (e.g., "December" not "Dec") for consistent, readable hero animations.
- **Hero Animation Tags**: Each entry uses a unique ID in its hero tag (`entry_title_{id}`) to prevent animation conflicts when multiple items share the same screen.
- **Sorting**: The app automatically sorts entries by date on load and after each modification (add/edit), keeping the newest entries at the top.
- **Storage**: All entries are saved to local files in JSON format for persistence between app sessions.

---

## Known Features (Implemented)

✅ Create new entries  
✅ Edit existing entries  
✅ Delete entries  
✅ Hero animations (fixed tag collision issues)  
✅ Date-based sorting (newest first)  
✅ Local persistence

---

## Possible Future Enhancements

- [ ] Search/filter entries by keywords
- [ ] Export entries as PDF or text
- [ ] Tags or categories for entries
- [ ] Dark mode support
- [ ] Cloud sync (Firebase, etc.)
- [ ] Password protection

---

## License

This project is open source and available under the MIT License.

---

**Happy journaling!** 📝

# Flutter Project Structure
| Folder/File | Purpose |
| :--- | :--- |
| **lib/** | Entry point (main.dart) and all Dart logic. |
| **android/** | Native Android config (Gradle, manifest). |
| **ios/** | Native iOS config (Info.plist, assets). |
| **assets/** | Custom folder for images, fonts, and data. |
| **pubspec.yaml** | Project settings, versions, and dependencies. |
| **test/** | Automated testing scripts. |

**Reflection:** This structure ensures a "Separation of Concerns," allowing native tweaks while keeping the core UI cross-platform.
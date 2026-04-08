# TaskEase System Architecture

## A. System Overview
- **Frontend:** Flutter (Web/Android/iOS)
- **Backend/Database:** Firebase Firestore (NoSQL)
- **Authentication:** Firebase Auth (Email/Password)
- **State Management:** Localized StatefulWidget logic (setState)

## B. Data Flow Diagram
[Insert Image or Mermaid Link Here]
User Input -> Flutter Service -> Firebase Auth -> Firestore Database -> Real-time UI Update

## C. Firebase Integration
1. **Auth:** Handles user signup/login for task privacy.
2. **Firestore:** Stores 'Tasks' collection (fields: title, description, dueDate, isCompleted).

## D. Maintenance
- To run: `flutter run -d chrome`
- Configuration: Requires `firebase_options.dart` generated via FlutterFire CLI.
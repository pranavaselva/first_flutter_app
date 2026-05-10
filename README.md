# TaskEase Manager

## Firebase Authentication Overview
This Flutter project now supports secure user authentication using Firebase Authentication with Email & Password.

Users can:
- Create new accounts
- Login with existing credentials
- Sign out securely
- Automatically update the Firebase Console Users list

## Enable Email/Password Auth in Firebase
1. Open Firebase Console.
2. Select your Firebase project.
3. Go to **Authentication** → **Sign-in method**.
4. Enable **Email/Password**.
5. Click **Save**.

## Dependencies
The app includes Firebase dependencies in `pubspec.yaml`:

```yaml
dependencies:
  firebase_core: ^4.6.0
  firebase_auth: ^6.2.0
  cloud_firestore: ^6.2.0
```

## Firebase Initialization
Firebase is initialized in `lib/main.dart` using the generated `firebase_options.dart` file:

```dart
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
```

## Authentication Flow
The app uses an auth gate in `lib/main.dart` to listen to Firebase authentication state changes and show either:
- `AuthScreen` when the user is signed out
- `ResponsiveHome` when the user is signed in

### Signup / Login UI
Implemented in `lib/screens/auth_screen.dart` with:
- Email TextField
- Password TextField
- Login / Signup button
- Toggle between Login and Signup modes

### Login / Signup Logic
Authentication is handled in `lib/services/auth_services.dart` using Firebase Auth methods:

```dart
await FirebaseAuth.instance.createUserWithEmailAndPassword(
  email: email,
  password: password,
);

await FirebaseAuth.instance.signInWithEmailAndPassword(
  email: email,
  password: password,
);
```

### Logout
A logout button is available on the dashboard app bar:

```dart
await AuthService().signOut();
```

## Verification
After signup, new users appear in the Firebase Console under **Authentication → Users**.

## Code Snippets
### Signup
```dart
final user = await _authService.signUp(email, password);
if (user != null) {
  // Signup success
}
```

### Login
```dart
final user = await _authService.login(email, password);
if (user != null) {
  // Login success
}
```

## Screenshots
Add these screenshots to the repository and update paths as needed:
- `assets/screenshots/auth_screen.png`
- `assets/screenshots/firebase_users.png`
- `assets/screenshots/login_success.png`

## Reflection
Firebase Auth is useful because it removes the need to build and secure a custom authentication backend. It also provides session management, password validation, and direct user administration from the Firebase Console.

### Challenges faced
- Integrating authentication state flow into the existing app
- Providing clear success/error feedback during login and signup
- Ensuring automatic redirection after auth state changes

---

## Existing App Features
The app still includes a responsive Firestore-driven task dashboard and adaptive screen layout.

# TaskEase Architecture Overview

## 1. System Components
- **Frontend Layer:** Flutter Web using a Modular Folder Structure.
- **State Management:** Local state handling using `setState()` for high-performance UI updates.
- **Responsiveness:** Implemented via `MediaQuery` and `LayoutBuilder`.

## 2. Directory Strategy
- `lib/screens/`: Separates the Onboarding (Welcome) from the Core UI (Dashboard).
- `lib/widgets/`: (Future use) for reusable Task Cards.

## 3. Data Flow
1. **User Interaction:** User clicks "Finish Task" on Welcome Screen.
2. **State Update:** `setState()` triggers a targeted rebuild of the counter.
3. **Navigation:** `Navigator.push` moves the user from `WelcomeScreen` to `ResponsiveHome`.

4. **Adaptive Layout:** `ResponsiveHome` checks device width and chooses between `ListView` or `GridView`.
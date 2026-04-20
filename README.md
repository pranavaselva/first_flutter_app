**#1. Flutter’s Architecture & Performance**
How does Flutter & Dart ensure smooth UI across Android and iOS?

🎨 Self-Rendering Engine Flutter doesn't use the phone's native buttons or labels. It uses its own engine (Impeller/Skia) to draw every pixel. This ensures the app looks and runs at 60-120 FPS consistently on both platforms.

⚖️ The "Diff" Logic When state changes, Flutter compares the new Widget Tree to the old one. It only updates the specific parts that actually changed, rather than redrawing the whole screen.

⚡ Dart’s Native Power Dart compiles directly to ARM machine code (AOT). This means there is no "middleman" (like JavaScript) slowing down the communication between your code and the phone’s hardware.

**#🏗 2. StatelessWidget vs. StatefulWidget**
Specific examples from the TaskEase implementation:

**##🔹 A. StatelessWidget (The Static Blueprint)**
Role in App: Used for the Task Row Item.

Behavior: It receives the task name and a delete function from its parent. Once it is drawn, it never changes itself.

Efficiency: Because it has no "State" of its own, Flutter can cache it and skip rebuilding it unless the list itself changes.

**##🔸 B. StatefulWidget (The Dynamic Engine)**
Role in App: Used for the Main Task List Screen.

Behavior: This widget holds the actual list of tasks in its State object. It "remembers" what tasks you've added or removed.

Why it's used: It allows the UI to react instantly when you type a new task or hit the delete button.

**#🏎 3. Efficient UI Updates with setState()**
Solving the "Laggy App" Case Study:

In the laggy version of the app, setState() was likely called at the top level, forcing the entire app to rebuild. My implementation fixes this:

Dart

// ✅ EFFICIENT UPDATE:
void \_toggleTask(int index) {
setState(() {
// Only the list data inside this specific screen changes.
tasks[index].isCompleted = !tasks[index].isCompleted;
});
}

Why this is fast:
Targeted Rebuilds: Only the widgets affected by the data change are updated.

ListView.builder: Flutter only runs the build method for tasks currently visible on the screen. If you have 100 tasks but only 5 are visible, setState() only affects those 5, keeping the app lag-free even on high-refresh-rate iOS devices.

**#📐 4. The Triangle of UI Optimization**

Render Speed: Optimized via ListView.builder.

State Control: Managed via localized setState() calls.

Consistency: Ensured by Dart's native compilation for Android & iOS.

**#Screenshot**

![alt text](<Screenshot 2026-01-20 at 2.48.43 PM-1.png>)

# SentinelTrack - Sprint 2

## Project Description

A secure tracking application interface built with Flutter to demonstrate basic UI components, state management, and modular folder architecture.

## Folder Structure

- **lib/screens/**: Contains full UI pages. This keeps logic for different views separate.
- **lib/widgets/**: Reusable UI elements (Buttons, Cards) to avoid code duplication.
- **lib/models/**: Data blueprints. Helps in maintaining type safety.
- **lib/services/**: Will house API calls to the Rust backend in future sprints.

## Setup Instructions

1. Install Flutter SDK from flutter.dev.
2. Clone this repo.
3. Run `flutter pub get` to fetch dependencies.
4. Run `flutter run` on an emulator or physical device.

## Reflection

By using a modular structure, I learned how to separate "What the app looks like" (UI) from "How the app behaves" (Logic). This is crucial for scaling the project when we integrate the Rust backend later.

# TaskEase - Responsive Task Manager

📐 Responsiveness Strategy
My approach to adaptive design relied on the Breakpoint Pattern:

Detection: I used MediaQuery.of(context).size.width as the source of truth for the viewport size.

The Threshold: A breakpoint of 600px was set.

Why? This is the standard transition point between large mobile devices and small tablets.

Adaptive Widget Tree: Instead of just resizing elements, I used a LayoutBuilder to swap out the entire layout structure (List vs. Grid). This ensures that a student on a laptop sees a high-information-density view, while a mobile user gets a clean, touch-friendly list.

```dart
double screenWidth = MediaQuery.of(context).size.width;
bool isTablet = screenWidth > 600;
// Switch between layouts based on isTablet

## Demo
![App Screenshot](path/to/your/screenshot.png)

## 2. The Documentation (The "What")

Widget Nesting Structure for TaskEase App:

- **Scaffold** (Root container for the screen)
  - **AppBar** (Top navigation bar with title)
  - **FloatingActionButton** (Add new task button)
  - **Body**: **StreamBuilder** (Listens to Firestore tasks stream)
    - **LayoutBuilder** (Adapts layout based on screen size)
      - **ListView** (Mobile layout) or **GridView** (Tablet layout)
        - **Card** (Container for each task)
          - **ListTile** (Displays task info)
            - **Leading**: **Icon** (Check circle or radio button for completion status)
            - **Title**: **Text** (Task title with strikethrough if completed)
            - **Subtitle**: **Text** (Due date or priority)
            - **Trailing**: **Row** (Container for action buttons)
              - **IconButton** (Edit button)
              - **IconButton** (Delete button)
  - **BottomAppBar** (Displays current viewing mode)

Dialog Structures:
- **AlertDialog** (For add/edit/delete actions)
  - **Title**: **Text** (Dialog title)
  - **Content**: **TextField** (Input field for task title)
  - **Actions**: **Row** of **TextButton** and **ElevatedButton** (Cancel and confirm buttons)

## 4. The Reflection (The "Why")

Widget Tree: It helps Flutter know exactly where every element sits so it can organize complex layouts easily.

Reactive Model: It's efficient because instead of you "telling" the screen to change, you just change the data (setState), and Flutter intelligently repaints the screen for you.

## 5. Stateless vs Stateful Widget Usage Guidelines

When to use Stateless: Use it for everything that doesn't change after the app starts (titles, icons, background colors). It's faster and saves memory.

When to use Stateful: Only when the user interacts with it or data comes in from the internet that needs to change the screen.

Performance: Flutter is smart; it knows to only "repaint" the Stateful widget while leaving the Stateless one alone.
```

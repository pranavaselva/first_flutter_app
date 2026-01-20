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
void _toggleTask(int index) {
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
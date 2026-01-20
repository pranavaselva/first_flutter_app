import 'package:flutter/material.dart';

void main() {
  runApp(const TaskEaseApp());
}

class TaskEaseApp extends StatelessWidget {
  const TaskEaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: const TodoScreen(),
    );
  }
}

// 1. STATEFUL WIDGET: Manages the 'List' state.
// In your video, explain that this holds the "Source of Truth."
class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final List<String> _tasks = ["Buy groceries", "Fix iOS lag issue", "Record demo"];
  final TextEditingController _controller = TextEditingController();

  void _addTask() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _tasks.insert(0, _controller.text);
        _controller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("TaskEase Optimized")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(hintText: "Enter task..."),
                  ),
                ),
                IconButton(icon: const Icon(Icons.add), onPressed: _addTask),
              ],
            ),
          ),
          // 2. PERFORMANCE WIN: Use ListView.builder for O(n) rendering.
          // Explain in README: It only builds what is visible on screen.
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                return TaskItemTile(
                  taskName: _tasks[index],
                  onDelete: () {
                    setState(() => _tasks.removeAt(index));
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// 3. STATELESS WIDGET: Individual rows should be stateless for speed.
// They receive data from the parent and don't need their own heavy 'State' object.
class TaskItemTile extends StatelessWidget {
  final String taskName;
  final VoidCallback onDelete;

  const TaskItemTile({
    super.key,
    required this.taskName,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        title: Text(taskName),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
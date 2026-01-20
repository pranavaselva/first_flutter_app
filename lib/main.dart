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
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepPurple, // Modern purple theme
      ),
      home: const TodoScreen(),
    );
  }
}

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final List<String> _tasks = ["Finish Flutter Project", "Record Video Demo", "Submit Assignment"];
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
      appBar: AppBar(
        centerTitle: true,
        // ✨ STYLISH TITLE WITH BACKGROUND
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade100,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            "TaskEase Optimized",
            style: TextStyle(
              color: Colors.deepPurple,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "What needs to be done?",
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                FloatingActionButton(
                  mini: true,
                  onPressed: _addTask,
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              padding: const EdgeInsets.only(bottom: 20),
              itemBuilder: (context, index) {
                return TaskItemTile(
                  taskName: _tasks[index],
                  onDelete: () {
                    // TARGETED UPDATE
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

class TaskItemTile extends StatelessWidget {
  final String taskName;
  final VoidCallback onDelete;

  const TaskItemTile({super.key, required this.taskName, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        title: Text(taskName, style: const TextStyle(fontWeight: FontWeight.w500)),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
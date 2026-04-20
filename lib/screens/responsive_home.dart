import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ResponsiveHome extends StatefulWidget {
  const ResponsiveHome({super.key});

  @override
  State<ResponsiveHome> createState() => _ResponsiveHomeState();
}

class _ResponsiveHomeState extends State<ResponsiveHome> {
  // --- 1. THE TASK STATUS & ADD LOGIC ---

  // Function to Add Task (CREATE)
  void _addNewTask(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("New Student Task"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: "Enter task title..."),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                FirebaseFirestore.instance.collection('tasks').add({
                  'title': controller.text,
                  'isCompleted': false,
                  'dueDate': 'Tomorrow', // Default for now
                  'priority': 'High',
                  'createdAt': FieldValue.serverTimestamp(),
                });
                Navigator.pop(context);
              }
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  // Function to Edit Task
  void _editTask(BuildContext context, String docId, String currentTitle) {
    final TextEditingController controller = TextEditingController(
      text: currentTitle,
    );
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit Task"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: "Enter task title..."),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                FirebaseFirestore.instance
                    .collection('tasks')
                    .doc(docId)
                    .update({'title': controller.text});
                Navigator.pop(context);
              }
            },
            child: const Text("Update"),
          ),
        ],
      ),
    );
  }

  // Function to Delete Task
  void _deleteTask(BuildContext context, String docId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Task"),
        content: const Text("Are you sure you want to delete this task?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              FirebaseFirestore.instance
                  .collection('tasks')
                  .doc(docId)
                  .delete();
              Navigator.pop(context);
            },
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }

  // Function to Toggle Task Status (UPDATE)
  void _toggleTaskStatus(String docId, bool currentStatus) {
    FirebaseFirestore.instance.collection('tasks').doc(docId).update({
      'isCompleted': !currentStatus,
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text("TaskEase Dashboard"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      // --- 2. FLOATING ACTION BUTTON ---
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addNewTask(context),
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('tasks')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError)
            return const Center(child: Text("Connection Error"));
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data!.docs;

          return LayoutBuilder(
            builder: (context, constraints) {
              if (isTablet) {
                return _buildTabletLayout(docs);
              } else {
                return _buildMobileLayout(docs);
              }
            },
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Viewing mode: ${isTablet ? 'Tablet/Web' : 'Mobile'}",
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _buildMobileLayout(List<QueryDocumentSnapshot> docs) {
    return ListView.builder(
      itemCount: docs.length,
      itemBuilder: (context, index) {
        final task = docs[index].data() as Map<String, dynamic>;
        final String docId = docs[index].id;
        final bool isDone = task['isCompleted'] ?? false;

        return Card(
          margin: const EdgeInsets.all(10),
          child: ListTile(
            onTap: () => _toggleTaskStatus(docId, isDone), // STATUS UPDATE HERE
            leading: Icon(
              isDone ? Icons.check_circle : Icons.radio_button_unchecked,
              color: isDone ? Colors.green : Colors.deepPurple,
            ),
            title: Text(
              task['title'] ?? 'New Task',
              style: TextStyle(
                decoration: isDone ? TextDecoration.lineThrough : null,
              ),
            ),
            subtitle: Text("Due: ${task['dueDate'] ?? 'No date set'}"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () =>
                      _editTask(context, docId, task['title'] ?? ''),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _deleteTask(context, docId),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTabletLayout(List<QueryDocumentSnapshot> docs) {
    return GridView.builder(
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: 3,
      ),
      itemCount: docs.length,
      itemBuilder: (context, index) {
        final task = docs[index].data() as Map<String, dynamic>;
        final String docId = docs[index].id;
        final bool isDone = task['isCompleted'] ?? false;

        return Card(
          color: isDone
              ? Colors.green.withOpacity(0.1)
              : Colors.deepPurple.withOpacity(0.05),
          child: Center(
            child: ListTile(
              onTap: () =>
                  _toggleTaskStatus(docId, isDone), // STATUS UPDATE HERE
              leading: Icon(
                isDone ? Icons.check_circle : Icons.assignment,
                color: isDone ? Colors.green : Colors.deepPurple,
              ),
              title: Text(
                task['title'] ?? 'New Task',
                style: TextStyle(
                  decoration: isDone ? TextDecoration.lineThrough : null,
                ),
              ),
              subtitle: Text("Priority: ${task['priority'] ?? 'Normal'}"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () =>
                        _editTask(context, docId, task['title'] ?? ''),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _deleteTask(context, docId),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

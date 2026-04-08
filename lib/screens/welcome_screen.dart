import 'package:flutter/material.dart';
import 'responsive_home.dart'; // Import the dashboard

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int _tasksCompleted = 0;

  void _finishTask() {
    // Proves setState works for your screenshot
    setState(() {
      _tasksCompleted++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.indigo, Colors.deepPurple],
            begin: Alignment.topLeft,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle_outline, size: 80, color: Colors.white),
            const SizedBox(height: 20),
            const Text("TaskEase Manager", 
              style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
            const SizedBox(height: 40),
            
            // The "State Change" Area for your screenshot
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(15)),
              child: Column(
                children: [
                  Text("Tasks Finished Today: $_tasksCompleted", 
                    style: const TextStyle(color: Colors.white, fontSize: 18)),
                  ElevatedButton(
                    onPressed: _finishTask, 
                    child: const Text("Finish a Task")),
                ],
              ),
            ),
            
            const SizedBox(height: 50),
            // Navigation to Dashboard
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ResponsiveHome()),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.indigo),
              child: const Text("Go to Dashboard →"),
            ),
          ],
        ),
      ),
    );
  }
}
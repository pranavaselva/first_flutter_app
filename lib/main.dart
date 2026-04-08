import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart'; // Import your new screen here

void main() {
  runApp(const TaskManager
  ());
}

class TaskManager
 extends StatelessWidget {
  const TaskManager
  ({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TaskManager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true, // Modern Android/iOS look
      ),
      // This tells Flutter to show the WelcomeScreen first
      home: const WelcomeScreen(), 
    );
  }
}
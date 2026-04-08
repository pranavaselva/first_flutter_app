import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart'; 
// You don't need to import responsive_home here anymore 
// because main.dart only needs to see the first page.

void main() {
  runApp(const TaskManager());
}

class TaskManager extends StatelessWidget {
  const TaskManager({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TaskEase Manager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      // 👇 THIS IS THE FIX: Set the home to WelcomeScreen
      home: const WelcomeScreen(), 
    );
  }
}
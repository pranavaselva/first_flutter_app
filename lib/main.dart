import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; 
import 'screens/welcome_screen.dart'; // Ensure this path is correct

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
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
      // This is the starting point of your app
      home: const ResponsiveHome(), 
    );
  }
}

class ResponsiveHome extends StatelessWidget {
  const ResponsiveHome({super.key});

  @override
  Widget build(BuildContext context) {
    // Media Query now has a valid context from MaterialApp
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: screenWidth < 600 
          ? Column( // MOBILE LAYOUT
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.task_alt, size: 100, color: Colors.indigo),
                const Text("TaskEase Manager", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // This moves the user to the next screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const WelcomeScreen()),
                    );
                  }, 
                  child: const Text("Get Started"),
                ),
              ],
            )
          : Row( // TABLET/WEB LAYOUT
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.task_alt, size: 150, color: Colors.indigo),
                const SizedBox(width: 40),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("TaskEase Manager", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Navigation logic for wide screens
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const WelcomeScreen()),
                        );
                      }, 
                      child: const Text("Get Started"),
                    ),
                  ],
                ),
              ],
            ),
      ),
    );
  }
}
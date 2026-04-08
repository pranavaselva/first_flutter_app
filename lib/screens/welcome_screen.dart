import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  // Simple state to show a "Loading" or "Welcome" message when button is pressed
  bool _isStarted = false;

  void _handleGetStarted() {
    setState(() {
      _isStarted = true;
    });
    
    // In a real app, this is where you'd navigate to the Login or Dashboard
    print("Navigating to Task Dashboard...");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          // Gradient background for a modern look
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.indigo, Colors.deepPurple],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Logo/Icon
            const Icon(
              Icons.assignment_turned_in_rounded,
              size: 120,
              color: Colors.white,
            ),
            const SizedBox(height: 30),

            // Main Heading
            const Text(
              "Welcome to TaskEase",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 15),

            // Tagline
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                "The ultimate task manager for students. Organize your studies, track your projects, and hit every deadline.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
            ),
            const SizedBox(height: 60),

            // State-driven UI Button
            if (!_isStarted)
              ElevatedButton(
                onPressed: _handleGetStarted,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "GET STARTED",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              )
            else
              const Column(
                children: [
                  CircularProgressIndicator(color: Colors.white),
                  SizedBox(height: 10),
                  Text("Preparing your dashboard...", style: TextStyle(color: Colors.white)),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class ResponsiveHome extends StatelessWidget {
  const ResponsiveHome({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Using MediaQuery to get device dimensions
    double screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text("TaskEase Dashboard"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // 2. Conditional Logic for Layout
          if (isTablet) {
            return _buildTabletLayout();
          } else {
            return _buildMobileLayout();
          }
        },
      ),
      // 3. Footer Area
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

  // Mobile Layout: Single Column (List)
  Widget _buildMobileLayout() {
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (context, index) => Card(
        margin: const EdgeInsets.all(10),
        child: ListTile(
          leading: const Icon(Icons.task, color: Colors.deepPurple),
          title: Text("Student Task #${index + 1}"),
          subtitle: const Text("Due in 2 days"),
          trailing: const Icon(Icons.chevron_right),
        ),
      ),
    );
  }

  // Tablet Layout: Two-Column Grid
  Widget _buildTabletLayout() {
    return GridView.builder(
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Two columns
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: 3, // Ensures cards don't get too tall
      ),
      itemCount: 6,
      itemBuilder: (context, index) => Card(
        color: Colors.deepPurple.withOpacity(0.05),
        child: Center(
          child: ListTile(
            leading: const Icon(Icons.assignment, color: Colors.deepPurple),
            title: Text("Task #${index + 1}"),
            subtitle: const Text("Priority: High"),
          ),
        ),
      ),
    );
  }
}
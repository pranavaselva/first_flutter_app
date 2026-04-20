import 'package:flutter/material.dart';

class StatelessStatefulDemo extends StatelessWidget {
  const StatelessStatefulDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Profile",
        ), // Stateless Widget: Header that never changes
      ),
      body: const Center(
        child: LikeButton(), // Stateful Widget: Button that changes state
      ),
    );
  }
}

class LikeButton extends StatefulWidget {
  const LikeButton({super.key});

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  int likes = 0;
  bool isLiked = false;

  void _toggleLike() {
    setState(() {
      isLiked = !isLiked;
      if (isLiked) {
        likes++;
      } else {
        likes--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Likes: $likes'),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _toggleLike,
          style: ElevatedButton.styleFrom(
            backgroundColor: isLiked ? Colors.red : Colors.blue,
          ),
          child: Text(isLiked ? 'Unlike' : 'Like'),
        ),
      ],
    );
  }
}

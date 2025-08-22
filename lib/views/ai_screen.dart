// lib/views/ai_screen.dart

import 'package:flutter/material.dart';

class AiScreen extends StatelessWidget {
  const AiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: const Center(
        child: Text(
          'AI Suggestions Will Be Here',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
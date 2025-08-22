// lib/views/daily_screen.dart

import 'package:flutter/material.dart';

class DailyScreen extends StatelessWidget {
  const DailyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: const Center(
        child: Text(
          'Daily Weather Details Will Be Here',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
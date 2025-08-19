// lib/views/daily_view.dart

import 'package:flutter/material.dart';

class DailyScreen extends StatelessWidget {
  const DailyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF121212),
      body: Center(
        child: Text(
          'Daily View',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }
}
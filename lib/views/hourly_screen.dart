// lib/views/hourly_view.dart

import 'package:flutter/material.dart';

class HourlyScreen extends StatelessWidget {
  const HourlyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF121212),
      body: Center(
        child: Text(
          'Hourly View',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }
}
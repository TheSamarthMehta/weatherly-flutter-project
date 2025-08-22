// lib/views/radar_screen.dart

import 'package:flutter/material.dart';

class RadarScreen extends StatelessWidget {
  const RadarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: const Center(
        child: Text(
          'Radar and Maps Will Be Here',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
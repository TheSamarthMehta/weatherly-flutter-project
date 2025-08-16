// lib/views/widgets/sun_and_moon_card.dart

import 'package:flutter/material.dart';

class SunAndMoonCard extends StatelessWidget {
  const SunAndMoonCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[900],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "SUN & MOON",
              style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold, letterSpacing: 1.2),
            ),
            const SizedBox(height: 15),
            _buildRow(Icons.wb_sunny, "12 hrs 57 mins", "Rise: 5:45 AM", "Set: 6:42 PM"),
            const SizedBox(height: 15),
            _buildRow(Icons.nightlight_round, "Waning Gibbous", "Rise: 10:04 PM", "Set: 11:06 AM"),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(IconData icon, String title, String rise, String set) {
    return Row(
      children: [
        Icon(icon, color: Colors.yellow.shade600, size: 40),
        const SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text("$rise | $set", style: const TextStyle(color: Colors.white70, fontSize: 14)),
          ],
        )
      ],
    );
  }
}
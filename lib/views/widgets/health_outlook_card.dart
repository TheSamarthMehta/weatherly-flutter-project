// lib/views/widgets/health_outlook_card.dart

import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class HealthOutlookCard extends StatelessWidget {
  const HealthOutlookCard({super.key});

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
              "7-DAY HEALTH OUTLOOK",
              style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold, letterSpacing: 1.2),
            ),
            const SizedBox(height: 15),
            _buildHealthRow(PhosphorIcons.leaf(), "Arthritis", "High", Colors.red),
            _buildHealthRow(PhosphorIcons.virus(), "Common Cold", "Low", Colors.green),
            _buildHealthRow(PhosphorIcons.wind(), "Migraine", "Moderate", Colors.orange),
            // _buildHealthRow(PhosphorIcons.lungs(), "Asthma", "High", Colors.red),
          ],
        ),
      ),
    );
  }

  Widget _buildHealthRow(IconData icon, String condition, String level, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.white70, size: 24),
          const SizedBox(width: 12),
          Expanded(child: Text(condition, style: const TextStyle(color: Colors.white, fontSize: 16))),
          Text(level, style: TextStyle(color: color, fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
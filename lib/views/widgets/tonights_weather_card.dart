// lib/views/widgets/tonights_weather_card.dart

import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class TonightsWeatherCard extends StatelessWidget {
  const TonightsWeatherCard({super.key});

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
            // Top row: Title and date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "TONIGHT'S WEATHER",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "THU, AUG 14",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            // Divider like the screenshot
            Divider(
              color: Colors.white24,
              thickness: 0.5,
              height: 24,
            ),

            // Low temp
            Row(
              children: [
                Text(
                  "Low ",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
                const Text(
                  "79°",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  PhosphorIcons.cloud(PhosphorIconsStyle.fill),
                  color: Colors.white70,
                  size: 28,
                ),
              ],
            ),
            const SizedBox(height: 4),
            const Text(
              "Cloudy",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 16),

            // High temp
            Row(
              children: [
                Text(
                  "High ",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
                const Text(
                  "90°",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  PhosphorIcons.cloudRain(PhosphorIconsStyle.fill),
                  color: Colors.blue[300],
                  size: 28,
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Tomorrow forecast
            const Text(
              "Tomorrow: Cloudy with a passing shower or two in the afternoon",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
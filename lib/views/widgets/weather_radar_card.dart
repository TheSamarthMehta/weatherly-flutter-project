// lib/views/widgets/weather_radar_card.dart

import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class WeatherRadarCard extends StatelessWidget {
  const WeatherRadarCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[900],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "RAJKOT WEATHER RADAR & MAPS",
              style: TextStyle(
                color: Colors.white.withOpacity(0.85),
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Map image
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(0),
              topRight: Radius.circular(0),
            ),
            child: Stack(
              children: [
                Image.network(
                  "https://placehold.co/600x400?text=Radar+Map",
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      PhosphorIcons.arrowsOutSimple(PhosphorIconsStyle.bold),
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Options grid
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    _buildOptionButton(
                      icon: PhosphorIcons.cloud(PhosphorIconsStyle.bold),
                      label: "Clouds",
                    ),
                    const SizedBox(width: 8),
                    _buildOptionButton(
                      icon: PhosphorIcons.thermometer(PhosphorIconsStyle.bold),
                      label: "Temperature",
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _buildOptionButton(
                      icon: PhosphorIcons.lightning(PhosphorIconsStyle.bold),
                      label: "Lightning",
                    ),
                    const SizedBox(width: 8),
                    _buildOptionButton(
                      icon: PhosphorIcons.wind(PhosphorIconsStyle.bold),
                      label: "Air Quality",
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: _buildOptionButton(
                    icon: PhosphorIcons.stack(PhosphorIconsStyle.bold),
                    label: "See all maps",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionButton({required IconData icon, required String label}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.grey[850],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 18),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

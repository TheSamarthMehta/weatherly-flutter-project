// lib/views/widgets/sun_and_moon_card.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:weatherly/models/weather_data_model.dart';

class SunAndMoonCard extends StatelessWidget {
  // ✅ ADDED: weatherData parameter
  final WeatherData weatherData;
  const SunAndMoonCard({super.key, required this.weatherData});

  // Helper to format UNIX timestamp to a readable time string
  String _formatTime(int timestamp) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return DateFormat('h:mm a').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    // Calculate daylight duration
    final sunrise = DateTime.fromMillisecondsSinceEpoch(weatherData.sunrise * 1000);
    final sunset = DateTime.fromMillisecondsSinceEpoch(weatherData.sunset * 1000);
    final dayDuration = sunset.difference(sunrise);
    final hours = dayDuration.inHours;
    final minutes = dayDuration.inMinutes.remainder(60);
    final dayLength = "$hours hrs $minutes mins";

    return Card(
      color: Colors.grey[900],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "SUN & MOON",
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
                fontSize: 12,
              ),
            ),
            const Divider(height: 25),
            _buildInfoRow(
              icon: PhosphorIcons.sun(PhosphorIconsStyle.regular),
              // ✅ DYNAMIC: Show calculated day length
              title: dayLength,
              subtitle: "",
              // ✅ DYNAMIC: Show sunrise and sunset times
              riseTime: _formatTime(weatherData.sunrise),
              setTime: _formatTime(weatherData.sunset),
            ),
            Divider(
              color: Colors.white.withOpacity(0.2),
              height: 30,
            ),
            // Moon data can be added here from a different API if needed
            _buildInfoRow(
              icon: PhosphorIcons.moon(PhosphorIconsStyle.regular),
              title: "14 hrs 16 mins",
              subtitle: "Waning Crescent",
              riseTime: "2:10 AM",
              setTime: "4:26 PM",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String title,
    required String subtitle,
    required String riseTime,
    required String setTime,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 4,
          child: Row(
            children: [
              Icon(icon, color: Colors.white, size: 48),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (subtitle.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 14,
                      ),
                    ),
                  ]
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 40,
          child: VerticalDivider(
            color: Colors.white.withOpacity(0.3),
            width: 20,
            thickness: 1,
          ),
        ),
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Rise",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    riseTime,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Set",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    setTime,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// lib/views/widgets/tonights_weather_card.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:weatherly/models/weather_data_model.dart';

class TonightsWeatherCard extends StatelessWidget {
  // ✅ ADDED: weatherData parameter
  final WeatherData weatherData;
  const TonightsWeatherCard({super.key, required this.weatherData});

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
                // ✅ DYNAMIC: Show today's date
                Text(
                  DateFormat('E, MMM d').format(DateTime.now()).toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(
              color: Colors.white24,
              thickness: 0.5,
              height: 24,
            ),
            Row(
              children: [
                const Text(
                  "Low ",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
                // ✅ DYNAMIC: Show low temp
                Text(
                  "${weatherData.tempMin.round()}°",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text(
                  "High ",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
                // ✅ DYNAMIC: Show high temp
                Text(
                  "${weatherData.tempMax.round()}°",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // ✅ DYNAMIC: Show weather description
            Text(
              "Today: ${weatherData.description}.",
              style: const TextStyle(
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

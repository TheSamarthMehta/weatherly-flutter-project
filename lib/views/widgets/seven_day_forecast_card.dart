// lib/views/widgets/seven_day_forecast_card.dart

import 'package:flutter/material.dart';

class SevenDayForecastCard extends StatelessWidget {
  const SevenDayForecastCard({super.key});

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
              "7-DAY FORECAST",
              style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold, letterSpacing: 1.2),
            ),
            const SizedBox(height: 10),
            _buildForecastRow("Thu", Icons.wb_cloudy, "87°", "78°", "58%"),
            _buildForecastRow("Fri", Icons.wb_sunny, "89°", "79°", "25%"),
            _buildForecastRow("Sat", Icons.beach_access, "86°", "77°", "66%"),
            _buildForecastRow("Sun", Icons.thunderstorm, "85°", "76°", "75%"),
          ],
        ),
      ),
    );
  }

  Widget _buildForecastRow(String day, IconData icon, String high, String low, String rainChance) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(flex: 2, child: Text(day, style: const TextStyle(color: Colors.white, fontSize: 16))),
          Expanded(flex: 1, child: Icon(icon, color: Colors.lightBlueAccent)),
          Expanded(flex: 2, child: Text("$high / $low", textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 16))),
          Expanded(flex: 2, child: Text(rainChance, textAlign: TextAlign.right, style: const TextStyle(color: Colors.cyanAccent, fontSize: 16))),
        ],
      ),
    );
  }
}
// lib/views/widgets/main_weather_display.dart

import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class MainWeatherDisplay extends StatelessWidget {
  const MainWeatherDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.grey.shade900.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Rajkot, Gujarat",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              Icon(PhosphorIcons.magnifyingGlass(), color: Colors.white, size: 24),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Icon(Icons.cloudy_snowing, color: Colors.lightBlueAccent, size: 80),
              const SizedBox(width: 20),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "83°",
                    style: TextStyle(fontSize: 64, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  Text(
                    "Cloudy",
                    style: TextStyle(fontSize: 18, color: Colors.white70),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Divider(color: Colors.white24),
          const SizedBox(height: 10),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("See More Details", style: TextStyle(color: Colors.white, fontSize: 16)),
              Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
            ],
          )
        ],
      ),
    );
  }
}
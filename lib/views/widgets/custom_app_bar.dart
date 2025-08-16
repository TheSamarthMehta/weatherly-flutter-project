// lib/views/widgets/custom_app_bar.dart

import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          // Top row with App Name and Icons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(
                    Icons.wb_cloudy_rounded,
                    color: Colors.cyanAccent,
                    size: 32,
                  ),
                  SizedBox(width: 8),
                  Text(
                    "Weatherly",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      PhosphorIcons.user(),
                      color: Colors.white,
                      size: 26,
                    ),
                    onPressed: () {
                      // Handle profile tap
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      PhosphorIcons.list(),
                      color: Colors.white,
                      size: 26,
                    ),
                    onPressed: () {
                      // Handle menu tap
                    },
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Location Pill
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.white24),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  PhosphorIcons.mapPin(),
                  color: Colors.white.withOpacity(0.7),
                ),
                const SizedBox(width: 12),
                const Text(
                  "Rajkot, Gujarat",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

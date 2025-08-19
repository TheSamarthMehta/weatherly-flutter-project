import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

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
            // Card Title
            Text(
              "SUN & MOON",
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
                fontSize: 12,
              ),
            ),
            const Divider(),

            // Sun Information Row
            _buildInfoRow(
              icon: PhosphorIcons.sun(PhosphorIconsStyle.regular),
              title: "12 hrs 51 mins",
              subtitle: "", // Sun doesn't have a phase name
              riseTime: "6:25 AM",
              setTime: "7:16 PM",
            ),

            // Divider between Sun and Moon sections
            Divider(
              color: Colors.white.withOpacity(0.2),
              height: 30,
            ),

            // Moon Information Row
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

  // ✅ EDITED: This is a completely new widget to build the layout from your screenshot.
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
        // Left side: Icon and Title/Subtitle
        Expanded(
          flex: 4, // Gives more space to the left side
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

        // Center: Vertical Divider
        SizedBox(
          height: 40,
          child: VerticalDivider(
            color: Colors.white.withOpacity(0.3),
            width: 20,
            thickness: 1,
          ),
        ),

        // Right side: Rise and Set times
        Expanded(
          flex: 2, // Gives less space to the right side
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

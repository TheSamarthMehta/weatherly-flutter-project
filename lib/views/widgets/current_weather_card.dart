// lib/views/widgets/current_weather_card.dart

import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'dart:ui'; // Needed for FontFeature

class CurrentWeatherCard extends StatefulWidget {
  const CurrentWeatherCard({super.key});

  @override
  State<CurrentWeatherCard> createState() => _CurrentWeatherCardState();
}

class _CurrentWeatherCardState extends State<CurrentWeatherCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      child: Card(
        color: Colors.grey[900], // same as Tonight’sWeatherCard
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Top row: "CURRENT WEATHER" and the time
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "CURRENT WEATHER",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "9:37 AM IST",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              // Top divider matching bottom one
              Divider(
                color: Colors.white24,
                thickness: 0.5,
                height: 32,
                indent: 8,
                endIndent: 8,
              ),

              // Main content row
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        Icon(
                          PhosphorIcons.cloudSun(PhosphorIconsStyle.fill),
                          color: Colors.amber,
                          size: 60,
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "79°",
                                  style: TextStyle(
                                    fontSize: 72,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 8.0, left: 2.0),
                                  child: Text(
                                    "F",
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white70,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        RichText(
                          text: const TextSpan(
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'sans-serif',
                            ),
                            children: [
                              TextSpan(text: "RealFeel"),
                              TextSpan(
                                text: "®",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontFeatures: [FontFeature.superscripts()],
                                ),
                              ),
                              TextSpan(text: " 90°"),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        RichText(
                          text: const TextSpan(
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'sans-serif',
                            ),
                            children: [
                              TextSpan(text: "RealFeel Shade"),
                              TextSpan(
                                text: "™",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontFeatures: [FontFeature.superscripts()],
                                ),
                              ),
                              TextSpan(text: " 86°"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Conditionally display the expanded details
              if (_isExpanded) _buildExpandedDetails(),

              // Bottom divider
              Divider(
                color: Colors.white24,
                thickness: 0.5,
                height: 32,
                indent: 8,
                endIndent: 8,
              ),

              // Tappable row to toggle expanded state
              InkWell(
                onTap: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _isExpanded
                          ? "CLOSE CURRENT CONDITIONS"
                          : "MORE CURRENT CONDITIONS",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      _isExpanded
                          ? PhosphorIcons.caretUp()
                          : PhosphorIcons.caretDown(),
                      color: Colors.white.withOpacity(0.8),
                      size: 16,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExpandedDetails() {
    return Column(
      children: [
        const SizedBox(height: 10),
        _buildDetailRow("Wind", "SE 3 mph"),
        _buildDetailRow("Max Wind Gusts", "18 mph"),
        _buildDetailRow("Humidity", "92%"),
        _buildDetailRow("Indoor Humidity", "92% (Extremely Humid)"),
        _buildDetailRow("Dew Point", "76° F"),
        _buildDetailRow("Max UV Index", "1.9 (Low)"),
        _buildDetailRow("Cloud Cover", "76%"),
        _buildDetailRow("Visibility", "5 mi"),
        _buildDetailRow("Cloud Ceiling", "7000 ft"),
        _buildDetailRow("Air Quality", "39 (Fair)"),
        _buildDetailRow("Pressure", "↓ 29.64 in"),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 16,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
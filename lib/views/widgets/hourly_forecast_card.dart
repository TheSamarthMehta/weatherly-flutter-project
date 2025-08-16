// lib/views/widgets/hourly_forecast_card.dart

import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'hourly_detail_view.dart'; // We will create this file next

class HourlyForecastCard extends StatefulWidget {
  const HourlyForecastCard({super.key});

  @override
  State<HourlyForecastCard> createState() => _HourlyForecastCardState();
}

class _HourlyForecastCardState extends State<HourlyForecastCard> {
  int _selectedIndex = 1; // Default to 10 PM

  // Data modeled from your images and video
  final List<Map<String, dynamic>> hourlyData = [
    {
      "time": "9 PM", "temp": 85, "icon": PhosphorIcons.cloudMoon(PhosphorIconsStyle.fill), "precipitation": 7,
      "details": { "RealFeel®": "89° F", "Humidity": "80%", "Indoor Humidity": "80% (Humid)", "Air Quality": "Poor", "Wind": "SW 9 mph", "Wind Gusts": "13 mph", "Rain Probability": "7%", "Cloud Cover": "80%", "Dew Point": "73° F", "Visibility": "6 mi", "Cloud Ceiling": "30000 ft" }
    },
    {
      "time": "10 PM", "temp": 80, "icon": PhosphorIcons.cloudMoon(PhosphorIconsStyle.fill), "precipitation": 7,
      "details": { "RealFeel®": "87° F", "Humidity": "81%", "Indoor Humidity": "81% (Extremely Humid)", "Air Quality": "Poor", "Wind": "SW 8 mph", "Wind Gusts": "12 mph", "Rain Probability": "7%", "Cloud Cover": "86%", "Dew Point": "74° F", "Visibility": "5 mi", "Cloud Ceiling": "30000 ft" }
    },
    {
      "time": "11 PM", "temp": 80, "icon": PhosphorIcons.cloudMoon(PhosphorIconsStyle.fill), "precipitation": 7,
      "details": { "RealFeel®": "87° F", "Humidity": "81%", "Indoor Humidity": "81% (Extremely Humid)", "Air Quality": "Fair", "Wind": "SW 8 mph", "Wind Gusts": "12 mph", "Rain Probability": "7%", "Cloud Cover": "86%", "Dew Point": "74° F", "Visibility": "5 mi", "Cloud Ceiling": "30000 ft" }
    },
    {
      "time": "12 AM", "temp": 80, "icon": PhosphorIcons.cloudMoon(PhosphorIconsStyle.fill), "precipitation": 7,
      "details": { "RealFeel®": "87° F", "Humidity": "81%", "Indoor Humidity": "81% (Extremely Humid)", "Air Quality": "Poor", "Wind": "SW 8 mph", "Wind Gusts": "12 mph", "Rain Probability": "7%", "Cloud Cover": "86%", "Dew Point": "74° F", "Visibility": "5 mi", "Cloud Ceiling": "30000 ft" }
    },
  ];

  void _showHourlyDetails(BuildContext context, int index) {
    final data = hourlyData[index];
    setState(() {
      _selectedIndex = index;
    });
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => HourlyDetailView(
        time: data['time'] as String,
        day: "Friday", // This can be made dynamic
        data: data,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2D31),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "HOURLY WEATHER",
            style: TextStyle(color: Colors.white.withOpacity(0.7), fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 130,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: hourlyData.length,
              itemBuilder: (context, index) {
                final item = hourlyData[index];
                final isSelected = _selectedIndex == index;
                return GestureDetector(
                  onTap: () => _showHourlyDetails(context, index),
                  child: Container(
                    width: 75, // Adjusted width for better spacing
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    margin: const EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.white : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          item["time"] as String,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            color: isSelected ? Colors.black : Colors.white70,
                          ),
                        ),
                        Icon(
                          item["icon"] as IconData,
                          color: const Color(0xFF0095FF), // Specific blue icon color
                          size: 32,
                        ),
                        Text(
                          "${item["temp"]}°",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: isSelected ? Colors.black : Colors.white,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(PhosphorIcons.drop(PhosphorIconsStyle.fill), color: isSelected ? Colors.blue.shade300 : const Color(0xFF00BFFF), size: 16),
                            const SizedBox(width: 4),
                            Text(
                              "${item["precipitation"]}%",
                              style: TextStyle(color: isSelected ? Colors.black54 : Colors.white70, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
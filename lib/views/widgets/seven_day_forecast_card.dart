import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'dart:math';

class SevenDayForecastCard extends StatefulWidget {
  const SevenDayForecastCard({super.key});

  @override
  State<SevenDayForecastCard> createState() => _SevenDayForecastCardState();
}

class _SevenDayForecastCardState extends State<SevenDayForecastCard> {
  int? _selectedIndex;

  final List<Map<String, dynamic>> forecastData = [
    {
      "day": "Today", "date": "8/18", "icon": PhosphorIcons.cloudLightning(PhosphorIconsStyle.fill),
      "high": 87, "low": 78, "precipitation": 58,
      "details": {
        "forecast": "Mostly cloudy and humid with a couple of thunderstorms.",
        "day": {"icon": PhosphorIcons.cloudLightning(PhosphorIconsStyle.fill), "condition": "Thunderstorms", "precipitation": 58},
        "night": {"icon": PhosphorIcons.cloudMoon(PhosphorIconsStyle.fill), "condition": "Mostly Cloudy", "precipitation": 25},
      }
    },
    {
      "day": "Fri", "date": "8/19", "icon": PhosphorIcons.sun(PhosphorIconsStyle.fill),
      "high": 89, "low": 79, "precipitation": 25,
      "details": {
        "forecast": "Sunny and pleasant.",
        "day": {"icon": PhosphorIcons.sun(PhosphorIconsStyle.fill), "condition": "Sunny", "precipitation": 10},
        "night": {"icon": PhosphorIcons.moon(PhosphorIconsStyle.fill), "condition": "Clear", "precipitation": 5},
      }
    },
    {
      "day": "Sat", "date": "8/20", "icon": PhosphorIcons.cloudRain(PhosphorIconsStyle.fill),
      "high": 86, "low": 77, "precipitation": 66,
      "details": {
        "forecast": "Cloudy with afternoon showers.",
        "day": {"icon": PhosphorIcons.cloudRain(PhosphorIconsStyle.fill), "condition": "Showers", "precipitation": 66},
        "night": {"icon": PhosphorIcons.cloud(PhosphorIconsStyle.fill), "condition": "Cloudy", "precipitation": 40},
      }
    },
    {
      "day": "Sun", "date": "8/21", "icon": PhosphorIcons.cloudLightning(PhosphorIconsStyle.fill),
      "high": 85, "low": 76, "precipitation": 75,
      "details": {
        "forecast": "Expect thunderstorms throughout the day.",
        "day": {"icon": PhosphorIcons.cloudLightning(PhosphorIconsStyle.fill), "condition": "Thunderstorms", "precipitation": 75},
        "night": {"icon": PhosphorIcons.cloudRain(PhosphorIconsStyle.fill), "condition": "Rain", "precipitation": 60},
      }
    },
    {
      "day": "Mon", "date": "8/22", "icon": PhosphorIcons.cloud(PhosphorIconsStyle.fill),
      "high": 88, "low": 77, "precipitation": 45,
      "details": {
        "forecast": "Partly cloudy.",
        "day": {"icon": PhosphorIcons.cloudSun(PhosphorIconsStyle.fill), "condition": "Partly Cloudy", "precipitation": 45},
        "night": {"icon": PhosphorIcons.cloudMoon(PhosphorIconsStyle.fill), "condition": "Partly Cloudy", "precipitation": 20},
      }
    },
    {
      "day": "Tue", "date": "8/23", "icon": PhosphorIcons.wind(PhosphorIconsStyle.fill),
      "high": 90, "low": 80, "precipitation": 15,
      "details": {
        "forecast": "Windy and warm.",
        "day": {"icon": PhosphorIcons.sun(PhosphorIconsStyle.fill), "condition": "Sunny", "precipitation": 15},
        "night": {"icon": PhosphorIcons.moon(PhosphorIconsStyle.fill), "condition": "Clear", "precipitation": 10},
      }
    },
    {
      "day": "Wed", "date": "8/24", "icon": PhosphorIcons.cloudFog(PhosphorIconsStyle.fill),
      "high": 84, "low": 75, "precipitation": 30,
      "details": {
        "forecast": "Morning fog, then clearing.",
        "day": {"icon": PhosphorIcons.cloudFog(PhosphorIconsStyle.fill), "condition": "Foggy", "precipitation": 30},
        "night": {"icon": PhosphorIcons.moon(PhosphorIconsStyle.fill), "condition": "Clear", "precipitation": 15},
      }
    },
  ];

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
            Text(
              "7-DAY FORECAST",
              style: TextStyle(
                fontSize: 12,
                color: Colors.white.withOpacity(0.6),
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(
              color: Colors.white24,
              thickness: 1.0,
              height: 32,
            ),
            // No extra SizedBox - header and Divider right up against forecast
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: forecastData.length,
              itemBuilder: (context, index) {
                return _buildForecastRow(forecastData[index], index);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForecastRow(Map<String, dynamic> data, int index) {
    final isSelected = _selectedIndex == index;
    final int minWeekTemp = forecastData.map<int>((d) => d['low']).reduce(min);
    final int maxWeekTemp = forecastData.map<int>((d) => d['high']).reduce(max);

    double topPadding = (index == 0) ? 0.0 : 10.0;


    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = isSelected ? null : index;
        });
      },
      child: AnimatedSize(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: topPadding, bottom: 10.0), // Tight vertical padding for compact look
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(data['day'], style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500)),
                        Text(data['date'], style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 14)),
                      ],
                    ),
                  ),
                  Expanded(flex: 2, child: Icon(data['icon'] as IconData, color: Colors.white, size: 28)),
                  Expanded(flex: 2, child: Text("${data['low']}°", style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 16))),
                  Expanded(flex: 5, child: _buildTempBar(data['low'], data['high'], minWeekTemp, maxWeekTemp)),
                  Expanded(flex: 2, child: Text("${data['high']}°", textAlign: TextAlign.right, style: const TextStyle(color: Colors.white, fontSize: 16))),
                  Expanded(
                    flex: 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(PhosphorIcons.drop(PhosphorIconsStyle.fill), color: const Color(0xFF00BFFF), size: 16),
                        const SizedBox(width: 4),
                        Text("${data['precipitation']}%", style: const TextStyle(color: Colors.white, fontSize: 16)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected) _buildExpandedView(data['details']),
            if (index < forecastData.length - 1)
              const Divider(color: Colors.white24, thickness: 0.5, height: 0.5), // thin divider, small height
          ],
        ),
      ),
    );
  }

  Widget _buildTempBar(int low, int high, int minWeekTemp, int maxWeekTemp) {
    final double totalWeekRange = (maxWeekTemp - minWeekTemp).toDouble();
    if (totalWeekRange <= 0) return const SizedBox.shrink();

    final double dayRange = (high - low).toDouble();
    final double startOffset = (low - minWeekTemp) / totalWeekRange;
    final double widthFactor = dayRange / totalWeekRange;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        height: 6,
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(3),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.15 * startOffset),
                child: FractionallySizedBox(
                  widthFactor: widthFactor,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.cyan, Colors.yellow, Colors.orange],
                      ),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpandedView(Map<String, dynamic> details) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),  // Reduced padding for expanded content
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            details['forecast'],
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
          const Divider(color: Colors.white24, thickness: 0.5, height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildDayNightDetail("Day", details['day']),
              _buildDayNightDetail("Night", details['night']),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDayNightDetail(String title, Map<String, dynamic> data) {
    return Column(
      children: [
        Text(title, style: TextStyle(color: Colors.white.withOpacity(0.7), fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Icon(data['icon'] as IconData, color: Colors.white, size: 28),
        const SizedBox(height: 8),
        Text(data['condition'], style: const TextStyle(color: Colors.white)),
        const SizedBox(height: 8),
        Row(
          children: [
            Icon(PhosphorIcons.drop(PhosphorIconsStyle.fill), color: const Color(0xFF00BFFF), size: 14),
            const SizedBox(width: 4),
            Text("${data['precipitation']}%", style: const TextStyle(color: Colors.white)),
          ],
        ),
      ],
    );
  }
}

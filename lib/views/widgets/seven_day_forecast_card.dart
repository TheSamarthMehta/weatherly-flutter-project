// lib/views/widgets/seven_day_forecast_card.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SevenDayForecastCard extends StatefulWidget {
  const SevenDayForecastCard({super.key});

  @override
  State<SevenDayForecastCard> createState() => _SevenDayForecastCardState();
}

class _SevenDayForecastCardState extends State<SevenDayForecastCard> 
    with TickerProviderStateMixin {
  int? _selectedIndex;
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

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
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOut),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOutBack));
    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  void _showDayDetails(BuildContext context, int index) {
    final data = forecastData[index];
    setState(() {
      _selectedIndex = index;
    });
    HapticFeedback.lightImpact();
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildDayDetailSheet(data),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _fadeAnimation,
      builder: (context, child) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: [
                    Colors.orange.withOpacity(0.1),
                    Colors.red.withOpacity(0.1),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Card(
                elevation: 0,
                color: Colors.transparent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(),
                      const SizedBox(height: 20),
                      _buildForecastList(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.orange.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.calendar_today,
            color: Colors.orange,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        const Text(
          "7-DAY FORECAST",
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.orange.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.orange.withOpacity(0.3)),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.trending_up,
                color: Colors.orange,
                size: 12,
              ),
              SizedBox(width: 4),
              Text(
                "7D",
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildForecastList() {
    return Column(
      children: forecastData.asMap().entries.map((entry) {
        final index = entry.key;
        final data = entry.value;
        final isSelected = _selectedIndex == index;
        
        return GestureDetector(
          onTap: () => _showDayDetails(context, index),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                colors: [
                  isSelected 
                      ? Colors.orange.withOpacity(0.2)
                      : Colors.white.withOpacity(0.05),
                  isSelected 
                      ? Colors.red.withOpacity(0.1)
                      : Colors.white.withOpacity(0.02),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              border: Border.all(
                color: isSelected 
                    ? Colors.orange.withOpacity(0.4)
                    : Colors.white.withOpacity(0.1),
                width: isSelected ? 2 : 1,
              ),
              boxShadow: isSelected ? [
                BoxShadow(
                  color: Colors.orange.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ] : null,
            ),
            child: Row(
              children: [
                _buildDayInfo(data),
                const SizedBox(width: 16),
                _buildWeatherIcon(data),
                const SizedBox(width: 16),
                Expanded(child: _buildTemperatureBar(data)),
                const SizedBox(width: 16),
                _buildPrecipitationInfo(data),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDayInfo(Map<String, dynamic> data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          data["day"] as String,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          data["date"] as String,
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildWeatherIcon(Map<String, dynamic> data) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        data["icon"] as IconData,
        color: const Color(0xFF00C3FF),
        size: 24,
      ),
    );
  }

  Widget _buildTemperatureBar(Map<String, dynamic> data) {
    final high = data["high"] as int;
    final low = data["low"] as int;
    final range = high - low;
    final maxRange = 20.0; // Assuming max temp range is 20 degrees
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${high}°",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "${low}°",
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 14,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          height: 6,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            gradient: LinearGradient(
              colors: [
                Colors.red.withOpacity(0.8),
                Colors.orange.withOpacity(0.8),
                Colors.yellow.withOpacity(0.8),
                Colors.green.withOpacity(0.8),
                Colors.blue.withOpacity(0.8),
              ],
            ),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: (range / maxRange).clamp(0.0, 1.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: Colors.white.withOpacity(0.3),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPrecipitationInfo(Map<String, dynamic> data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              PhosphorIcons.drop(PhosphorIconsStyle.fill),
              color: const Color(0xFF00BFFF),
              size: 16,
            ),
            const SizedBox(width: 4),
            Text(
              "${data["precipitation"]}%",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            "Rain",
            style: TextStyle(
              color: Colors.blue,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDayDetailSheet(Map<String, dynamic> data) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF1B1B1D),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(top: 12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      data["day"] as String,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      data["date"] as String,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _buildDetailForecast(data),
                const SizedBox(height: 20),
                _buildDayNightDetails(data),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailForecast(Map<String, dynamic> data) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [
            Colors.orange.withOpacity(0.1),
            Colors.red.withOpacity(0.1),
          ],
        ),
        border: Border.all(color: Colors.orange.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                data["icon"] as IconData,
                color: const Color(0xFF00C3FF),
                size: 32,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  data["details"]["forecast"] as String,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDayNightDetails(Map<String, dynamic> data) {
    return Row(
      children: [
        Expanded(
          child: _buildTimeDetail("Day", data["details"]["day"]),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildTimeDetail("Night", data["details"]["night"]),
        ),
      ],
    );
  }

  Widget _buildTimeDetail(String time, Map<String, dynamic> detail) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white.withOpacity(0.05),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        children: [
          Text(
            time,
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Icon(
            detail["icon"] as IconData,
            color: const Color(0xFF00C3FF),
            size: 32,
          ),
          const SizedBox(height: 8),
          Text(
            detail["condition"] as String,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                PhosphorIcons.drop(PhosphorIconsStyle.fill),
                color: const Color(0xFF00BFFF),
                size: 14,
              ),
              const SizedBox(width: 4),
              Text(
                "${detail["precipitation"]}%",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

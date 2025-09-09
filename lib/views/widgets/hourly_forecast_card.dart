// lib/views/widgets/hourly_forecast_card.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'hourly_detail_view.dart';

class HourlyForecastCard extends StatefulWidget {
  const HourlyForecastCard({super.key});

  @override
  State<HourlyForecastCard> createState() => _HourlyForecastCardState();
}

class _HourlyForecastCardState extends State<HourlyForecastCard> 
    with TickerProviderStateMixin {
  int _selectedIndex = 1;
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final List<Map<String, dynamic>> hourlyData = [
    {
      "time": "9 PM", 
      "temp": 85, 
      "icon": PhosphorIcons.cloudMoon(PhosphorIconsStyle.fill), 
      "precipitation": 7,
      "details": { 
        "RealFeel®": "89° F", 
        "Humidity": "80%", 
        "Indoor Humidity": "80% (Humid)", 
        "Air Quality": "Poor", 
        "Wind": "SW 9 mph", 
        "Wind Gusts": "13 mph", 
        "Rain Probability": "7%", 
        "Cloud Cover": "80%", 
        "Dew Point": "73° F", 
        "Visibility": "6 mi", 
        "Cloud Ceiling": "30000 ft" 
      }
    },
    {
      "time": "10 PM", 
      "temp": 80, 
      "icon": PhosphorIcons.cloudMoon(PhosphorIconsStyle.fill), 
      "precipitation": 7,
      "details": { 
        "RealFeel®": "87° F", 
        "Humidity": "81%", 
        "Indoor Humidity": "81% (Extremely Humid)", 
        "Air Quality": "Poor", 
        "Wind": "SW 8 mph", 
        "Wind Gusts": "12 mph", 
        "Rain Probability": "7%", 
        "Cloud Cover": "86%", 
        "Dew Point": "74° F", 
        "Visibility": "5 mi", 
        "Cloud Ceiling": "30000 ft" 
      }
    },
    {
      "time": "11 PM", 
      "temp": 80, 
      "icon": PhosphorIcons.cloudMoon(PhosphorIconsStyle.fill), 
      "precipitation": 7,
      "details": { 
        "RealFeel®": "87° F", 
        "Humidity": "81%", 
        "Indoor Humidity": "81% (Extremely Humid)", 
        "Air Quality": "Fair", 
        "Wind": "SW 8 mph", 
        "Wind Gusts": "12 mph", 
        "Rain Probability": "7%", 
        "Cloud Cover": "86%", 
        "Dew Point": "74° F", 
        "Visibility": "5 mi", 
        "Cloud Ceiling": "30000 ft" 
      }
    },
    {
      "time": "12 AM", 
      "temp": 80, 
      "icon": PhosphorIcons.cloudMoon(PhosphorIconsStyle.fill), 
      "precipitation": 7,
      "details": { 
        "RealFeel®": "87° F", 
        "Humidity": "81%", 
        "Indoor Humidity": "81% (Extremely Humid)", 
        "Air Quality": "Poor", 
        "Wind": "SW 8 mph", 
        "Wind Gusts": "12 mph", 
        "Rain Probability": "7%", 
        "Cloud Cover": "86%", 
        "Dew Point": "74° F", 
        "Visibility": "5 mi", 
        "Cloud Ceiling": "30000 ft" 
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

  void _showHourlyDetails(BuildContext context, int index) {
    final data = hourlyData[index];
    setState(() {
      _selectedIndex = index;
    });
    HapticFeedback.lightImpact();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => HourlyDetailView(
        time: data['time'] as String,
        day: "Friday",
        data: data,
      ),
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
                    Colors.indigo.withOpacity(0.1),
                    Colors.purple.withOpacity(0.1),
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
                      _buildHourlyList(),
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
            color: Colors.indigo.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.schedule,
            color: Colors.indigo,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        const Text(
          "HOURLY FORECAST",
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
            color: Colors.blue.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.blue.withOpacity(0.3)),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.timeline,
                color: Colors.blue,
                size: 12,
              ),
              SizedBox(width: 4),
              Text(
                "24H",
                style: TextStyle(
                  color: Colors.blue,
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

  Widget _buildHourlyList() {
    return Container(
      height: 140,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: hourlyData.length,
        itemBuilder: (context, index) {
          final item = hourlyData[index];
          final isSelected = _selectedIndex == index;
          
          return GestureDetector(
            onTap: () => _showHourlyDetails(context, index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 80,
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  colors: [
                    isSelected 
                        ? Colors.indigo.withOpacity(0.3)
                        : Colors.white.withOpacity(0.1),
                    isSelected 
                        ? Colors.purple.withOpacity(0.2)
                        : Colors.white.withOpacity(0.05),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: Border.all(
                  color: isSelected 
                      ? Colors.indigo.withOpacity(0.6)
                      : Colors.white.withOpacity(0.2),
                  width: isSelected ? 2 : 1,
                ),
                boxShadow: isSelected ? [
                  BoxShadow(
                    color: Colors.indigo.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ] : null,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    item["time"] as String,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : Colors.white70,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: isSelected 
                          ? Colors.indigo.withOpacity(0.3)
                          : Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      item["icon"] as IconData,
                      color: isSelected ? Colors.white : const Color(0xFF0095FF),
                      size: 24,
                    ),
                  ),
                  Text(
                    "${item["temp"]}°",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.white : Colors.white,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: Colors.blue.withOpacity(0.3),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          PhosphorIcons.drop(PhosphorIconsStyle.fill), 
                          color: const Color(0xFF00BFFF), 
                          size: 10
                        ),
                        const SizedBox(width: 1),
                        Text(
                          "${item["precipitation"]}%",
                          style: const TextStyle(
                            color: Colors.white, 
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
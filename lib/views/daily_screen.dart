// lib/views/daily_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:intl/intl.dart';

class DailyScreen extends StatefulWidget {
  const DailyScreen({super.key});

  @override
  State<DailyScreen> createState() => _DailyScreenState();
}

class _DailyScreenState extends State<DailyScreen> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _pulseController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _pulseAnimation;
  
  int _selectedPeriod = 0; // 0 for 15 days, 1 for 30 days
  int _selectedDay = 1; // Current day

  // Enhanced data for 30 days
  final List<Map<String, dynamic>> _dailyForecasts = [
    // Week 1 (Sep 1-7)
    {
      'day': 'M', 'date': 1, 'dayName': 'Monday', 'month': 'SEP', 'week': 1,
      'daytime': {'icon': Icons.cloud, 'condition': 'Cloudy with Rain', 'precipitation': 55, 'high': 88, 'low': 77, 'humidity': 78, 'wind': 'SE 8 mph', 'uv': 'High'},
      'nighttime': {'icon': Icons.nightlight_round, 'condition': 'Cloudy with Moon', 'precipitation': 25, 'humidity': 85, 'wind': 'SE 6 mph'},
    },
    {
      'day': 'T', 'date': 2, 'dayName': 'Tuesday', 'month': 'SEP', 'week': 1, 'isCurrent': true,
      'daytime': {'icon': Icons.wb_sunny, 'condition': 'Sunny with Clouds', 'precipitation': 25, 'high': 91, 'low': 76, 'humidity': 65, 'wind': 'SW 12 mph', 'uv': 'Very High'},
      'nighttime': {'icon': Icons.nightlight_round, 'condition': 'Cloudy with Moon', 'precipitation': 25, 'humidity': 72, 'wind': 'SW 8 mph'},
    },
    {
      'day': 'W', 'date': 3, 'dayName': 'Wednesday', 'month': 'SEP', 'week': 1,
      'daytime': {'icon': Icons.wb_sunny, 'condition': 'Sunny with Clouds', 'precipitation': 25, 'high': 91, 'low': 77, 'humidity': 68, 'wind': 'W 10 mph', 'uv': 'Very High'},
      'nighttime': {'icon': Icons.nightlight_round, 'condition': 'Cloudy with Moon', 'precipitation': 55, 'humidity': 80, 'wind': 'W 7 mph'},
    },
    {
      'day': 'T', 'date': 4, 'dayName': 'Thursday', 'month': 'SEP', 'week': 1,
      'daytime': {'icon': Icons.cloud, 'condition': 'Partly Cloudy', 'precipitation': 55, 'high': 92, 'low': 79, 'humidity': 75, 'wind': 'NW 15 mph', 'uv': 'High'},
      'nighttime': {'icon': Icons.cloud, 'condition': 'Cloudy', 'precipitation': 55, 'humidity': 88, 'wind': 'NW 12 mph'},
    },
    {
      'day': 'F', 'date': 5, 'dayName': 'Friday', 'month': 'SEP', 'week': 1,
      'daytime': {'icon': Icons.thunderstorm, 'condition': 'Cloudy with Rain', 'precipitation': 57, 'high': 89, 'low': 79, 'humidity': 82, 'wind': 'N 18 mph', 'uv': 'Moderate'},
      'nighttime': {'icon': Icons.cloud, 'condition': 'Cloudy', 'precipitation': 59, 'humidity': 90, 'wind': 'N 15 mph'},
    },
    {
      'day': 'S', 'date': 6, 'dayName': 'Saturday', 'month': 'SEP', 'week': 1,
      'daytime': {'icon': Icons.cloud, 'condition': 'Cloudy with Rain', 'precipitation': 94, 'high': 89, 'low': 79, 'humidity': 85, 'wind': 'N 20 mph', 'uv': 'Low'},
      'nighttime': {'icon': Icons.cloud, 'condition': 'Cloudy with Rain', 'precipitation': 98, 'humidity': 92, 'wind': 'N 18 mph'},
    },
    {
      'day': 'S', 'date': 7, 'dayName': 'Sunday', 'month': 'SEP', 'week': 1,
      'daytime': {'icon': Icons.cloud, 'condition': 'Cloudy with Rain', 'precipitation': 75, 'high': 86, 'low': 75, 'humidity': 80, 'wind': 'N 16 mph', 'uv': 'Low'},
      'nighttime': {'icon': Icons.cloud, 'condition': 'Cloudy with Rain', 'precipitation': 75, 'humidity': 85, 'wind': 'N 14 mph'},
    },
    
    // Week 2 (Sep 8-14)
    {
      'day': 'M', 'date': 8, 'dayName': 'Monday', 'month': 'SEP', 'week': 2,
      'daytime': {'icon': Icons.cloud, 'condition': 'Cloudy with Rain', 'precipitation': 58, 'high': 86, 'low': 78, 'humidity': 78, 'wind': 'NW 12 mph', 'uv': 'Moderate'},
      'nighttime': {'icon': Icons.cloud, 'condition': 'Cloudy with Rain', 'precipitation': 56, 'humidity': 82, 'wind': 'NW 10 mph'},
    },
    {
      'day': 'T', 'date': 9, 'dayName': 'Tuesday', 'month': 'SEP', 'week': 2,
      'daytime': {'icon': Icons.wb_sunny, 'condition': 'Partly Sunny', 'precipitation': 55, 'high': 89, 'low': 74, 'humidity': 65, 'wind': 'W 10 mph', 'uv': 'High'},
      'nighttime': {'icon': Icons.cloud, 'condition': 'Cloudy', 'precipitation': 25, 'humidity': 70, 'wind': 'W 8 mph'},
    },
    {
      'day': 'W', 'date': 10, 'dayName': 'Wednesday', 'month': 'SEP', 'week': 2,
      'daytime': {'icon': Icons.cloud, 'condition': 'Cloudy with Rain', 'precipitation': 60, 'high': 90, 'low': 73, 'humidity': 75, 'wind': 'SW 15 mph', 'uv': 'Moderate'},
      'nighttime': {'icon': Icons.nightlight_round, 'condition': 'Partly Cloudy', 'precipitation': 25, 'humidity': 68, 'wind': 'SW 12 mph'},
    },
    {
      'day': 'T', 'date': 11, 'dayName': 'Thursday', 'month': 'SEP', 'week': 2,
      'daytime': {'icon': Icons.cloud, 'condition': 'Cloudy with Rain', 'precipitation': 65, 'high': 92, 'low': 75, 'humidity': 78, 'wind': 'S 18 mph', 'uv': 'Low'},
      'nighttime': {'icon': Icons.cloud, 'condition': 'Cloudy', 'precipitation': 45, 'humidity': 82, 'wind': 'S 15 mph'},
    },
    {
      'day': 'F', 'date': 12, 'dayName': 'Friday', 'month': 'SEP', 'week': 2,
      'daytime': {'icon': Icons.wb_sunny, 'condition': 'Sunny with Clouds', 'precipitation': 30, 'high': 90, 'low': 77, 'humidity': 60, 'wind': 'SW 12 mph', 'uv': 'High'},
      'nighttime': {'icon': Icons.cloud, 'condition': 'Partly Cloudy', 'precipitation': 35, 'humidity': 65, 'wind': 'SW 10 mph'},
    },
    {
      'day': 'S', 'date': 13, 'dayName': 'Saturday', 'month': 'SEP', 'week': 2,
      'daytime': {'icon': Icons.cloud, 'condition': 'Cloudy with Rain', 'precipitation': 70, 'high': 89, 'low': 79, 'humidity': 80, 'wind': 'SE 16 mph', 'uv': 'Low'},
      'nighttime': {'icon': Icons.cloud, 'condition': 'Cloudy with Rain', 'precipitation': 75, 'humidity': 85, 'wind': 'SE 14 mph'},
    },
    {
      'day': 'S', 'date': 14, 'dayName': 'Sunday', 'month': 'SEP', 'week': 2,
      'daytime': {'icon': Icons.cloud, 'condition': 'Cloudy with Rain', 'precipitation': 68, 'high': 91, 'low': 77, 'humidity': 78, 'wind': 'E 14 mph', 'uv': 'Low'},
      'nighttime': {'icon': Icons.cloud, 'condition': 'Cloudy', 'precipitation': 60, 'humidity': 80, 'wind': 'E 12 mph'},
    },
    
    // Week 3 (Sep 15-21)
    {
      'day': 'M', 'date': 15, 'dayName': 'Monday', 'month': 'SEP', 'week': 3,
      'daytime': {'icon': Icons.wb_sunny, 'condition': 'Sunny with Clouds', 'precipitation': 25, 'high': 89, 'low': 76, 'humidity': 55, 'wind': 'SW 10 mph', 'uv': 'High'},
      'nighttime': {'icon': Icons.cloud, 'condition': 'Partly Cloudy', 'precipitation': 30, 'humidity': 60, 'wind': 'SW 8 mph'},
    },
    {
      'day': 'T', 'date': 16, 'dayName': 'Tuesday', 'month': 'SEP', 'week': 3,
      'daytime': {'icon': Icons.wb_sunny, 'condition': 'Sunny with Clouds', 'precipitation': 20, 'high': 90, 'low': 77, 'humidity': 52, 'wind': 'W 12 mph', 'uv': 'High'},
      'nighttime': {'icon': Icons.cloud, 'condition': 'Partly Cloudy', 'precipitation': 25, 'humidity': 58, 'wind': 'W 10 mph'},
    },
    {
      'day': 'W', 'date': 17, 'dayName': 'Wednesday', 'month': 'SEP', 'week': 3,
      'daytime': {'icon': Icons.wb_sunny, 'condition': 'Sunny with Clouds', 'precipitation': 15, 'high': 91, 'low': 76, 'humidity': 50, 'wind': 'NW 10 mph', 'uv': 'Very High'},
      'nighttime': {'icon': Icons.cloud, 'condition': 'Partly Cloudy', 'precipitation': 20, 'humidity': 55, 'wind': 'NW 8 mph'},
    },
    {
      'day': 'T', 'date': 18, 'dayName': 'Thursday', 'month': 'SEP', 'week': 3,
      'daytime': {'icon': Icons.thunderstorm, 'condition': 'Thunderstorms', 'precipitation': 80, 'high': 91, 'low': 76, 'humidity': 75, 'wind': 'N 25 mph', 'uv': 'Low'},
      'nighttime': {'icon': Icons.cloud, 'condition': 'Cloudy', 'precipitation': 70, 'humidity': 80, 'wind': 'N 20 mph'},
    },
    {
      'day': 'F', 'date': 19, 'dayName': 'Friday', 'month': 'SEP', 'week': 3,
      'daytime': {'icon': Icons.cloud, 'condition': 'Cloudy with Rain', 'precipitation': 65, 'high': 91, 'low': 77, 'humidity': 78, 'wind': 'NE 18 mph', 'uv': 'Low'},
      'nighttime': {'icon': Icons.cloud, 'condition': 'Cloudy with Rain', 'precipitation': 60, 'humidity': 82, 'wind': 'NE 15 mph'},
    },
    {
      'day': 'S', 'date': 20, 'dayName': 'Saturday', 'month': 'SEP', 'week': 3,
      'daytime': {'icon': Icons.cloud, 'condition': 'Cloudy with Rain', 'precipitation': 70, 'high': 92, 'low': 76, 'humidity': 80, 'wind': 'E 20 mph', 'uv': 'Low'},
      'nighttime': {'icon': Icons.cloud, 'condition': 'Cloudy', 'precipitation': 65, 'humidity': 85, 'wind': 'E 18 mph'},
    },
    {
      'day': 'S', 'date': 21, 'dayName': 'Sunday', 'month': 'SEP', 'week': 3,
      'daytime': {'icon': Icons.wb_sunny, 'condition': 'Sunny with Clouds', 'precipitation': 25, 'high': 91, 'low': 76, 'humidity': 55, 'wind': 'SW 12 mph', 'uv': 'High'},
      'nighttime': {'icon': Icons.cloud, 'condition': 'Partly Cloudy', 'precipitation': 30, 'humidity': 60, 'wind': 'SW 10 mph'},
    },
    
    // Week 4 (Sep 22-28)
    {
      'day': 'M', 'date': 22, 'dayName': 'Monday', 'month': 'SEP', 'week': 4,
      'daytime': {'icon': Icons.wb_sunny, 'condition': 'Sunny with Clouds', 'precipitation': 20, 'high': 91, 'low': 75, 'humidity': 52, 'wind': 'W 10 mph', 'uv': 'High'},
      'nighttime': {'icon': Icons.cloud, 'condition': 'Partly Cloudy', 'precipitation': 25, 'humidity': 58, 'wind': 'W 8 mph'},
    },
    {
      'day': 'T', 'date': 23, 'dayName': 'Tuesday', 'month': 'SEP', 'week': 4,
      'daytime': {'icon': Icons.thunderstorm, 'condition': 'Thunderstorms', 'precipitation': 75, 'high': 89, 'low': 76, 'humidity': 78, 'wind': 'N 22 mph', 'uv': 'Low'},
      'nighttime': {'icon': Icons.cloud, 'condition': 'Cloudy', 'precipitation': 65, 'humidity': 82, 'wind': 'N 18 mph'},
    },
    {
      'day': 'W', 'date': 24, 'dayName': 'Wednesday', 'month': 'SEP', 'week': 4,
      'daytime': {'icon': Icons.thunderstorm, 'condition': 'Thunderstorms', 'precipitation': 80, 'high': 91, 'low': 76, 'humidity': 80, 'wind': 'N 25 mph', 'uv': 'Low'},
      'nighttime': {'icon': Icons.cloud, 'condition': 'Cloudy', 'precipitation': 70, 'humidity': 85, 'wind': 'N 20 mph'},
    },
    {
      'day': 'T', 'date': 25, 'dayName': 'Thursday', 'month': 'SEP', 'week': 4,
      'daytime': {'icon': Icons.wb_sunny, 'condition': 'Sunny with Clouds', 'precipitation': 25, 'high': 92, 'low': 75, 'humidity': 55, 'wind': 'SW 12 mph', 'uv': 'High'},
      'nighttime': {'icon': Icons.cloud, 'condition': 'Partly Cloudy', 'precipitation': 30, 'humidity': 60, 'wind': 'SW 10 mph'},
    },
    {
      'day': 'F', 'date': 26, 'dayName': 'Friday', 'month': 'SEP', 'week': 4,
      'daytime': {'icon': Icons.wb_sunny, 'condition': 'Sunny with Clouds', 'precipitation': 20, 'high': 93, 'low': 75, 'humidity': 52, 'wind': 'W 10 mph', 'uv': 'Very High'},
      'nighttime': {'icon': Icons.cloud, 'condition': 'Partly Cloudy', 'precipitation': 25, 'humidity': 58, 'wind': 'W 8 mph'},
    },
    {
      'day': 'S', 'date': 27, 'dayName': 'Saturday', 'month': 'SEP', 'week': 4,
      'daytime': {'icon': Icons.wb_sunny, 'condition': 'Sunny with Clouds', 'precipitation': 15, 'high': 92, 'low': 74, 'humidity': 50, 'wind': 'NW 10 mph', 'uv': 'High'},
      'nighttime': {'icon': Icons.cloud, 'condition': 'Partly Cloudy', 'precipitation': 20, 'humidity': 55, 'wind': 'NW 8 mph'},
    },
    {
      'day': 'S', 'date': 28, 'dayName': 'Sunday', 'month': 'SEP', 'week': 4,
      'daytime': {'icon': Icons.cloud, 'condition': 'Partly Cloudy', 'precipitation': 40, 'high': 90, 'low': 73, 'humidity': 60, 'wind': 'SW 12 mph', 'uv': 'Moderate'},
      'nighttime': {'icon': Icons.cloud, 'condition': 'Cloudy', 'precipitation': 45, 'humidity': 65, 'wind': 'SW 10 mph'},
    },
    
    // Week 5 (Sep 29-30)
    {
      'day': 'M', 'date': 29, 'dayName': 'Monday', 'month': 'SEP', 'week': 5,
      'daytime': {'icon': Icons.wb_sunny, 'condition': 'Sunny with Clouds', 'precipitation': 25, 'high': 89, 'low': 72, 'humidity': 55, 'wind': 'W 10 mph', 'uv': 'High'},
      'nighttime': {'icon': Icons.cloud, 'condition': 'Partly Cloudy', 'precipitation': 30, 'humidity': 60, 'wind': 'W 8 mph'},
    },
    {
      'day': 'T', 'date': 30, 'dayName': 'Tuesday', 'month': 'SEP', 'week': 5,
      'daytime': {'icon': Icons.wb_sunny, 'condition': 'Sunny with Clouds', 'precipitation': 20, 'high': 88, 'low': 71, 'humidity': 52, 'wind': 'NW 10 mph', 'uv': 'High'},
      'nighttime': {'icon': Icons.cloud, 'condition': 'Partly Cloudy', 'precipitation': 25, 'humidity': 58, 'wind': 'NW 8 mph'},
    },
  ];

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(duration: const Duration(milliseconds: 1000), vsync: this);
    _slideController = AnimationController(duration: const Duration(milliseconds: 800), vsync: this);
    _pulseController = AnimationController(duration: const Duration(milliseconds: 2000), vsync: this);

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeOut));
    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOutBack));
    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut));

    _fadeController.forward();
    _slideController.forward();
    _pulseController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  void _onPeriodChanged(int value) {
    setState(() {
      _selectedPeriod = value;
      _selectedDay = 1; // Reset to first day when changing period
    });
    HapticFeedback.lightImpact();
  }

  void _onDaySelected(int dayIndex) {
    setState(() {
      _selectedDay = dayIndex;
    });
    HapticFeedback.lightImpact();
  }



  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Column(
          children: [
            _buildPeriodSelector(),
            _buildSelectedDayDetails(),
            _buildExtendedDetails(),
            Expanded(
              child: _selectedPeriod == 0 ? _build15DayForecast() : _build30DayForecast(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPeriodSelector() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Text(
            'SEPTEMBER',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white.withOpacity(0.9),
              letterSpacing: 1.0,
            ),
          ),
          const Spacer(),
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildPeriodButton('15 DAYS', 0),
                _buildPeriodButton('30 DAYS', 1),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPeriodButton(String text, int index) {
    final isSelected = _selectedPeriod == index;
    return GestureDetector(
      onTap: () => _onPeriodChanged(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.black : Colors.white.withOpacity(0.7),
          ),
        ),
      ),
    );
  }

  Widget _build15DayForecast() {
    final forecastDays = _dailyForecasts.take(15).toList();
    
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: forecastDays.length,
        itemBuilder: (context, index) {
          final forecast = forecastDays[index];
          final isSelected = _selectedDay == index;
          
          return GestureDetector(
            onTap: () => _onDaySelected(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.only(right: 12),
              width: 80,
              child: Column(
                children: [
                  _buildDayHeader(forecast, isSelected),
                  const SizedBox(height: 12),
                  _buildDaytimeForecast(forecast['daytime']),
                  const SizedBox(height: 8),
                  _buildNighttimeForecast(forecast['nighttime']),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _build30DayForecast() {
    // Group days by week
    final weeks = <int, List<Map<String, dynamic>>>{};
    for (final forecast in _dailyForecasts) {
      final week = forecast['week'] as int;
      weeks.putIfAbsent(week, () => []).add(forecast);
    }

    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: weeks.length,
        itemBuilder: (context, weekIndex) {
          final weekNumber = weekIndex + 1;
          final weekDays = weeks[weekNumber] ?? [];
          
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Week Header
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    'Week $weekNumber',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ),
                
                // Week Days Grid - More compact layout
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    childAspectRatio: 1.2,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                  ),
                  itemCount: weekDays.length,
                  itemBuilder: (context, dayIndex) {
                    final forecast = weekDays[dayIndex];
                    final globalIndex = _dailyForecasts.indexOf(forecast);
                    final isSelected = _selectedDay == globalIndex;
                    
                    return GestureDetector(
                      onTap: () => _onDaySelected(globalIndex),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.white.withOpacity(0.2) : Colors.white.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: isSelected ? Colors.white.withOpacity(0.3) : Colors.white.withOpacity(0.1),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Day
                            Text(
                              forecast['day'],
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: Colors.white.withOpacity(0.7),
                              ),
                            ),
                            const SizedBox(height: 2),
                            
                            // Date
                            Text(
                              '${forecast['date']}',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            
                            // Weather Icon
                            Icon(
                              forecast['daytime']['icon'],
                              color: Colors.white,
                              size: 16,
                            ),
                            const SizedBox(height: 2),
                            
                                                         // High Temp
                             Text(
                               '${forecast['daytime']['high'] ?? 'N/A'}°',
                               style: TextStyle(
                                 fontSize: 10,
                                 fontWeight: FontWeight.bold,
                                 color: Colors.white,
                               ),
                             ),
                             const SizedBox(height: 1),
                             
                             // Low Temp
                             Text(
                               '${forecast['nighttime']['low'] ?? 'N/A'}°',
                               style: TextStyle(
                                 fontSize: 8,
                                 color: Colors.white.withOpacity(0.7),
                               ),
                             ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

    Widget _buildSelectedDayDetails() {
    final selectedForecast = _dailyForecasts[_selectedDay];
    final daytime = selectedForecast['daytime'];
    final nighttime = selectedForecast['nighttime'];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white.withOpacity(0.1), Colors.white.withOpacity(0.05)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.calendar_today, color: Colors.white, size: 18),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      selectedForecast['dayName'],
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    Text(
                      '${selectedForecast['month']} ${selectedForecast['date']}',
                      style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.7)),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.orange.withOpacity(0.3)),
                ),
                child: Text('TODAY', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.orange)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          Row(
            children: [
              Expanded(child: _buildTemperatureCard('High', '${daytime['high'] ?? 'N/A'}°', Icons.thermostat, Colors.orange)),
              const SizedBox(width: 10),
              Expanded(child: _buildTemperatureCard('Low', '${daytime['low'] ?? 'N/A'}°', Icons.thermostat, Colors.blue)),
            ],
          ),
          const SizedBox(height: 16),
          
          _buildWeatherDetailsGrid(daytime, nighttime),
        ],
      ),
    );
  }

  Widget _buildExtendedDetails() {
    final selectedForecast = _dailyForecasts[_selectedDay];
    final daytime = selectedForecast['daytime'];
    final nighttime = selectedForecast['nighttime'];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Extended Weather Details',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white.withOpacity(0.9)),
          ),
          const SizedBox(height: 16),
          _buildExtendedSection('Daytime', daytime, true),
          const SizedBox(height: 16),
          _buildExtendedSection('Nighttime', nighttime, false),
        ],
      ),
    );
  }

  Widget _buildExtendedSection(String title, Map<String, dynamic> data, bool isDaytime) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              isDaytime ? Icons.wb_sunny : Icons.nightlight_round,
              color: isDaytime ? Colors.orange : Colors.indigo,
              size: 18,
            ),
            const SizedBox(width: 8),
            Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white.withOpacity(0.9))),
          ],
        ),
        const SizedBox(height: 8),
        
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: 4.0,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          children: [
            _buildExtendedDetailItem('Humidity', '${data['humidity'] ?? 'N/A'}%', Icons.water_drop, Colors.blue),
            _buildExtendedDetailItem('Wind', data['wind'] ?? 'N/A', Icons.air, Colors.green),
            _buildExtendedDetailItem('UV Index', data['uv'] ?? 'N/A', Icons.wb_sunny, Colors.orange),
            _buildExtendedDetailItem('Precipitation', '${data['precipitation'] ?? 'N/A'}%', Icons.cloud, Colors.purple),
          ],
        ),
      ],
    );
  }

  Widget _buildExtendedDetailItem(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(width: 6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(value, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white)),
                Text(label, style: TextStyle(fontSize: 8, color: Colors.white.withOpacity(0.7))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTemperatureCard(String label, String temp, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 6),
          Text(temp, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
          Text(label, style: TextStyle(fontSize: 10, color: Colors.white.withOpacity(0.7))),
        ],
      ),
    );
  }

    Widget _buildWeatherDetailsGrid(Map<String, dynamic> daytime, Map<String, dynamic> nighttime) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildDetailItem('Humidity', '${daytime['humidity'] ?? 'N/A'}%', Icons.water_drop, Colors.blue)),
            const SizedBox(width: 8),
            Expanded(child: _buildDetailItem('Wind', daytime['wind'] ?? 'N/A', Icons.air, Colors.green)),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(child: _buildDetailItem('UV Index', daytime['uv'] ?? 'N/A', Icons.wb_sunny, Colors.orange)),
            const SizedBox(width: 8),
            Expanded(child: _buildDetailItem('Precipitation', '${daytime['precipitation'] ?? 'N/A'}%', Icons.cloud, Colors.purple)),
          ],
        ),
      ],
    );
  }

  Widget _buildDetailItem(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white)),
          Text(label, style: TextStyle(fontSize: 9, color: Colors.white.withOpacity(0.7))),
        ],
      ),
    );
  }

  Widget _buildDayHeader(Map<String, dynamic> forecast, bool isSelected) {
    return Column(
      children: [
        Text(forecast['day'], style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white.withOpacity(0.7))),
        const SizedBox(height: 3),
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(14),
            boxShadow: isSelected ? [BoxShadow(color: Colors.white.withOpacity(0.3), blurRadius: 6, offset: const Offset(0, 2))] : null,
          ),
          child: Center(
            child: Text(
              '${forecast['date']}',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: isSelected ? Colors.black : Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDaytimeForecast(Map<String, dynamic> daytime) {
    return Column(
      children: [
        AnimatedBuilder(
          animation: _pulseAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _pulseAnimation.value,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [BoxShadow(color: Colors.white.withOpacity(0.1), blurRadius: 3, offset: const Offset(0, 1))],
                ),
                child: Icon(daytime['icon'], color: Colors.white, size: 18),
              ),
            );
          },
        ),
        const SizedBox(height: 6),
        
                 Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             Icon(Icons.water_drop, color: Colors.blue.withOpacity(0.8), size: 10),
             const SizedBox(width: 2),
             Text('${daytime['precipitation'] ?? 'N/A'}%', style: TextStyle(fontSize: 9, color: Colors.white.withOpacity(0.7), fontWeight: FontWeight.w500)),
           ],
         ),
        const SizedBox(height: 6),
        
                 Text('${daytime['high'] ?? 'N/A'}°', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
         const SizedBox(height: 6),
         
         Container(
           width: 5,
           height: 50,
           decoration: BoxDecoration(
             gradient: LinearGradient(
               colors: [Colors.orange.withOpacity(0.8), Colors.orange.withOpacity(0.4)],
               begin: Alignment.topCenter,
               end: Alignment.bottomCenter,
             ),
             borderRadius: BorderRadius.circular(2.5),
             boxShadow: [BoxShadow(color: Colors.orange.withOpacity(0.3), blurRadius: 3, offset: const Offset(0, 1))],
           ),
         ),
         const SizedBox(height: 3),
         
         Text('${daytime['low'] ?? 'N/A'}°', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white.withOpacity(0.8))),
      ],
    );
  }

  Widget _buildNighttimeForecast(Map<String, dynamic> nighttime) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(nighttime['icon'], color: Colors.white.withOpacity(0.7), size: 14),
        ),
        const SizedBox(height: 4),
        
                 Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             Icon(Icons.water_drop, color: Colors.blue.withOpacity(0.6), size: 8),
             const SizedBox(width: 2),
             Text('${nighttime['precipitation'] ?? 'N/A'}%', style: TextStyle(fontSize: 8, color: Colors.white.withOpacity(0.6), fontWeight: FontWeight.w500)),
           ],
         ),
      ],
    );
  }
} 
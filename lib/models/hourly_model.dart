// lib/models/hourly_model.dart

import 'package:flutter/material.dart';

class HourlyForecast {
  final String time;
  final int temp;
  final IconData icon;
  final String realFeel;
  final int precipitation;
  final int windSpeed; // ✅ ADDED: Wind speed property
  final Map<String, String> details;

  HourlyForecast({
    required this.time,
    required this.temp,
    required this.icon,
    required this.realFeel,
    required this.precipitation,
    required this.windSpeed, // ✅ ADDED: Wind speed property
    required this.details,
  });
}

class DailyHourlyForecast {
  final String day;
  final List<HourlyForecast> hourlyData;

  DailyHourlyForecast({
    required this.day,
    required this.hourlyData,
  });
}
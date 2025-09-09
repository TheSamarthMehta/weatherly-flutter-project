// lib/models/hourly_model.dart

import 'package:flutter/material.dart';

// ✅ NEW: A base class for any item that can appear in our hourly list.
abstract class TimelineItem {}

class HourlyForecast implements TimelineItem {
  final String time;
  final int hour; // 24-hour format for logical comparisons
  final int temp;
  final IconData icon;
  final String realFeel;
  final int precipitation;
  final int windSpeed;
  final Map<String, dynamic> details;

  HourlyForecast({
    required this.time,
    required this.hour,
    required this.temp,
    required this.icon,
    required this.realFeel,
    required this.precipitation,
    required this.windSpeed,
    required this.details,
  });
}

// ✅ NEW: A specific class to represent sunrise or sunset events.
class SunEvent implements TimelineItem {
  final String time;
  final bool isSunrise;

  SunEvent({required this.time, required this.isSunrise});
}

class DailyHourlyForecast {
  final String day;
  final List<HourlyForecast> hourlyData;
  // ✅ NEW: Added sunrise and sunset times to each daily forecast.
  final String sunriseTime;
  final int sunriseHour; // 24-hour format
  final String sunsetTime;
  final int sunsetHour; // 24-hour format

  DailyHourlyForecast({
    required this.day,
    required this.hourlyData,
    required this.sunriseTime,
    required this.sunriseHour,
    required this.sunsetTime,
    required this.sunsetHour,
  });
}
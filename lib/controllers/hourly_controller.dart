// lib/controllers/hourly_controller.dart

import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter/material.dart';
import '../models/hourly_model.dart';

enum ViewMode { list, graph }
// ✅ ADDED: Enum to manage which graph is currently displayed
enum GraphType { temperature, precipitation, wind }

class HourlyController extends ChangeNotifier {
  ViewMode _viewMode = ViewMode.list;
  ViewMode get viewMode => _viewMode;

  // ✅ ADDED: State for the selected graph type
  GraphType _graphType = GraphType.temperature;
  GraphType get graphType => _graphType;

  void setViewMode(ViewMode mode) {
    _viewMode = mode;
    notifyListeners();
  }

  // ✅ ADDED: Method to change the graph type
  void setGraphType(GraphType type) {
    _graphType = type;
    notifyListeners();
  }

  // ✅ UPDATED: Dummy data now includes precipitation and wind speed values
  final List<DailyHourlyForecast> forecastData = [
    DailyHourlyForecast(
      day: "THURSDAY",
      hourlyData: [
        HourlyForecast(time: "8 PM", temp: 81, icon: PhosphorIcons.cloudMoon(PhosphorIconsStyle.fill), realFeel: "88°", precipitation: 20, windSpeed: 5, details: {}),
        HourlyForecast(time: "9 PM", temp: 80, icon: PhosphorIcons.cloudMoon(PhosphorIconsStyle.fill), realFeel: "88°", precipitation: 25, windSpeed: 7, details: {}),
        HourlyForecast(time: "10 PM", temp: 80, icon: PhosphorIcons.cloud(PhosphorIconsStyle.fill), realFeel: "87°", precipitation: 30, windSpeed: 8, details: {}),
        HourlyForecast(time: "11 PM", temp: 79, icon: PhosphorIcons.cloud(PhosphorIconsStyle.fill), realFeel: "87°", precipitation: 20, windSpeed: 6, details: {}),
      ],
    ),
    DailyHourlyForecast(
      day: "FRIDAY",
      hourlyData: [
        HourlyForecast(time: "12 AM", temp: 79, icon: PhosphorIcons.cloud(PhosphorIconsStyle.fill), realFeel: "87°", precipitation: 16, windSpeed: 5, details: {}),
        HourlyForecast(time: "1 AM", temp: 79, icon: PhosphorIcons.cloudLightning(PhosphorIconsStyle.fill), realFeel: "86°", precipitation: 45, windSpeed: 9, details: {}),
        HourlyForecast(time: "2 AM", temp: 79, icon: PhosphorIcons.cloudLightning(PhosphorIconsStyle.fill), realFeel: "86°", precipitation: 55, windSpeed: 12, details: {}),
        HourlyForecast(time: "3 AM", temp: 79, icon: PhosphorIcons.cloudRain(PhosphorIconsStyle.fill), realFeel: "86°", precipitation: 60, windSpeed: 15, details: {}),
        HourlyForecast(time: "4 AM", temp: 78, icon: PhosphorIcons.cloudRain(PhosphorIconsStyle.fill), realFeel: "86°", precipitation: 40, windSpeed: 13, details: {}),
      ],
    ),
  ];
}
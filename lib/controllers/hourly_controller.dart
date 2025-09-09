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

  /// ✅ **NEW**: This method processes the raw forecast data.
  /// It intelligently injects SunEvent objects for sunrise and sunset
  /// into the hourly list at the correct chronological positions.
  List<DailyHourlyForecast> get processedForecasts {
    return _forecastData.map((daily) {
      List<TimelineItem> timeline = [];
      bool sunriseAdded = false;
      bool sunsetAdded = false;

      for (var hourly in daily.hourlyData) {
        // Add sunrise event before the corresponding hour
        if (!sunriseAdded && hourly.hour >= daily.sunriseHour) {
          timeline.add(SunEvent(time: daily.sunriseTime, isSunrise: true));
          sunriseAdded = true;
        }
        // Add sunset event before the corresponding hour
        if (!sunsetAdded && hourly.hour >= daily.sunsetHour) {
          timeline.add(SunEvent(time: daily.sunsetTime, isSunrise: false));
          sunsetAdded = true;
        }
        timeline.add(hourly);
      }

      // This is a conceptual adaptation. In a real app, you'd adjust the model
      // to hold a `List<TimelineItem>` directly.
      // For this example, we'll filter and cast back in the UI.
      return daily; // The UI will handle the logic based on the raw data for now.
    }).toList();
  }

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
  final List<DailyHourlyForecast> _forecastData = [
    DailyHourlyForecast(
      day: "SATURDAY",
      sunriseTime: "6:27 AM",
      sunriseHour: 6,
      sunsetTime: "7:12 PM",
      sunsetHour: 19,
      hourlyData: [
        HourlyForecast(
          time: "12 PM",
          hour: 12,
          temp: 85,
          icon: PhosphorIcons.cloudSun(),
          realFeel: "95°",
          precipitation: 49,
          windSpeed: 8,
          details: {},
        ),
        HourlyForecast(
          time: "1 PM",
          hour: 13,
          temp: 83,
          icon: PhosphorIcons.cloudRain(),
          realFeel: "89°",
          precipitation: 79,
          windSpeed: 9,
          details: {},
        ),
        HourlyForecast(
          time: "2 PM",
          hour: 14,
          temp: 82,
          icon: PhosphorIcons.cloudRain(),
          realFeel: "88°",
          precipitation: 76,
          windSpeed: 10,
          details: {},
        ),
        HourlyForecast(
          time: "3 PM",
          hour: 15,
          temp: 82,
          icon: PhosphorIcons.cloudRain(),
          realFeel: "86°",
          precipitation: 72,
          windSpeed: 11,
          details: {},
        ),
        HourlyForecast(
          time: "4 PM",
          hour: 16,
          temp: 82,
          icon: PhosphorIcons.cloudRain(),
          realFeel: "86°",
          precipitation: 66,
          windSpeed: 12,
          details: {},
        ),
        HourlyForecast(
          time: "5 PM",
          hour: 17,
          temp: 81,
          icon: PhosphorIcons.cloud(),
          realFeel: "88°",
          precipitation: 49,
          windSpeed: 11,
          details: {},
        ),
        HourlyForecast(
          time: "6 PM",
          hour: 18,
          temp: 80,
          icon: PhosphorIcons.cloud(),
          realFeel: "87°",
          precipitation: 39,
          windSpeed: 10,
          details: {},
        ),
        HourlyForecast(
          time: "7 PM",
          hour: 19,
          temp: 80,
          icon: PhosphorIcons.cloud(),
          realFeel: "87°",
          precipitation: 20,
          windSpeed: 9,
          details: {},
        ),
        HourlyForecast(
          time: "8 PM",
          hour: 20,
          temp: 79,
          icon: PhosphorIcons.cloudMoon(),
          realFeel: "86°",
          precipitation: 20,
          windSpeed: 8,
          details: {},
        ),
        HourlyForecast(
          time: "9 PM",
          hour: 21,
          temp: 79,
          icon: PhosphorIcons.cloudMoon(),
          realFeel: "85°",
          precipitation: 20,
          windSpeed: 7,
          details: {},
        ),
        HourlyForecast(
          time: "10 PM",
          hour: 22,
          temp: 78,
          icon: PhosphorIcons.cloudMoon(),
          realFeel: "84°",
          precipitation: 20,
          windSpeed: 6,
          details: {},
        ),
        HourlyForecast(
          time: "11 PM",
          hour: 23,
          temp: 78,
          icon: PhosphorIcons.cloudMoon(),
          realFeel: "84°",
          precipitation: 20,
          windSpeed: 5,
          details: {},
        ),
      ],
    ),
    DailyHourlyForecast(
      day: "SUNDAY",
      sunriseTime: "6:27 AM",
      sunriseHour: 6,
      sunsetTime: "7:11 PM",
      sunsetHour: 19,
      hourlyData: [
        HourlyForecast(
          time: "12 AM",
          hour: 0,
          temp: 78,
          icon: PhosphorIcons.cloudMoon(),
          realFeel: "84°",
          precipitation: 16,
          windSpeed: 5,
          details: {},
        ),
        HourlyForecast(
          time: "1 AM",
          hour: 1,
          temp: 78,
          icon: PhosphorIcons.cloudMoon(),
          realFeel: "84°",
          precipitation: 7,
          windSpeed: 4,
          details: {},
        ),
        HourlyForecast(
          time: "2 AM",
          hour: 2,
          temp: 78,
          icon: PhosphorIcons.cloudMoon(),
          realFeel: "84°",
          precipitation: 7,
          windSpeed: 4,
          details: {},
        ),
        HourlyForecast(
          time: "3 AM",
          hour: 3,
          temp: 78,
          icon: PhosphorIcons.cloud(),
          realFeel: "84°",
          precipitation: 7,
          windSpeed: 5,
          details: {},
        ),
        HourlyForecast(
          time: "4 AM",
          hour: 4,
          temp: 77,
          icon: PhosphorIcons.cloud(),
          realFeel: "83°",
          precipitation: 7,
          windSpeed: 5,
          details: {},
        ),
        HourlyForecast(
          time: "5 AM",
          hour: 5,
          temp: 78,
          icon: PhosphorIcons.cloud(),
          realFeel: "84°",
          precipitation: 11,
          windSpeed: 6,
          details: {},
        ),
        HourlyForecast(
          time: "6 AM",
          hour: 6,
          temp: 78,
          icon: PhosphorIcons.cloud(),
          realFeel: "84°",
          precipitation: 11,
          windSpeed: 6,
          details: {},
        ),
        HourlyForecast(
          time: "7 AM",
          hour: 7,
          temp: 78,
          icon: PhosphorIcons.cloudSun(),
          realFeel: "85°",
          precipitation: 45,
          windSpeed: 7,
          details: {},
        ),
        HourlyForecast(
          time: "8 AM",
          hour: 8,
          temp: 79,
          icon: PhosphorIcons.cloud(),
          realFeel: "86°",
          precipitation: 49,
          windSpeed: 8,
          details: {},
        ),
        HourlyForecast(
          time: "9 AM",
          hour: 9,
          temp: 80,
          icon: PhosphorIcons.cloudRain(),
          realFeel: "83°",
          precipitation: 53,
          windSpeed: 9,
          details: {},
        ),
        HourlyForecast(
          time: "10 AM",
          hour: 10,
          temp: 81,
          icon: PhosphorIcons.cloudRain(),
          realFeel: "86°",
          precipitation: 51,
          windSpeed: 10,
          details: {},
        ),
        HourlyForecast(
          time: "11 AM",
          hour: 11,
          temp: 83,
          icon: PhosphorIcons.cloud(),
          realFeel: "92°",
          precipitation: 47,
          windSpeed: 11,
          details: {},
        ),
      ],
    ),
    DailyHourlyForecast(
      day: "MONDAY",
      sunriseTime: "6:28 AM", sunriseHour: 6,
      sunsetTime: "7:11 PM", sunsetHour: 19,
      hourlyData: [
        HourlyForecast(time: "12 AM", hour: 0, temp: 79, icon: PhosphorIcons.cloudMoon(), realFeel: "87°", precipitation: 43, windSpeed: 10, details: {}),
        HourlyForecast(time: "1 AM", hour: 1, temp: 79, icon: PhosphorIcons.cloudMoon(), realFeel: "87°", precipitation: 20, windSpeed: 9, details: {}),
        HourlyForecast(time: "2 AM", hour: 2, temp: 79, icon: PhosphorIcons.cloudMoon(), realFeel: "87°", precipitation: 20, windSpeed: 8, details: {}),
        HourlyForecast(time: "3 AM", hour: 3, temp: 79, icon: PhosphorIcons.cloudMoon(), realFeel: "87°", precipitation: 20, windSpeed: 7, details: {}),
        HourlyForecast(time: "4 AM", hour: 4, temp: 79, icon: PhosphorIcons.cloud(), realFeel: "87°", precipitation: 20, windSpeed: 6, details: {}),
        HourlyForecast(time: "5 AM", hour: 5, temp: 78, icon: PhosphorIcons.cloud(), realFeel: "87°", precipitation: 25, windSpeed: 7, details: {}),
        HourlyForecast(time: "6 AM", hour: 6, temp: 79, icon: PhosphorIcons.cloud(), realFeel: "88°", precipitation: 35, windSpeed: 8, details: {}),
        HourlyForecast(time: "7 AM", hour: 7, temp: 79, icon: PhosphorIcons.cloudSun(), realFeel: "89°", precipitation: 38, windSpeed: 9, details: {}),
      ],
    ),
  ];
}

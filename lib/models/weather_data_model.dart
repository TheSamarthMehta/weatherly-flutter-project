// lib/models/weather_data_model.dart

// Represents a single day in the forecast carousel
class Forecast {
  final String day;
  final String icon;
  final String temperature;

  Forecast({required this.day, required this.icon, required this.temperature});
}

// Represents the overall weather data for the screen
class WeatherData {
  final String greeting;
  final String userName;
  final String temperature;
  final String condition;
  final String conditionIconUrl;
  final List<Forecast> forecast;

  WeatherData({
    required this.greeting,
    required this.userName,
    required this.temperature,
    required this.condition,
    required this.conditionIconUrl,
    required this.forecast,
  });
}
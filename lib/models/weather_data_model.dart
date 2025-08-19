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
  final String cityName;
  final double temperature;
  final String mainCondition;
  final String description;
  final String icon;
  final double feelsLike;
  final int humidity;
  final double windSpeed;
  final int sunrise;
  final int sunset;
  final double tempMin;
  final double tempMax;

  WeatherData({
    required this.cityName,
    required this.temperature,
    required this.mainCondition,
    required this.description,
    required this.icon,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
    required this.sunrise,
    required this.sunset,
    required this.tempMin,
    required this.tempMax,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      cityName: json['name'] as String,
      temperature: (json['main']['temp'] as num).toDouble(),
      mainCondition: json['weather'][0]['main'] as String,
      description: json['weather'][0]['description'] as String,
      icon: json['weather'][0]['icon'] as String,
      feelsLike: (json['main']['feels_like'] as num).toDouble(),
      humidity: json['main']['humidity'] as int,
      windSpeed: (json['wind']['speed'] as num).toDouble(),
      sunrise: json['sys']['sunrise'] as int,
      sunset: json['sys']['sunset'] as int,
      tempMin: (json['main']['temp_min'] as num).toDouble(),
      tempMax: (json['main']['temp_max'] as num).toDouble(),
    );
  }
}
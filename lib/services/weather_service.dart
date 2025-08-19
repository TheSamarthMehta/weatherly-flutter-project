// lib/services/weather_service.dart

import 'package:dio/dio.dart';
import '../models/weather_data_model.dart';

class WeatherService {
  final Dio _dio = Dio();
  static const String BASE_URL = 'https://api.openweathermap.org/data/2.5/weather';
  // ❗️ PASTE YOUR API KEY HERE
  final String apiKey = 'd9390340447b4dd4be21f0e973aab7f5';

  Future<WeatherData> getWeather(String cityName) async {
    try {
      final response = await _dio.get(
        BASE_URL,
        queryParameters: {
          'q': cityName,
          'appid': apiKey,
          'units': 'imperial',
        },
      );
      return WeatherData.fromJson(response.data);
    } on DioException catch (e) {
      // Provide a more user-friendly error message
      final errorMessage = e.response?.data['message'] ?? 'Failed to load weather data';
      throw Exception(errorMessage);
    }
  }
}
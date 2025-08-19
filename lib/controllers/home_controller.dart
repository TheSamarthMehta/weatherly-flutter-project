// lib/controllers/home_controller.dart

import 'package:flutter/material.dart';
import '../models/weather_data_model.dart';
import '../services/weather_service.dart';

class HomeController extends ChangeNotifier {
  final PageController pageController = PageController();
  int _selectedIndex = 0;
  bool _isLoading = true;
  WeatherData? _weatherData;
  String? _errorMessage;

  final WeatherService _weatherService = WeatherService();

  int get selectedIndex => _selectedIndex;
  bool get isLoading => _isLoading;
  WeatherData? get weatherData => _weatherData;
  String? get errorMessage => _errorMessage;

  HomeController() {
    fetchWeather("Rajkot"); // Initial fetch for Rajkot
  }

  Future<void> fetchWeather(String cityName) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final data = await _weatherService.getWeather(cityName);
      _weatherData = data;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void changeIndex(int index) {
    _selectedIndex = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    notifyListeners();
  }

  void onPageChanged(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
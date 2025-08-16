// lib/controllers/home_controller.dart

import 'package:flutter/material.dart';
import '../models/weather_data_model.dart';
import '../models/ai_recommendation_model.dart';

class HomeController extends ChangeNotifier {
  // UPDATED: isLoading is now false by default
  bool _isLoading = false;
  // UPDATED: Initialized data directly
  WeatherData? _weatherData = WeatherData(
    greeting: "Good evening,",
    userName: "Alex",
    temperature: "24°",
    condition: "Clear Sky",
    conditionIconUrl: "https://placehold.co/100x100/00000000/FFFFFF?text=☀️",
    forecast: [
      Forecast(day: "Now", icon: "🌙", temperature: "24°"),
      Forecast(day: "10 PM", icon: "☁️", temperature: "23°"),
      Forecast(day: "11 PM", icon: "✨", temperature: "22°"),
      Forecast(day: "Thu", icon: "☀️", temperature: "31°"),
      Forecast(day: "Fri", icon: "⛅️", temperature: "30°"),
      Forecast(day: "Sat", icon: "🌧️", temperature: "28°"),
    ],
  );
  List<AiRecommendation> _recommendations = [
    AiRecommendation(
      category: "Music",
      title: "Starry Night",
      subtitle: "by Chillwave Collective",
      reason: "Perfect for a cozy night under the clear sky.",
      imageUrl: "https://placehold.co/600x800/1E223C/FFFFFF?text=Album+Art.jpg",
    ),
    AiRecommendation(
      category: "Food",
      title: "Masala Chai",
      subtitle: "with Ginger & Cardamom",
      reason: "A warm hug in a mug for this cool evening.",
      imageUrl: "https://placehold.co/600x800/8B4513/FFFFFF?text=Chai.jpg",
    ),
    AiRecommendation(
      category: "Activity",
      title: "Stargazing",
      subtitle: "in your backyard",
      reason: "The sky is clear! Don't miss the constellations.",
      imageUrl: "https://placehold.co/600x800/0C0D1E/FFFFFF?text=Telescope.jpg",
    ),
  ];
  int _selectedIndex = 0;

  bool get isLoading => _isLoading;
  WeatherData? get weatherData => _weatherData;
  List<AiRecommendation> get recommendations => _recommendations;
  int get selectedIndex => _selectedIndex;

  HomeController() {
    // REMOVED: The fetchData() call is no longer needed here
  }

  void changeIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

// REMOVED: The entire fetchData method is no longer needed for this instant UI
}
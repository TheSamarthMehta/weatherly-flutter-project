// lib/views/home_screen.dart

import 'package:flutter/material.dart';
import 'package:weatherly/views/widgets/air_quality_card.dart';
import 'package:weatherly/views/widgets/current_weather_card.dart';
import 'package:weatherly/views/widgets/health_outlook_card.dart';
import 'package:weatherly/views/widgets/seven_day_forecast_card.dart';
import 'package:weatherly/views/widgets/sun_and_moon_card.dart';
import 'package:weatherly/views/widgets/tonights_weather_card.dart';
import 'package:weatherly/views/widgets/ai_suggestion_card.dart';
import 'package:weatherly/views/widgets/weather_radar_card.dart';
import 'package:weatherly/views/widgets/hourly_forecast_card.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ CHANGED: Replaced the CustomScrollView with a simple SingleChildScrollView
    // This removes the extra AppBar from this screen.
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            CurrentWeatherCard(),
            SizedBox(height: 16),
            TonightsWeatherCard(),
            SizedBox(height: 16),
            AiSuggestionCard(),
            SizedBox(height: 16),
            WeatherRadarCard(),
            SizedBox(height: 16),
            HourlyForecastCard(),
            SizedBox(height: 16),
            SevenDayForecastCard(),
            SizedBox(height: 16),
            AirQualityCard(),
            SizedBox(height: 16),
            HealthOutlookCard(),
            SizedBox(height: 16),
            SunAndMoonCard(),
          ],
        ),
      ),
    );
  }
}
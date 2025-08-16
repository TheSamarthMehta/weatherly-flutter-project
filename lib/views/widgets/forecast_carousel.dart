// views/widgets/forecast_carousel.dart

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../models/weather_data_model.dart';
import 'glassmorphic_container.dart';

class ForecastCarousel extends StatelessWidget {
  final List<Forecast> forecasts;
  const ForecastCarousel({super.key, required this.forecasts});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: forecasts.length,
        itemBuilder: (context, index) {
          final forecast = forecasts[index];
          return GlassmorphicContainer(
            margin: const EdgeInsets.only(right: 12),
            width: 75,
            // This padding parameter will now work correctly
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  forecast.day,
                  style: TextStyle(color: Colors.white.withOpacity(0.8), fontWeight: FontWeight.w500),
                ),
                const Spacer(),
                Text(
                  forecast.icon,
                  style: const TextStyle(fontSize: 24),
                ),
                const Spacer(),
                Text(
                  forecast.temperature,
                  style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );
        },
      ).animate().fadeIn(delay: 800.ms).slideX(begin: 0.5),
    );
  }
}

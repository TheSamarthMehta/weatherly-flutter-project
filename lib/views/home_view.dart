// lib/views/home_view.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/home_controller.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:weatherly/views/widgets/current_weather_card.dart';
import 'package:weatherly/views/widgets/tonights_weather_card.dart';
import 'package:weatherly/views/widgets/ai_suggestion_card.dart';
import 'package:weatherly/views/widgets/weather_radar_card.dart';
import 'package:weatherly/views/widgets/hourly_forecast_card.dart';
import 'package:weatherly/views/widgets/seven_day_forecast_card.dart';
import 'package:weatherly/views/widgets/air_quality_card.dart';
import 'package:weatherly/views/widgets/health_outlook_card.dart';
import 'package:weatherly/views/widgets/sun_and_moon_card.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (context, controller, child) {
        if (controller.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage != null) {
          return Center(
              child: Text('Error: ${controller.errorMessage}',
                  style: const TextStyle(color: Colors.red)));
        }

        if (controller.weatherData == null) {
          return const Center(child: Text('No weather data available.'));
        }

        final weather = controller.weatherData!;
        return CustomScrollView(
          slivers: [
            _buildSliverAppBar(),
            _StickyLocationBarDelegate.asSliver(weather.cityName),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        CurrentWeatherCard(weatherData: weather),
                        const SizedBox(height: 16),
                        TonightsWeatherCard(weatherData: weather),
                        const SizedBox(height: 16),
                        AiSuggestionCard(condition: weather.mainCondition),
                        const SizedBox(height: 16),
                        const WeatherRadarCard(),
                        const SizedBox(height: 16),
                        const HourlyForecastCard(),
                        const SizedBox(height: 16),
                        const SevenDayForecastCard(),
                        const SizedBox(height: 16),
                        const AirQualityCard(),
                        const SizedBox(height: 16),
                        const HealthOutlookCard(),
                        const SizedBox(height: 16),
                        SunAndMoonCard(weatherData: weather),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  SliverAppBar _buildSliverAppBar() {
    return SliverAppBar(
      backgroundColor: const Color(0xFF121212),
      pinned: true,
      centerTitle: false,
      title: Row(
        children: [
          Icon(PhosphorIcons.cloud(PhosphorIconsStyle.fill),
              color: const Color(0xFF00C3FF), size: 32),
          const SizedBox(width: 8),
          const Text('Weatherly',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.white)),
        ],
      ),
      actions: [
        IconButton(
            icon: Icon(PhosphorIcons.user(PhosphorIconsStyle.regular),
                color: Colors.white, size: 28),
            onPressed: () {}),
        IconButton(
            icon: Icon(PhosphorIcons.list(PhosphorIconsStyle.regular),
                color: Colors.white, size: 28),
            onPressed: () {}),
      ],
    );
  }
}

class _StickyLocationBarDelegate extends SliverPersistentHeaderDelegate {
  final String cityName;
  _StickyLocationBarDelegate(this.cityName);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(
      child: ColoredBox(
        color: const Color(0xFF121212),
        child: Center(
          child: Container(
            height: 46,
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
              color: const Color(0xFF1B1B1D),
              borderRadius: BorderRadius.circular(30.0),
              border: Border.all(color: Colors.grey[800]!, width: 1),
            ),
            child: Row(
              children: [
                const Icon(Icons.location_on_outlined,
                    color: Colors.white70, size: 20),
                const SizedBox(width: 12),
                Text(cityName,
                    style: const TextStyle(color: Colors.white, fontSize: 16)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 70.0;
  @override
  double get minExtent => 70.0;
  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;

  static SliverPersistentHeader asSliver(String cityName) {
    return SliverPersistentHeader(
        pinned: true, delegate: _StickyLocationBarDelegate(cityName));
  }
}
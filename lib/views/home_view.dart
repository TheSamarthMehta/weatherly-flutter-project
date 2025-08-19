// lib/views/home_view.dart

import 'package:flutter/material.dart';
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

// This widget contains the main scrollable content for the "Home" tab.
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        _buildSliverAppBar(),
        _StickyLocationBarDelegate.asSliver(),
        SliverList(
          delegate: SliverChildListDelegate(
            const [
              Padding(
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
            ],
          ),
        ),
      ],
    );
  }

  SliverAppBar _buildSliverAppBar() {
    return SliverAppBar(
      backgroundColor: const Color(0xFF121212),
      pinned: true,
      centerTitle: false,
      title: Row(
        children: [
          Icon(
            PhosphorIcons.cloud(PhosphorIconsStyle.fill),
            color: const Color(0xFF00C3FF),
            size: 32,
          ),
          const SizedBox(width: 8),
          const Text(
            'Weatherly',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Colors.white,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(
            PhosphorIcons.user(PhosphorIconsStyle.regular),
            color: Colors.white,
            size: 28,
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(
            PhosphorIcons.list(PhosphorIconsStyle.regular),
            color: Colors.white,
            size: 28,
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}

class _StickyLocationBarDelegate extends SliverPersistentHeaderDelegate {
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
            child: const Row(
              children: [
                Icon(Icons.location_on_outlined,
                    color: Colors.white70, size: 20),
                SizedBox(width: 12),
                Text(
                  'Rajkot, Gujarat',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
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
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;

  static SliverPersistentHeader asSliver() {
    return SliverPersistentHeader(
        pinned: true, delegate: _StickyLocationBarDelegate());
  }
}

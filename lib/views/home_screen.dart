// views/home_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../controllers/home_controller.dart';
import 'widgets/custom_bottom_nav_bar.dart';
import 'widgets/current_weather_card.dart';
import 'widgets/tonights_weather_card.dart';
import 'widgets/ai_suggestion_card.dart';
import 'widgets/weather_radar_card.dart';
import 'widgets/hourly_forecast_card.dart';
import 'widgets/seven_day_forecast_card.dart';
import 'widgets/air_quality_card.dart';
import 'widgets/health_outlook_card.dart';
import 'widgets/sun_and_moon_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      bottomNavigationBar: const CustomBottomNavBar(),
      body: Consumer<HomeController>(
        builder: (context, controller, child) {
          return CustomScrollView(
            slivers: [
              // --- Sticky App Bar ---
              SliverAppBar(
                backgroundColor: const Color(0xFF121212),
                pinned: true,
                centerTitle: false,
                title: Row(
                  children: [
                    Icon(
                      PhosphorIcons.cloud(PhosphorIconsStyle.fill), // App logo icon
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
                // ✅ UPDATED: Changed icons to match the screenshot exactly.
                actions: [
                  IconButton(
                    icon: Icon(
                      PhosphorIcons.user(PhosphorIconsStyle.regular), // Thin user icon
                      color: Colors.white,
                      size: 28,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(
                      PhosphorIcons.list(PhosphorIconsStyle.regular), // Thin menu/list icon
                      color: Colors.white,
                      size: 28,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),


              // --- Sticky Location Bar ---
              SliverPersistentHeader(
                pinned: true,
                delegate: _StickyLocationBarDelegate(),
              ),

              // --- Scrollable List of Weather Cards ---
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
        },
      ),
    );
  }
}

// This delegate is correct and does not need changes.
class _StickyLocationBarDelegate extends SliverPersistentHeaderDelegate {
  static const double _barHeight = 70.0;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox(
      height: _barHeight,
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
              mainAxisSize: MainAxisSize.max,
              children: [
                Icon(Icons.location_on_outlined, color: Colors.white70, size: 20),
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
  double get maxExtent => _barHeight;

  @override
  double get minExtent => _barHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}
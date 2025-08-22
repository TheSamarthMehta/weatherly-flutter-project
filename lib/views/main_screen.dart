// lib/views/main_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherly/views/ai_screen.dart';
import 'package:weatherly/views/daily_screen.dart';
import 'package:weatherly/views/home_screen.dart';
import 'package:weatherly/views/hourly_screen.dart';
import 'package:weatherly/views/radar_screen.dart';
import '../controllers/home_controller.dart';
import 'widgets/custom_bottom_nav_bar.dart';
import 'widgets/persistent_header.dart'; // <-- ADD THIS IMPORT

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      // ✅ This AppBar is now persistent across all pages
      appBar: const PersistentHeader(cityName: "Rajkot"),
      bottomNavigationBar: const CustomBottomNavBar(),
      body: Consumer<HomeController>(
        builder: (context, controller, child) {
          return IndexedStack(
            index: controller.selectedIndex,
            children: const <Widget>[
              HomeScreen(),
              HourlyScreen(),
              DailyScreen(),
              RadarScreen(),
              AiScreen(),
            ],
          );
        },
      ),
    );
  }
}
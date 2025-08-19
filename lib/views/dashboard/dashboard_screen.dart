// lib/views/dashboard/dashboard_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weatherly/controllers/home_controller.dart';
import 'package:weatherly/views/ai_screen.dart';
import 'package:weatherly/views/daily_screen.dart';
import 'package:weatherly/views/home_screen.dart';
import 'package:weatherly/views/hourly_screen.dart';
import 'package:weatherly/views/radar_screen.dart';
import 'package:weatherly/views/widgets/custom_bottom_nav_bar.dart';

class DashboardScreen extends GetView<HomeController> {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The bottom navigation bar is now part of this persistent scaffold
      bottomNavigationBar: const CustomBottomNavBar(),
      body: PageView(
        controller: controller.pageController,
        onPageChanged: controller.onPageChanged,
        // The pages are now defined here
        children: const <Widget>[
          HomeScreen(),
          HourlyScreen(),
          DailyScreen(),
          RadarScreen(),
          AiScreen(),
        ],
      ),
    );
  }
}
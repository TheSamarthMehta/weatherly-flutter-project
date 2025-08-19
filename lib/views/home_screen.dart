// lib/views/home_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/home_controller.dart';
import 'widgets/custom_bottom_nav_bar.dart';
import 'home_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<HomeController>(context, listen: false);

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      bottomNavigationBar: const CustomBottomNavBar(),
      body: PageView(
        controller: controller.pageController,
        onPageChanged: controller.onPageChanged,
        children: const <Widget>[
          HomeView(), // This correctly points to your home content
          Center(child: Text('Hourly View', style: TextStyle(color: Colors.white))),
          Center(child: Text('Daily View', style: TextStyle(color: Colors.white))),
          Center(child: Text('Radar View', style: TextStyle(color: Colors.white))),
          Center(child: Text('AI View', style: TextStyle(color: Colors.white))),
        ],
      ),
    );
  }
}
// lib/views/widgets/custom_bottom_nav_bar.dart

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../controllers/home_controller.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final navItems = [
      {"icon": PhosphorIcons.house(), "selectedIcon": PhosphorIcons.house(PhosphorIconsStyle.fill), "label": "Home"},
      {"icon": PhosphorIcons.clock(), "selectedIcon": PhosphorIcons.clock(PhosphorIconsStyle.fill), "label": "Hourly"},
      {"icon": PhosphorIcons.calendar(), "selectedIcon": PhosphorIcons.calendar(PhosphorIconsStyle.fill), "label": "Daily"},
      {"icon": PhosphorIcons.mapPin(), "selectedIcon": PhosphorIcons.mapPin(PhosphorIconsStyle.fill), "label": "Radar"},
      {"icon": PhosphorIcons.sparkle(), "selectedIcon": PhosphorIcons.sparkle(PhosphorIconsStyle.fill), "label": "AI"},
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            height: 80.0,
            decoration: BoxDecoration(
              color: const Color(0xFF2A2D31).withOpacity(0.5),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.2)),
            ),
            // Use a Consumer to listen for changes from HomeController.
            child: Consumer<HomeController>(
              builder: (context, controller, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(navItems.length, (index) {
                    return _buildNavItem(
                      context,
                      controller,
                      navItems[index]["icon"] as IconData,
                      navItems[index]["selectedIcon"] as IconData,
                      index,
                      navItems[index]["label"] as String,
                    );
                  }),
                );
              },
            ),
          ),
        ),
      ),
    ).animate().fadeIn(delay: 800.ms).slideY(begin: 1, curve: Curves.easeOut);
  }

  Widget _buildNavItem(BuildContext context, HomeController controller, IconData icon, IconData selectedIcon, int index, String label) {
    // ✅ FIX: Removed the '.value' which is not part of the Provider package.
    final bool isSelected = controller.selectedIndex == index;

    return Expanded(
      child: InkWell(
        onTap: () => controller.changeIndex(index),
        borderRadius: BorderRadius.circular(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: isSelected
                    ? Border.all(color: Colors.white.withOpacity(0.4), width: 1.0)
                    : null,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                isSelected ? selectedIcon : icon,
                size: 26,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            AnimatedOpacity(
              opacity: isSelected ? 1.0 : 0.7,
              duration: const Duration(milliseconds: 200),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

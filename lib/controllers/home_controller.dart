// lib/controllers/home_controller.dart

import 'package:flutter/material.dart';

// ✅ FIX: Reverted back to ChangeNotifier for use with the Provider package.
class HomeController extends ChangeNotifier {
  final PageController pageController = PageController();
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void changeIndex(int index) {
    _selectedIndex = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    // ✅ FIX: Use notifyListeners() to update widgets listening via Provider.
    notifyListeners();
  }

  void onPageChanged(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}

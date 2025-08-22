// lib/routing/app_routes.dart

import 'package:flutter/material.dart';
import 'package:weatherly/views/main_screen.dart';

class AppRoutes {
  static const String main = '/';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case main:
        return MaterialPageRoute(builder: (_) => const MainScreen());
      default:
      // Optional: A 404/error page
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
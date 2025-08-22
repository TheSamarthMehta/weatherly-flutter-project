// lib/main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherly/routing/app_routes.dart'; // <-- UPDATE THIS IMPORT
import 'controllers/home_controller.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => HomeController(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weatherly',
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: const Color(0xFF0C0D1E),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.main, // <-- UPDATE THIS LINE
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}
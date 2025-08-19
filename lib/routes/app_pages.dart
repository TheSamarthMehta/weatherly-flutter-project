// lib/routes/app_pages.dart

import 'package:get/get.dart';
import 'package:weatherly/views/dashboard/dashboard_binding.dart';
import '../views/dashboard/dashboard_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.DASHBOARD,
      page: () => const DashboardScreen(),
      binding: DashboardBinding(),
    ),
  ];
}
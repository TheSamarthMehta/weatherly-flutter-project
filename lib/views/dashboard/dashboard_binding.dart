// lib/views/dashboard/dashboard_binding.dart

import 'package:get/get.dart';
import 'package:weatherly/controllers/home_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    // Initialize your HomeController here for the entire dashboard
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
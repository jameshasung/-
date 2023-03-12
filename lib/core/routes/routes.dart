import 'package:flutter/material.dart';
import 'package:task_management/pages/home.dart';
import 'package:task_management/pages/onboarding.dart';
import 'package:task_management/pages/mypage.dart';
import 'package:task_management/pages/upload.dart';

class Routes {
  static const onBoarding = "/";
  static const home = "/home";
  static const todaysTask = "/task/todays";
  static const mission = "/mission";
}

class RouterGenerator {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case Routes.onBoarding:
        return MaterialPageRoute(
          builder: ((context) => const OnboardingScreen()),
        );
      case Routes.home:
        return MaterialPageRoute(
          builder: ((context) => const HomeScreen()),
        );
      case Routes.todaysTask:
        return MaterialPageRoute(
          builder: ((context) => const MypageScreen()),
        );
      case Routes.mission:
        return MaterialPageRoute(
          builder: ((context) => const UploadPage()),
        );
      default:
        return MaterialPageRoute(
          builder: ((context) => const HomeScreen()),
        );
    }
  }
}

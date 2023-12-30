import 'package:flutter/material.dart';
import 'package:goodspace_task/core/navigation_menu.dart';
import 'package:goodspace_task/presentation/screens/home_screen.dart';
import 'package:goodspace_task/presentation/screens/login_screen.dart';
import 'package:goodspace_task/presentation/screens/otp_screen.dart';
import 'package:goodspace_task/presentation/screens/splash_screen.dart';

class Routes {
  static const String splash = '/';
  static const String login = '/login';
  static const String otp = '/otp';
  static const String home = '/home';
  static const String navigationMenu = '/navigation_menu';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case otp:
        final Map<String, dynamic>? args = settings.arguments as Map<String, dynamic>?;

        // Accessing phone number and country code
        final String phoneNumber = args?['phoneNumber'] ?? '';
        return MaterialPageRoute(builder: (_) => OTPScreen(phoneNumber: phoneNumber,));
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case navigationMenu:
        return MaterialPageRoute(builder: (_) => const NavigationMenu());
      default:
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

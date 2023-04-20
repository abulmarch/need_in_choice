import 'package:flutter/material.dart';
import 'package:need_in_choice/config/routes/route_names.dart';
import 'package:need_in_choice/views/pages/login/details_screen.dart';
import 'package:need_in_choice/views/pages/login/splash_screen.dart';

import '../../views/pages/login/signup_screen.dart';

class PageRoutes {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case splashScreen:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const SpalshScreen(),
        );

      case signUpScreen:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const SignUpScreen(),
        );

      case detailScreen:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const DetailsScreen(),
        );
      default:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const Scaffold(
            body: Center(
              child: Text(
                'error! no routes',
              ),
            ),
          ),
        );
    }
  }
}

import 'package:flutter/material.dart';
import 'package:need_in_choice/config/routes/route_names.dart';
import 'package:need_in_choice/views/pages/account/account_screen.dart';
import 'package:need_in_choice/views/pages/login/details_screen.dart';
import 'package:need_in_choice/views/pages/login/splash_screen.dart';

import '../../views/pages/collect_ad_details/collect_ad_details.dart';
import '../../views/pages/home_page/main_navigation_page.dart';
import '../../views/pages/login/signup_screen.dart';

class PageRoutes {
  static Route<dynamic>? generateRoute(RouteSettings routeSettings) {
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
      case mainNavigationScreen:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const MainNavigationScreen(selectIndex: 0),
        );
      case collectAdDetails:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const CollectAdDetails(),
        );
      case accountScreen:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const AccountScreen(),
        );
      default:
        return null;
    }
  }
}

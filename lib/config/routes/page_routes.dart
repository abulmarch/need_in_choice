import 'package:flutter/material.dart';
import 'package:need_in_choice/config/routes/route_names.dart';
import 'package:need_in_choice/views/pages/account/account_screen.dart';
import 'package:need_in_choice/views/pages/ad_finalisation/ad_confirm_screen.dart';
import 'package:need_in_choice/views/pages/login/details_screen.dart';
import 'package:need_in_choice/views/pages/login/splash_screen.dart';

import '../../views/pages/ad_detail/ad_detail_screen.dart';
import '../../views/pages/ad_finalisation/ad_preview_screen.dart';
import '../../views/pages/ad_finalisation/confirm_lottie.dart';
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
        case adDetailScreen:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const AdDetailScreen(),
        );
      case adConfirmScreen:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const AdConfirmScreen(),
        );
      case adPreviwScreen:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const AdPreviewScreen(),
        );
      case confirmLottieScreen:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const ConfirmLottieScreen(),
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

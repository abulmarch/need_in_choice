import 'package:flutter/material.dart';
import 'package:need_in_choice/config/routes/route_names.dart';
import 'package:need_in_choice/views/pages/account/account_screen.dart';
import 'package:need_in_choice/views/pages/ad_finalisation/ad_confirm_screen.dart';
import 'package:need_in_choice/views/pages/login/details_screen.dart';

import '../../views/pages/ad_detail/ad_detail_screen.dart';
import '../../views/pages/ad_finalisation/ad_preview_screen.dart';
import '../../views/pages/ad_finalisation/confirm_lottie.dart';
import '../../views/pages/login/splash_screen.dart';
import '../../views/pages/real_estate/agency/realestate_agency.dart';
import '../../views/pages/real_estate/agent/realestate_agent.dart';
import '../../views/pages/real_estate/building_rent/apartment_rent.dart';
import '../../views/pages/real_estate/building_rent/commercial_building_rent.dart';
import '../../views/pages/real_estate/building_rent/house_villa_rent.dart';
import '../../views/pages/real_estate/building_sale/apartment_flat_sale.dart';
import '../../views/pages/real_estate/building_sale/commercial_building_sale.dart';
import '../../views/pages/home_page/main_navigation_page.dart';
import '../../views/pages/login/signup_screen.dart';
import '../../views/pages/real_estate/building_sale/e_auction_property.dart';
import '../../views/pages/real_estate/building_sale/housevilla_sale.dart';
import '../../views/pages/real_estate/building_sale/pending_projects.dart';
import '../../views/pages/real_estate/land_rent/land_for_rent_screen.dart';
import '../../views/pages/real_estate/land_sale/e_auction_land.dart';
import '../../views/pages/real_estate/land_sale/land_for_sale_screen.dart';

class PageRoutes {
  static Route<dynamic>? generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case splashScreen:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const SplashScreen(),
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
          builder: (_) => const MainNavigationScreen(),
        );
      case collectAdDetails:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const CommercialBuildingForSale(),
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
        //------------------------------------------------- LEVEL 2 Category
      case landForRentRoot:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const LandForRentScreen(),
        );
      case realestateAgencyRoot:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const RealEstateAgencyScreen(),
        );
      case realestateAgentRoot:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const RealEstateAgentScreen(),
        );
        //------------------------------------------------- LEVEL 3 Category
      case commercialBuildingForSaleRoot:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const CommercialBuildingForSale(),
        );
      case houseAndVillaForSaleRoot:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const HouseVillaSaleScreen(),
        );
      case appartmentAndFlatForSaleRoot:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const ApartmentSaleScreen(),
        );
      case pendingProjectForSaleRoot:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const PendingProjectScreen(),
        );
      case eAuctionProjectForSaleRoot:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const EAuctionProperty(),
        );

      case commercialBuildingForRentRoot:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const CommercialBuildingForRent(),
        );
      case houseAndVillaForRentRoot:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const HouseVillaRentScreen(),
        );
      case appartmentAndFlatForRentRoot:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const ApartmentRentScreen(),
        );
      
      case landForSaleRoot:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const LandForSaleScreen(),
        );
      case eAuctionLandForSaleRoot:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const EAuctionLandScreen(),
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

import 'package:flutter/material.dart';

import '../screens/drawer/about.dart';
import '../screens/drawer/about_nasa.dart';
import '../screens/drawer/galaxy_screen.dart';
import '../screens/drawer/sun_and_moon.dart';
import '../screens/main/home_screen.dart';
import '../screens/main/planet_detailed_screen.dart';
import '../screens/drawer/rocket_history.dart';
import '../screens/drawer/space_station_view.dart';

// lib/core/routes/app_routes.dart
class AppRoutes {
  static const String home = '/';
  static const String planetDetail = '/planet-detail';
  static const String galaxy = '/galaxy';
  static const String sunAndMoon = '/sun&moon';
  static const String spaceStations = '/space-stations';
  static const String rocketHistory = '/rocket-history';
  static const String aboutNasa = '/about-nasa';
  static const String about = '/about';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case planetDetail:
        return MaterialPageRoute(builder: (_) => const PlanetDetailScreen());
      case galaxy:
        return MaterialPageRoute(builder: (_) => const GalaxyScreen());
      case sunAndMoon:
        return MaterialPageRoute(builder: (_) => const SunAndMoonScreen());
      case spaceStations:
        return MaterialPageRoute(builder: (_) => const SpaceStationsScreen());
      case rocketHistory:
        return MaterialPageRoute(builder: (_) => const RocketHistoryScreen());
      case aboutNasa:
        return MaterialPageRoute(builder: (_) => const AboutNasaScreen());
      case about:
        return MaterialPageRoute(builder: (_) => const AboutScreen());
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
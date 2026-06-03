import 'package:flutter/material.dart';
import '../model/solar_region.dart';
import '../ui/screens/splash_screen.dart';
import '../ui/screens/intro_screen.dart';
import '../ui/screens/home_screen.dart';
import '../ui/screens/analysis_screen.dart';
import '../ui/screens/simulator_screen.dart';
import '../ui/screens/monitor_screen.dart';
import 'app_routes.dart';

class AppNavigation {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );

      case AppRoutes.intro:
        return MaterialPageRoute(
          builder: (_) => const IntroScreen(),
        );

      case AppRoutes.home:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );

      case AppRoutes.analysis:
        final region = settings.arguments as SolarRegion;
        return MaterialPageRoute(
          builder: (context) => AnalysisScreen(region: region),
        );

      case AppRoutes.simulator:
        final region = settings.arguments as SolarRegion?;
        return MaterialPageRoute(
          builder: (context) => SimulatorScreen(region: region),
        );

      case AppRoutes.monitor:
        return MaterialPageRoute(
          builder: (_) => const MonitorScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Rota não encontrada')),
          ),
        );
    }
  }
}

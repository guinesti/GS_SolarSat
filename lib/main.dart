import 'package:flutter/material.dart';
import 'navigation/app_routes.dart';
import 'navigation/app_navigation.dart';

void main() {
  runApp(const SolarSatApp());
}

class SolarSatApp extends StatelessWidget {
  const SolarSatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SolarSat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFFF5A623),
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFFF5A623),
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.system,
      initialRoute: AppRoutes.splash,
      onGenerateRoute: AppNavigation.generateRoute,
    );
  }
}

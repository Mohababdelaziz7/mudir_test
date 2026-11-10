import 'package:flutter/material.dart';

import '../../features/navigation/presentation/screens/main_nav_screen.dart';

class AppRouter {
  AppRouter._();

  static const String initialRoute = '/';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initialRoute:
        return MaterialPageRoute(builder: (_) => const MainNavScreen());
      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Route not found'))),
        );
    }
  }
}

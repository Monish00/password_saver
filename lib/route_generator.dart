import 'package:flutter/material.dart';

import 'pages/HomePage.dart';
import 'pages/LoginPage.dart';
import 'pages/SingnupPage.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/home':
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
        );
      case '/login':
        return MaterialPageRoute(
          builder: (_) => const SignIn(),
        );
      case '/signUp':
        return MaterialPageRoute(
          builder: (_) => const SignUp(),
        );
      default:
        return MaterialPageRoute(builder: (_) => const SignIn());
    }
  }
}

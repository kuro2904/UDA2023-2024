import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:food_app/screens/admin/main_page.dart';
import 'package:food_app/screens/android/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _getHome(),
      routes: _getRoutes(),
    );
  }

  Widget _getHome() {
    if (kIsWeb) {
      return const MyAdmin();
    } else {
      return const HomePage();
    }
  }

  Map<String, WidgetBuilder> _getRoutes() {
    if (kIsWeb) {
      return {
        '/admin': (context) => const MyAdmin(),
      };
    } else {
      return {
        '/home': (context) => const HomePage(),
      };
    }
  }
}



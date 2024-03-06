import 'dart:js';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_app/screens/admin/login_page.dart';
import 'package:food_app/screens/admin/main_page.dart';
import 'package:food_app/screens/admin/register_admin.dart';
import 'package:food_app/screens/android/home.dart';
import 'package:food_app/screens/android/login.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    return MaterialApp(
      home: _getHome(),
    );
  }

  Widget _getHome() {
    if (kIsWeb) {
      return const AdminLogin();
    } else {
      return const HomePage();
    }
  }


}



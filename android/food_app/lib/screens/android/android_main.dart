import 'package:flutter/material.dart';
import 'package:food_app/screens/android/home.dart';
import 'package:food_app/screens/android/user_options.dart';

import 'cart_page.dart';

class AndroidMain extends StatefulWidget {
  const AndroidMain({super.key});

  @override
  State<AndroidMain> createState() => AndroidMainState();
}

class AndroidMainState extends State<AndroidMain> {
  int _selectedIndex = 0;

  final List<Widget> screens = const [HomePage(), CartPage(), UserOptions()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'User'),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}

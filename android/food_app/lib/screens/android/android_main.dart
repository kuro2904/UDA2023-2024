import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_app/screens/android/home.dart';
import 'package:food_app/screens/android/login.dart';

import 'cart_page.dart';

class AndroidMain extends StatefulWidget{
  const AndroidMain({super.key});

  @override
  State<StatefulWidget> createState()=> AndroidMainState();

}

class AndroidMainState extends State<AndroidMain>{
  int _selectedIndex = 0;
  List<Widget> screens = [const HomePage(), const CartPage()];
  Widget currentPage = const HomePage();
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      currentPage = screens[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentPage,
      bottomNavigationBar: BottomNavigationBar(items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),label: 'Cart'),
      ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      )
    );
  }
}

import 'package:flutter/material.dart';
import 'package:food_app/screens/android/home.dart';
import 'package:food_app/screens/android/login.dart';
import 'package:food_app/screens/android/signup.dart';
import 'package:food_app/screens/android/user_options.dart';
import '../../data/client_state.dart';
import 'cart_page.dart';
import 'home_components/expandable_FloatingActionButton.dart';

class AndroidMain extends StatefulWidget{
  const AndroidMain({super.key});

  @override
  State<StatefulWidget> createState()=> AndroidMainState();

}

class AndroidMainState extends State<AndroidMain>{
  int _selectedIndex = 0;

  List<Widget> screens = [const HomePage(), CartPage(orderDetails: ClientState().cart,), const UserOptions()];
  Widget currentPage = const HomePage();
  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      currentPage = screens[index];
    });
  }

  void setFragment(Widget widget) {
    setState(() {
      _selectedIndex = 0;
      currentPage = widget;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentPage,
      // resizeToAvoidBottomInset: false,
      bottomNavigationBar: BottomNavigationBar(items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),label: 'Cart'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'User'),
      ],
        currentIndex: _selectedIndex,
        onTap: onItemTapped,
      ),
    );
  }
}

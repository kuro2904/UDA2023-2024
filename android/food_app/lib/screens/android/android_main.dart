import 'package:flutter/material.dart';
import 'package:food_app/screens/android/home.dart';
import 'package:food_app/screens/android/login.dart';
import 'package:food_app/screens/android/signup.dart';
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
  List<Widget> screens = [const HomePage(), CartPage(orderDetails: ClientState().cart,)];
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
      ),
      floatingActionButton: ClientState().isLogin ? null : ExpandableFab(
        initialOpen: false,
        distance: 10,
        icon: const Icon(Icons.menu),
        children: [
          ElevatedButton(
            // Just for testing
            onPressed: () async {
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LoginPage()
                  )
              ); // Đến login screen
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const AndroidMain())
              );
            },
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
            ),
            child: const Icon(Icons.login),
          ),
          ElevatedButton(
            // Just for testing
            onPressed: () async {
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SignUpPage()
                  )
              );
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const AndroidMain())
              );
            },
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
            ),
            child: const Icon(Icons.app_registration),
          ),
        ],
      ),
    );
  }
}

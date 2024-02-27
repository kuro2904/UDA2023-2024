import 'package:flutter/material.dart';
import 'package:food_app/data/category.dart';
import 'package:food_app/screens/home_components/category_menu.dart';
import 'package:food_app/screens/home_components/expandable_FloatingActionButton.dart';
import 'package:food_app/screens/login.dart';

import 'home_components/category_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();
  int _selectedIndex = 0;


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food App', style: TextStyle(color: Colors.red,fontSize: 30),),
      ),
      drawer: Drawer(
        child:ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Home'),
              selected: _selectedIndex == 0,
              onTap: () {
                _onItemTapped(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Account'),
              selected: _selectedIndex == 1,
              onTap: () {
                _onItemTapped(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('About'),
              selected: _selectedIndex == 2,
              onTap: () {
                _onItemTapped(2);
                Navigator.pop(context);
              },
            ),
            const Expanded(child: Divider()),
            ListTile(
              title: const Text('Log out'),
              selected: _selectedIndex == 3,
              onTap: (){
                _onItemTapped(3);
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        hintText: 'Search..',
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: MaterialButton(
                      onPressed: () {},
                      elevation: 0,
                      color: Colors.lightBlue,
                      height: 60,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child:
                          const Icon(Icons.manage_search, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: const Text('Category',
                      style: TextStyle(
                          color: Colors.indigo,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                )),
            Center(
              child: CategoryMenu(
                children: [ // TODO: danh sách category ở đây
                  CategoryItem(
                    category: Category(
                      name: "test 1",
                      imageUrl: "https://as2.ftcdn.net/v2/jpg/00/90/40/41/1000_F_90404161_XTapeqhGy6B9VWK8x24Dwq53UaNQgar3.jpg",
                    ),
                  ),
                  CategoryItem(
                    category: Category(
                        name: "Test 2",
                        imageUrl: "https://as1.ftcdn.net/v2/jpg/01/80/31/64/1000_F_180316434_mY7TCf3Yp1MqMCJ0fOITXYLpATSHPQI1.jpg"
                    ),
                  ),
                ],
              ),
            ),
            // Container(
            //   height: 200,
            //   child: ListView.builder(itemBuilder: (context, index){
            //     return CategoryItem(category: categories[index]);
            //   },itemCount: categories == null ? 0: categories.length,)
            // )
          ],
        ),
      ),
      floatingActionButton: ExpandableFab(
        initialOpen: false,
        distance: 10,
        icon: const Icon(Icons.menu),
        children: [
          // TODO: hiển thị nút đăng nhập và đăng ký nếu người dùng chưa đăng nhập và nut trang cá nhân nếu ngừoi dùng đã đăng nhập
          ElevatedButton(
            // Just for testing
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const LoginPage())); // Đến login screen
            },
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
            ),
            child: const Icon(Icons.login),
          ),
        ],
      ),
    );
  }
}

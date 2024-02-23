import 'package:flutter/material.dart';
import 'package:food_app/screens/home_components/expandable_FloatingActionButton.dart';
import 'package:food_app/screens/login.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});


  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
        child: Column(
          children: [
            const Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Welcome'),
                    Text(
                      'Food App',
                      style: TextStyle(color: Colors.red, fontSize: 30),
                    )
                  ],
                ),
              ],
            ),
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
        children: [ // TODO: hiển thị nút đăng nhập và đăng ký nếu người dùng chưa đăng nhập và nut trang cá nhân nếu ngừoi dùng đã đăng nhập
          ElevatedButton( // Just for testing
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage())); // Đến login screen
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

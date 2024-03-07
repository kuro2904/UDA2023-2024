import 'package:flutter/material.dart';
import 'package:food_app/data/client_state.dart';
import 'package:food_app/screens/android/signup.dart';

import 'home_components/category_item.dart';
import 'home_components/category_menu.dart';
import 'home_components/expandable_FloatingActionButton.dart';
import 'login.dart';

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
      appBar: AppBar(
        title: const Text('Food App', style: TextStyle(color: Colors.red,fontSize: 30),),
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
            // Container(
            //   height: 200,
            //   child: ListView.builder(itemBuilder: (context, index){
            //     return CategoryItem(category: categories[index]);
            //   },itemCount: categories == null ? 0: categories.length,)
            // )
            FutureBuilder(
              future: ClientState().getAllCategories(),
              builder: (context, snapshot) {
                if (snapshot.hasData == false) {
                  return const Text("No Data");
                }
                return CategoryMenu(children: snapshot.data!.map((e) {
                  return CategoryItem(category: e);
                }).toList());
              },
            ),
          ],
        ),
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
                MaterialPageRoute(builder: (context) => const HomePage())
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
                  MaterialPageRoute(builder: (context) => const HomePage())
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

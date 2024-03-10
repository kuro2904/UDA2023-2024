import 'package:flutter/material.dart';
import 'package:food_app/data/client_state.dart';
import 'package:food_app/screens/android/category_product.dart';
import 'package:food_app/utils/dialog.dart';
import 'home_components/category_item.dart';
import 'home_components/wrap_list_menu.dart';

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
    return Material(
      child: Padding(
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
                return WrapListMenu(children: snapshot.data!.map((e) {
                  return CategoryItem(
                    category: e,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategoryProductPage(categoryID: e.id)
                        ),
                      );
                    },
                  );
                }).toList());
              },
            ),
          ],
        ),
      ),
    );
  }
}

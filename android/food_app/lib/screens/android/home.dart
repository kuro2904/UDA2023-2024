import 'package:flutter/material.dart';
import 'package:food_app/screens/android/home_components/product_item.dart';
import '../../data/category.dart';
import '../../data/product.dart';
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
  late Future<List<Product>> futureProducts;
  late Future<List<Category>> futureCategory;

  @override
  void initState() {
    super.initState();
    futureProducts = Product.fetchAll();
    futureCategory = Category.fetchAll();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text('Food app'),
                background: Container(
                  // Customize your search bar background here
                  color: Colors.blue,
                ),
              ),
            ),
          ];
        },
        body: Column(
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
                ),
            ),
            FutureBuilder(
              future: futureCategory,
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting){
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasData == false) {
                  return const Text("No Data");
                }
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: snapshot.data!.map((e) {
                      return CategoryItem(
                        category: e,
                        backgroundColor: Colors.white,
                        textColor: Colors.black,
                        onTap: () {
                          setState(() {
                            futureProducts = Category.fetchProduct(e.id);
                          });
                        },
                      );
                    }).toList(),
                  ),
                );
              },
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: const Text('Products',
                      style: TextStyle(
                          color: Colors.indigo,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                ),
            ),
            Expanded(
              child: FutureBuilder(
                future: futureProducts,
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasData == false) {
                    return const Text("No Data");
                  }
                  return WrapListMenu(
                    scrollDirection: Axis.vertical,
                    children: snapshot.data!.map((e) {
                      return ProductItem(
                        product: e,
                        backgroundColor: Colors.white,
                        textColor: Colors.black,
                        onTap: (){
                          // TODO: form chọn
                        },
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

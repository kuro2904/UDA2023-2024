import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/constants/backend_config.dart';
import 'package:food_app/data/client_state.dart';
import 'package:food_app/screens/android/category_product.dart';
import 'package:food_app/screens/android/home_components/product_item.dart';
import '../../data/product.dart';
import 'home_components/category_item.dart';
import 'home_components/wrap_list_menu.dart';
import 'package:http/http.dart' as http;

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

  @override
  void initState() {
    super.initState();
    futureProducts = fetchProducts();
  }

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
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: const Text('Products',
                      style: TextStyle(
                          color: Colors.indigo,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                )),
            Expanded(
              child: FutureBuilder(future: futureProducts, builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting){
                  return const Center(child: CircularProgressIndicator());
                }else if( snapshot.hasError){
                  return Text('Error: ${snapshot.error}');
                }else if (snapshot.hasData && snapshot.data != null) {
                  return GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),itemCount: snapshot.data!.length, itemBuilder: (context, index){
                    return Padding(padding: const EdgeInsets.all(8.0), child: ProductItem(product: snapshot.data![index],onTap: (){},),);
                  });
                } else {
                  return const Center(child: Text('No data available'));
                }
              }),
            )
          ],
        ),
      ),
    );
  }
}

List<Product> parseProducts(String responseBody){
  final parser = json.decode(responseBody).cast<Map<String,dynamic>>();
  return parser.map<Product>((json) => Product.fromJson(json)).toList();
}


Future<List<Product>> fetchProducts() async {
  Uri url = Uri.parse(BackEndConfig.fetchAllProductString);
  final response = await http.get(url);
  if(response.statusCode == 200){
    return parseProducts(response.body);
  }else{
    throw Exception('Unable to fetch all Products');
  }
}
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:food_app/constants/backend_config.dart';
import 'package:food_app/data/category.dart';
import 'package:food_app/data/client_state.dart';
import 'package:food_app/data/product.dart';
import 'package:food_app/screens/android/DetailProduct.dart';
import 'package:food_app/screens/android/home_components/category_item.dart';
import 'package:food_app/screens/android/home_components/product_item.dart';
import 'package:http/http.dart' as http;

import '../../data/OrderDetail.dart';

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
    futureProducts = fetchProducts();
    futureCategory = ClientState().getAllCategories();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'Food App',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                    fontSize: 30,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: searchController,
                decoration:  InputDecoration(
                  hintText: 'Search...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Categories',
                  style: TextStyle(
                    color: Colors.indigo,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 150,
                child: FutureBuilder(
                  future: futureCategory,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasData == false) {
                      return const Text("No Data");
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0), // Add space between items
                            child: CategoryItem(
                              category: snapshot.data![index],
                              onTap: () {
                                futureProducts = ClientState()
                                    .getProductByCategory(snapshot.data![index].id);
                                setState(() {}); // Call setState here
                              },
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 24, 16, 16),
                child: Text(
                  'Products',
                  style: TextStyle(
                    color: Colors.indigo,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              FutureBuilder(
                future: futureProducts,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData && snapshot.data != null) {
                    return GridView.count(
                      crossAxisCount: 2,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      shrinkWrap: true, // Add this
                      physics: const NeverScrollableScrollPhysics(), // Add this
                      children: snapshot.data!.map<Widget>((e) {
                        return ProductItem(
                          product: e,
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DetailProduct(context: context ,product: e))),
                        );
                      }).toList(),
                    );
                  } else {
                    return const Center(child: Text('No data available'));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<Product> parseProducts(String responseBody) {
  final parser = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parser.map<Product>((json) => Product.fromJson(json)).toList();
}

Future<List<Product>> fetchProducts() async {
  final response =
  await http.get(Uri.parse(BackEndConfig.fetchAllProductString));
  if (response.statusCode == 200) {
    return parseProducts(response.body);
  } else {
    throw Exception('Unable to fetch all Products');
  }
}

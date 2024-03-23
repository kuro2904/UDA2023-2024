import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/constants/backend_config.dart';
import 'package:food_app/screens/admin/category_management/add_update_category.dart';
import 'package:http/http.dart' as http;

import '../../../data/category.dart';
import 'category_box_list.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<StatefulWidget> createState() => CategoryManagementState();
}

class CategoryManagementState extends State<CategoryPage> {

  late Future<List<Category>> _futureCategories;

  @override
  void initState() {
    super.initState();
    _futureCategories = fetchAllCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Category',
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'All Category',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const AddOrUpdateCategoryPage()));
                    },
                    style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue)),
                    child: const Text(
                      'Add new',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                )
              ],
            ),
            FutureBuilder(
              future: _futureCategories,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData && snapshot.data != null) {
                  return CategoryBoxList(snapshot.data??[]);
                } else {
                  return const Center(child: Text('No data available'));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

List<Category> parseCategories(String responseBody){
  final parser = json.decode(responseBody).cast<Map<String, dynamic>>();
  print(responseBody);
  return parser.map<Category>((json) => Category.fromJson(json)).toList();
}

Future<List<Category>> fetchAllCategories() async{
  final response = await http.get(Uri.parse(BackEndConfig.fetchAllCategoryString));
  if(response.statusCode == 200){
    return parseCategories(response.body);
  }
  else{
    throw Exception('Unable to fetch all Category');
  }
}
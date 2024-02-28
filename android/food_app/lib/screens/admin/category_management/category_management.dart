import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../constants/api_link_constants.dart';
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
    _futureCategories = fectAllCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Category',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const Row(
              children: [
                Expanded(
                    child: Text(
                  'All Category',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                )),
              ],
            ),
           FutureBuilder(future: _futureCategories, builder: (context, snapshot){
             if(snapshot.hasError) print(snapshot.error);
             return snapshot.hasData ? CategoryBoxList(snapshot.data!) : const Center(child: CircularProgressIndicator(),);
           })
          ],
        ),
      ),
    );
  }
}

List<Category> parseCategories(String responseBody){
  final parser = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parser.map<Category>((json) => Category.fromJson(json)).toList();
}

Future<List<Category>> fectAllCategories() async{
  final response = await http.get(Uri.parse(LinkConstants.linkFetchAllCategory));
  if(response.statusCode == 200){
    return parseCategories(response.body);
  }
  else{
    throw Exception('Unable to fetch all Category');
  }
}
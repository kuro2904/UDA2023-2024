import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'category_management/category_management.dart';
import 'dashboard_page.dart';

void main() => runApp(const MyAdmin());

class MyAdmin extends StatelessWidget{
  const MyAdmin({super.key});

  @override
  Widget build(BuildContext context) {
   return MaterialApp(
     debugShowCheckedModeBanner: false,
     theme: ThemeData(),
     home: const CategoryPage(),
   );
  }

}
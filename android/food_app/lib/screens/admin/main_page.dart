import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/screens/admin/product_management/product_management_page.dart';

void main() => runApp(const MyAdmin());

class MyAdmin extends StatelessWidget{
  const MyAdmin({super.key});

  @override
  Widget build(BuildContext context) {
   return MaterialApp(
     debugShowCheckedModeBanner: false,
     theme: ThemeData(),
     home: ProductPage(),
   );
  }

}
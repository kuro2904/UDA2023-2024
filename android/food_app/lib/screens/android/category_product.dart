import 'package:flutter/material.dart';
import 'package:food_app/data/category.dart';
import 'package:food_app/screens/android/home_components/product_item.dart';
import 'package:food_app/utils/dialog.dart';

import 'home_components/wrap_list_menu.dart';

class CategoryProductPage extends StatefulWidget {
  final String categoryID;
  const CategoryProductPage({
    super.key,
    required this.categoryID
  });

  @override
  State createState() {
    return _CategoryProductPageState();
  }
}

class _CategoryProductPageState extends State<CategoryProductPage> {

  @override
  Widget build(BuildContext context) { // TODO: chỉ để test mà chưa test được nên để làm sau
    return Material(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
        child: Column(
          children: [
            FutureBuilder(
              future: Category.fetchProduct(widget.categoryID),
              builder: (context, snapshot) {
                if (snapshot.hasData == false) {
                  return const Text("No Data");
                }
                if (snapshot.data!.isEmpty) {
                  return const Text("No Product");
                }
                return WrapListMenu(children: snapshot.data!.map((e) {
                  return ProductItem(
                    product: e,
                    onTap: () {
                      showAlertDialog(context, e.name, e.description);
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
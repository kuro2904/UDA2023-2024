import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:food_app/screens/admin/category_management/category_management_page.dart';
import '../../../data/category.dart';
import '../../../utils/photo_utils.dart';

class AddOrUpdateCategoryPage extends StatefulWidget {
  final Category? category;

  const AddOrUpdateCategoryPage({super.key, this.category});

  @override
  State<StatefulWidget> createState() => AddOrUpdateDiscountState();
}

class AddOrUpdateDiscountState extends State<AddOrUpdateCategoryPage> {
  TextEditingController categoryId = TextEditingController();
  TextEditingController categoryName = TextEditingController();
  TextEditingController categoryDescription = TextEditingController();
  bool updateMode = false;
  Uint8List webImage = Uint8List(0);
  late Widget image;

  @override
  void initState() {
    if (widget.category != null) {
      categoryId.text = widget.category!.id.toString();
      categoryName.text = widget.category!.name.toString();
      categoryDescription.text = widget.category!.description.toString();
      updateMode = true;
      if (widget.category?.imageUrl != null) {
        image = Image.network(widget.category!.getImageUrl());
      } else {
        image = const Center(child: Text('No Image selected'));
      }
    } else {
      image = const Center(child: Text('No Image selected'));
    }
    super.initState();
  }

  @override
  void dispose() {
    categoryId.dispose();
    categoryName.dispose();
    categoryDescription.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            updateMode ? 'Update Category' : 'Add Category',
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Category Id (10 characters maximum)'),
                          controller: categoryId,
                          enabled: updateMode ? false : true,
                          maxLength: 10,
                        )),
                    Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Category Name (30 characters maximum)'),
                          controller: categoryName,
                          maxLength: 30,
                        )),
                    Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Category Description'),
                          controller: categoryDescription,
                          maxLength: 2550,
                        )),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: TextButton(
                            onPressed: () async {
                              final image = await imagePicker(PickSource.gallery);
                              setState(() {
                                if (image != null) {
                                  webImage = image;
                                  this.image = Image.memory(webImage, fit: BoxFit.fill);
                                } else {
                                  this.image = const Center(child: Text('Image picking failed!'));
                                }
                              });
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                MaterialStateProperty.all<Color>(
                                    Colors.blue)),
                            child: const Text(
                              'Choose Image',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            border: Border.all(),
                          ),
                          child: image,
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextButton(
                        onPressed: () async {
                          bool result = false;
                          if (updateMode) {
                            result = await Category.update(widget.category!.id, categoryName.text,
                                categoryDescription.text, webImage);
                          } else {
                            result = await Category.insert(categoryId.text, categoryName.text,
                                categoryDescription.text, webImage);
                          }
                          if (result) {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const CategoryPage()));
                          }
                        },
                        style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue)),
                        child: Text(
                          updateMode ? 'Update' : 'Add',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

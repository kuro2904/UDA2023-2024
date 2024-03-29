import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_app/data/product.dart';
import 'package:food_app/screens/admin/product_management/product_management_page.dart';
import 'package:food_app/utils/photo_utils.dart';
import 'package:food_app/data/category.dart';

class AddOrUpdateProductPage extends StatefulWidget {
  final Product? product;

  const AddOrUpdateProductPage({super.key, this.product});

  @override
  State<StatefulWidget> createState() => AddOrUpdateProductState();
}

class AddOrUpdateProductState extends State<AddOrUpdateProductPage> {
  TextEditingController productId = TextEditingController();
  TextEditingController productName = TextEditingController();
  TextEditingController productDescription = TextEditingController();
  TextEditingController productPrice = TextEditingController();
  final _onlyNumbersFormatter = FilteringTextInputFormatter.digitsOnly;

  late Future<List<Category>> futureCategory;
  Category? chosenCategory;
  Uint8List webImage = Uint8List(0);
  var updateMode = false;
  late Widget image;

  @override
  void initState() {
    if (widget.product != null) {
      productId.text = widget.product!.id.toString();
      productName.text = widget.product!.name.toString();
      productDescription.text = widget.product!.description.toString();
      productPrice.text =
          widget.product!.price.toString().replaceAll('k VND', '');
      updateMode = true;
      if (widget.product?.imageUrl != null) {
        image = Image.network(widget.product!.getImageUrl());
      } else {
        image = const Center(child: Text('No Image selected'));
      }
    } else {
      image = const Center(child: Text('No Image selected'));
    }
    futureCategory = Category.fetchAll();
    super.initState();
  }

  @override
  void dispose() {
    productId.dispose();
    productName.dispose();
    productDescription.dispose();
    productPrice.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          updateMode ? 'Update Product' : 'Add Product',
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
                            hintText: 'Product Id (10 characters maximum)'),
                        enabled: updateMode ? false : true,
                        controller: productId,
                        maxLength: 10,
                      )),
                  Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Product Name (30 characters maximum)'),
                        controller: productName,
                        maxLength: 30,
                      )),
                  Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Product Description'),
                        controller: productDescription,
                        maxLength: 2555,
                      )),
                  Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Product Price (10 characters maximum)',
                        ),
                        maxLength: 10,
                        inputFormatters: [_onlyNumbersFormatter],
                        controller: productPrice,
                      )),
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'Category: ',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  FutureBuilder(
                    future: futureCategory,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                        return const Text('No data available');
                      } else {
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: SizedBox(
                            height: 50,
                            child: DropdownButton<Category>(
                              value: chosenCategory,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: snapshot.data!.map((category) {
                                return DropdownMenuItem(
                                  value: category,
                                  child: Text(category.name),
                                );
                              }).toList(),
                              style: const TextStyle(
                                color: Colors.black, // Text color
                                fontSize: 16, // Text size
                                fontWeight: FontWeight.bold, // Text weight
                              ),
                              dropdownColor: Colors.grey[200],
                              elevation: 8,
                              isExpanded: true,
                              onChanged: (Category? value) {
                                setState(() {
                                  chosenCategory = value;
                                });
                              },
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextButton(
                          onPressed: () async {
                            var pickedImage = await imagePicker(PickSource.gallery);
                            setState(() {
                              if (pickedImage != null) {
                                webImage = pickedImage;
                                image = Image.memory(webImage, fit: BoxFit.fill);
                              } else {
                                image = const Center(child: Text('Image load failed'));
                              }
                            });
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
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
                        bool result;
                        if (updateMode) {
                          result = await Product.update(productId.text, productName.text, productPrice.text, productDescription.text, chosenCategory, webImage);
                        } else {
                          result = await Product.insert(productId.text, productName.text, productPrice.text, productDescription.text, chosenCategory, webImage);
                        }
                        if (result) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const ProductPage()));
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
      ),
    );
  }
}

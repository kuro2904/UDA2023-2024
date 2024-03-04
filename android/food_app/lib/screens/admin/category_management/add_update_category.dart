import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:food_app/constants/backend_config.dart';
import 'package:food_app/screens/admin/category_management/category_management_page.dart';
import 'package:food_app/utils/authentication_generate_token.dart';
import 'package:image_picker/image_picker.dart';
import '../../../data/category.dart';
import 'package:http/http.dart' as http;

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
  Uint8List webImage = Uint8List(8);
  File? _pickedImage;

  @override
  void initState() {
    if (widget.category != null) {
      categoryId.text = widget.category!.id.toString();
      categoryName.text = widget.category!.name.toString();
      categoryDescription.text = widget.category!.description.toString();
      updateMode = true;
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

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      var f = await image.readAsBytes();
      setState(() {
        webImage = f;
        _pickedImage = File('a');
      });
    } else {
      print('No image selected');
    }
  }

  // Future<void> _insertData(
  //     String id, String name, String description, File? image) async {
  //   BasicAuthGenerateToken token = BasicAuthGenerateToken("owner", "owner");
  //   Map<String, String> header = {
  //     'Authorization': token.generateToken(),
  //     'Content-Type': 'multipart/form-data; charset=UTF-8'
  //   };
  //   Map<String, String> body = {
  //     'id': id,
  //     'name': name,
  //     'description': description
  //   };
  //   try {
  //     Uri url = Uri.parse(BackEndConfig.insertCategoryString);
  //     var request = http.MultipartRequest('POST', url);
  //     if (image != null) {
  //       var stream = http.ByteStream(image.openRead());
  //       stream.cast();
  //       var length = await image.length();
  //       var multipart = http.MultipartFile('image', stream, length);
  //       request.files.add(multipart);
  //     }
  //     request.headers.addAll(header);
  //     request.fields['request'] = jsonEncode(body);
  //     var response = await request.send();
  //     if (response.statusCode == 201) {
  //       print(response.toString());
  //       Navigator.push(context,
  //           MaterialPageRoute(builder: (context) => const CategoryPage()));
  //     }else{
  //       print('Insertion failed with status code: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     throw Exception(e.toString());
  //   }
  // }

  // performUpdate(String text, String text2) {}

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
                              hintText: 'Category Id'),
                          controller: categoryId,
                          enabled: updateMode ? false : true,
                        )),
                    Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Category Name'),
                          controller: categoryName,
                        )),
                    Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Category Description'),
                          controller: categoryDescription,
                        )),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: TextButton(
                            onPressed: () {
                              _pickImage();
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
                          child: updateMode? Image.network(BackEndConfig.fetchImageString+widget.category!.imageUrl):
                          _pickedImage != null
                              ? Image.memory(
                            webImage,
                            fit: BoxFit.fill,
                          ) : const Center(child: Text('No Image selected')),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextButton(
                        onPressed: () {
                          // !updateMode
                              // ? _insertData(categoryId.text, categoryName.text,
                              // categoryDescription.text, _pickedImage)
                              // : performUpdate(
                              // categoryName.text, categoryDescription.text);
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

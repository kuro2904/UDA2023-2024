import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:food_app/constants/backend_config.dart';
import 'package:food_app/data/client_state.dart';
import 'package:food_app/screens/admin/category_management/category_management_page.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../../../data/category.dart';

class AddOrUpdateCategoryPage extends StatefulWidget {
  final Category? category;

  const AddOrUpdateCategoryPage({super.key, this.category});

  @override
  State<StatefulWidget> createState() => _AddOrUpdateCategoryPageState();
}

class _AddOrUpdateCategoryPageState extends State<AddOrUpdateCategoryPage> {
  TextEditingController categoryId = TextEditingController();
  TextEditingController categoryName = TextEditingController();
  TextEditingController categoryDescription = TextEditingController();
  bool updateMode = false;
  Uint8List webImage = Uint8List(0);
  bool edited = false;

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

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      var f = await image.readAsBytes();
      setState(() {
        webImage = f;
      });
    } else {
      print('No image selected');
    }
  }

  Future<void> _insertData(
      String id, String name, String description, Uint8List image) async {
    Map<String, String> header = {
      'Authorization': ClientState().token,
      'Content-Type': 'multipart/form-data;'
    };
    Map<String, String> body = {
      'id': id,
      'name': name,
      'description': description
    };
    try {
      Uri url = Uri.parse(BackEndConfig.insertCategoryString);
      var request = http.MultipartRequest('POST', url);
      if (image.isNotEmpty) {
        List<int> data = image.cast();
        request.files.add(
            http.MultipartFile.fromBytes('image', data, filename: 'asd.jpg'));
      }
      request.headers.addAll(header);
      request.fields['request'] = jsonEncode(body).toString();
      var response = await request.send();
      if (response.statusCode == 201) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const CategoryPage()));
      } else {
        print(
            'Insertion failed with status code: ${response.statusCode}  ${response.stream.toString()}');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> _updateData(
      String id, String name, String description, Uint8List image) async {
    Map<String, String> header = {
      'Authorization': ClientState().token,
      'Content-Type': 'multipart/form-data;'
    };
    Map<String, String> body = {'name': name, 'description': description};
    try {
      Uri url = Uri.parse(BackEndConfig.updateCategoryString + id);
      var request = http.MultipartRequest('PUT', url);
      if (image.isNotEmpty) {
        List<int> data = image.cast();
        request.files.add(
            http.MultipartFile.fromBytes('image', data, filename: 'asd.jpg'));
      }
      request.headers.addAll(header);
      request.fields['request'] = jsonEncode(body).toString();
      var response = await request.send();
      if (response.statusCode == 200) {
        edited = false;
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const CategoryPage()));
      } else {
        print(
            'Insertion failed with status code: ${response.statusCode}  ${response.stream.toString()}');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          updateMode ? 'Update Category' : 'Add Category',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Category Id (10 characters maximum)',
                border: OutlineInputBorder(),
              ),
              controller: categoryId,
              enabled: !updateMode,
              maxLength: 10,
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Category Name (30 characters maximum)',
                border: OutlineInputBorder(),
              ),
              controller: categoryName,
              maxLength: 30,
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Category Description',
                border: OutlineInputBorder(),
              ),
              controller: categoryDescription,
              maxLength: 2550,
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _pickImage();
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.indigoAccent)),
                  child: const Text(
                    'Choose Image',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    border: Border.all(),
                  ),
                  child: webImage.isNotEmpty
                      ? Image.memory(
                          webImage,
                          fit: BoxFit.cover,
                        )
                      : (updateMode && widget.category?.imageUrl != null)
                          ? Image.network(
                              BackEndConfig.fetchImageString +
                                  widget.category!.imageUrl!,
                              fit: BoxFit.cover,
                            )
                          : const Center(
                              child: Text('No Image selected'),
                            ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                updateMode
                    ? _updateData(widget.category!.id, categoryName.text,
                        categoryDescription.text, webImage)
                    : _insertData(categoryId.text, categoryName.text,
                        categoryDescription.text, webImage);
              },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.indigoAccent)),
              child: Text(
                updateMode ? 'Update' : 'Add',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

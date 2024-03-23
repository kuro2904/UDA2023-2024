import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:food_app/constants/backend_config.dart';
import 'package:food_app/data/client_state.dart';
import 'package:food_app/screens/admin/category_management/category_management_page.dart';
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

  @override
  void dispose() {
    categoryId.dispose();
    categoryName.dispose();
    categoryDescription.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async{
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if(image != null){
      var f = await image.readAsBytes();
      setState(() {
        webImage = f;
      });
    }else{
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
        request.files.add(http.MultipartFile.fromBytes('image', data, filename: 'asd.jpg'));
      }
      request.headers.addAll(header);
      request.fields['request'] = jsonEncode(body).toString();
      var response = await request.send();
      if (response.statusCode == 201) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const CategoryPage()));
      } else {
        print('Insertion failed with status code: ${response.statusCode}  ${response.stream.toString()}');
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
    Map<String, String> body = {
      'name': name,
      'description': description
    };
    try {
      Uri url = Uri.parse(BackEndConfig.updateCategoryString+id);
      var request = http.MultipartRequest('PUT', url);
      if (image.isNotEmpty) {
        List<int> data = image.cast();
        request.files.add(http.MultipartFile.fromBytes('image', data, filename: 'asd.jpg'));
      }
      request.headers.addAll(header);
      request.fields['request'] = jsonEncode(body).toString();
      var response = await request.send();
      if (response.statusCode == 200) {
        edited = false;
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const CategoryPage()));
      } else {
        print('Insertion failed with status code: ${response.statusCode}  ${response.stream.toString()}');
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
                            onPressed: () {
                             setState(() {
                               edited = true;
                               _pickImage();
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
                          child: updateMode && !edited && widget.category?.imageUrl != null? Image.network(BackEndConfig.fetchImageString+widget.category!.imageUrl!):
                          webImage.isNotEmpty
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
                         updateMode? _updateData(widget.category!.id, categoryName.text,categoryDescription.text,webImage):
                          _insertData(categoryId.text, categoryName.text, categoryDescription.text, webImage);
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

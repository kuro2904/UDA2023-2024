import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';



import '../../../data/category.dart';

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
  File? _pickedImage;

  @override
  void initState() {
    if(widget.category != null){
      categoryId.text = widget.category!.id.toString();
      categoryName.text = widget.category!.name.toString();
      categoryDescription.text = widget.category!.description.toString();
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

  Future<void> _pickImageWeb() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );
    if (result != null && result.files.isNotEmpty) {
      File file = File(result.files.first.path!);
      setState(() {
        _pickedImage = file;
      });
    }
  }
  performInsert(String id, String name, String price, String description){}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.category != null ? 'Update Category' : 'Add Category',
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
                              hintText: 'Product Id'),
                          controller: categoryId,
                        )),
                    Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Product Name'),
                          controller: categoryName,
                        )),
                    Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Product Description'),
                          controller: categoryDescription,
                        )),
                    Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Product Price'),
                          controller: categoryDescription,
                        )),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextButton(
                        onPressed: _pickImageWeb,
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.blue)),
                        child: const Text(
                          'Choose Image',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextButton(
                        onPressed: (){},
                        style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue)),
                        child: Text(
                          widget.category !=null ? 'Update' : 'Add',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}



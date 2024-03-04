import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/data/product.dart';
import 'package:food_app/utils/authentication_generate_token.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import '../../../constants/backend_config.dart';
import '../../../data/category.dart';

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
  late Future<List<Category>> futureCategory;
  late Category chosenCategory;
  Uint8List webImage = Uint8List(8);
  File? _pickedImage;
  var updateMode = false;

  @override
  void initState() {
    if (widget.product != null) {
      productId.text = widget.product!.id.toString();
      productName.text = widget.product!.name.toString();
      productDescription.text = widget.product!.description.toString();
      productPrice.text = widget.product!.description.toString();
      updateMode = true;
    }
    futureCategory = fetchAllCategories();
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


  Future<void> performInsert(String id, String name, String price, String description) async {
    BasicAuthGenerateToken generateToken = BasicAuthGenerateToken("owner", "owner");
    Uri url = Uri.parse(BackEndConfig.insertProductString);
    Map<String,String> header = {
      'Authorization': generateToken.generateToken(),
      'Content-Type': 'application/form-data'
    };
  }

  Future<void> _pickImage() async{
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if(image != null){
      var f = await image.readAsBytes();
      setState(() {
        webImage = f;
        _pickedImage = File('a');
      });
    }else{
      print('No image selected');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          updateMode? 'Update Product' : 'Add Product',
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
                          controller: productId,
                        )),
                    Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Product Name'),
                          controller: productName,
                        )),
                    Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Product Description'),
                          controller: productDescription,
                        )),
                    Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Product Price',
                          ),
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
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (snapshot.hasData &&
                              snapshot.data != null) {
                            chosenCategory = snapshot.data!.first;
                            return Padding(
                              padding: const EdgeInsets.all(10),
                              child: SizedBox(
                                height: 50,
                                child: DropdownButton<Category>(
                                  value: chosenCategory,
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  items: snapshot.data!.map((category) {
                                    return DropdownMenuItem(value: category,child: Text(category.name),);
                                  }).toList(),
                                  style: const TextStyle(
                                    color: Colors.black, // Text color
                                    fontSize: 16, // Text size
                                    fontWeight: FontWeight.bold, // Text weight
                                  ),
                                  dropdownColor: Colors.grey[200],
                                  elevation: 8,
                                  isExpanded: true,
                                  onChanged: (Category? value) { setState(() {
                                    chosenCategory = value!;
                                  }); },
                                ),
                              ),
                            );
                          } else {
                            return const Center(
                              child: Text('No data available'),
                            );
                          }
                        }),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: TextButton(
                            onPressed: (){
                              _pickImage();
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.blue)),
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
                          child: _pickedImage != null ? Image.memory(webImage, fit: BoxFit.fill,) : const Center(child:Text('No Image selected')),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextButton(
                        onPressed: () {},
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
          )),
    );
  }
}

List<Category> parseCategories(String responseBody) {
  final parser = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parser.map<Category>((json) => Category.fromJson(json)).toList();
}

Future<List<Category>> fetchAllCategories() async {
  final response =
      await http.get(Uri.parse(BackEndConfig.fetchAllCategoryString));
  if (response.statusCode == 200) {
    return parseCategories(response.body);
  } else {
    throw Exception('Unable to fetch all Category');
  }
}

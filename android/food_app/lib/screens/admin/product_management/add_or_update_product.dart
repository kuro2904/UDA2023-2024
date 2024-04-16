import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_app/data/product.dart';
import 'package:food_app/screens/admin/product_management/product_management_page.dart';
import 'package:food_app/utils/dialog.dart';
import 'package:food_app/utils/network.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:confirm_dialog/confirm_dialog.dart';

import '../../../constants/backend_config.dart';
import '../../../data/category.dart';
import '../../../data/client_state.dart';

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
  TextEditingController toppingTextBox = TextEditingController();
  TextEditingController toppingPrice = TextEditingController();
  final _onlyNumbersFormatter = FilteringTextInputFormatter.digitsOnly;

  late Future<List<Category>> futureCategory;
  List<Map<String, dynamic>> _topping = [];
  List<Map<String, dynamic>> removedTopping = []; // Để kiểm xoát những topping đã có trong csdl nhưng bị xóa sẽ được lưu tạm ở đây để khi cập nhật sẽ xóa
  List<int> updatedTopping = [];
  Category? chosenCategory;
  Uint8List webImage = Uint8List(0);
  var updateMode = false;
  var edited = false;

  @override
  void initState() {
    if (widget.product != null) {
      productId.text = widget.product!.id.toString();
      productName.text = widget.product!.name.toString();
      productDescription.text = widget.product!.description.toString();
      productPrice.text =
          widget.product!.price.toString().replaceAll('k VND', '');
      updateMode = true;
      fetchToppingList(widget.product!.id);
    }
    futureCategory = fetchAllCategories();
    super.initState();
  }

  Future<void> performInsert(String id, String name, String price,
      String description, Category? category, Uint8List image) async {
    Uri url = Uri.parse(BackEndConfig.insertProductString);
    Map<String, String> header = {
      'Authorization': ClientState().token,
      'Content-Type': 'multipart/form-data;'
    };
    Map<String, dynamic> body = {
      'name': name,
      'price': '${price}k VND',
      'description': description,
      'topping': _topping,
    };
    if (category != null) {
      body['categoryId'] = category.id;
    }
    var request = http.MultipartRequest('POST', url);
    try {
      if (image.isNotEmpty) {
        List<int> data = webImage.cast();
        request.files.add(
            http.MultipartFile.fromBytes('image', data, filename: 'asd.jpg'));
      }
      request.headers.addAll(header);
      request.fields['request'] = jsonEncode(body).toString();
      print(request.toString());
      var response = await request.send();
      if (response.statusCode == 201) {
        Navigator.pop(context);
      } else {
        print('Insertion failed with status code: ${response.statusCode}}');
      }
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  Future<void> performUpdate(String id, String name, String price,
      String description, Category? category, Uint8List image) async {
    // update topping
    for (var i in _topping) {
      if (i['id'] == null) {
        final ok = await Product.addTopping(id, i['name'], int.parse(i['price']));
        if ( !ok ) {
          await showAlertDialog(context, "Failed to add topping ${i['name']}", "Error!");
        }
      }
      if (updatedTopping.contains(i['id'])) {
        final ok = await Product.updateTopping(i['id'].toString(), i['name'], int.parse(i['price']));
        if ( !ok ) {
          await showAlertDialog(context, "Failed to update topping ${i['name']}", "Error!");
        }
      }
    }

    for (var i in removedTopping) {
      final ok = await Product.deleteTopping(i['id'].toString());
      if ( !ok ) {
        await showAlertDialog(context, "Failed to remove topping ${i['name']}", "Error!");
      }
    }

    // Update product info
    Uri url = Uri.parse(BackEndConfig.updateProductString + id);
    Map<String, String> header = {
      'Authorization': ClientState().token,
      'Content-Type': 'multipart/form-data;'
    };
    Map<String, dynamic> body = {
      'name': name,
      'price': '${price}k VND',
      'description': description,
    };
    if (category != null) {
      body['categoryId'] = category.id;
    }
    var request = http.MultipartRequest('PUT', url);
    try {
      if (image.isNotEmpty) {
        List<int> data = image.cast();
        request.files.add(
            http.MultipartFile.fromBytes('image', data, filename: 'asd.jpg'));
      }
      request.headers.addAll(header);
      request.fields['request'] = jsonEncode(body).toString();
      var response = await request.send();
      if (response.statusCode == 200) {
        Navigator.pop(context);
      } else {
        print(
            'Update failed with status code: ${response.statusCode} ${response}');
      }
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      var f = await image.readAsBytes();
      setState(() {
        edited = true;
        webImage = f;
      });
    } else {
      print('No image selected');
    }
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(5),
                child: TextField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Product Id'),
                  enabled: false,
                  controller: productId,
                  maxLength: 255,
                )),
            Padding(
                padding: const EdgeInsets.all(5),
                child: TextField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Product Name (30 characters maximum)'),
                  controller: productName,
                  maxLength: 255,
                )),
            Padding(
                padding: const EdgeInsets.all(5),
                child: TextField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Product Description'),
                  controller: productDescription,
                  maxLength: 255,
                )),
            Padding(
                padding: const EdgeInsets.all(5),
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Product Price (12 characters maximum)',
                  ),
                  maxLength: 12,
                  inputFormatters: [_onlyNumbersFormatter],
                  controller: productPrice,
                )),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
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
                        value: updateMode && (chosenCategory == null) ?
                        snapshot.data!.where((e) => e.id == widget.product!.categoryId).first :
                        chosenCategory,
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
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                'Topping: ',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: toppingTextBox,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Topping name (255 characters maximum)'
                      ),
                      maxLength: 255,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: toppingPrice,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Topping price (255 characters maximum)'
                      ),
                      keyboardType: TextInputType.number,
                      maxLength: 255,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.singleLineFormatter,
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add_box),
                    iconSize: 50,
                    alignment: Alignment.center,
                    onPressed: () async {
                      final data = { 'name': toppingTextBox.text, 'price': toppingPrice.text };
                      if (data['name']!.isEmpty) {
                        showAlertDialog(context, "Topping name không được để trống!", "Lỗi!");
                        return;
                      }
                      for (var i in removedTopping) {
                        if (i['name'] == data['name']) {
                          setState(() {
                            _topping.add(i);
                            removedTopping.remove(i);
                          });
                          showAlertDialog(context, "Topping ${i['name']} bị xóa trước đó đã được phục hồi", "Thông báo");
                          toppingTextBox.clear();
                          return;
                        }
                      } // kiểm tra nếu topping đã bị xóa trước đó
                      if (data['price']!.trim().isEmpty) {
                        showAlertDialog(context, "Topping price không được để trống!", "Lỗi!");
                        return;
                      }

                      for (var i in _topping) {
                        if (i['name'] == data['name']) {
                          if (i['price'] == data['price']) {
                            showAlertDialog(context, "Topping ${data['name']} đã tồn tại", "Lỗi!");
                            return;
                          }
                          if (await confirm(context, title: Text("${i['price']} => ${data['price']}?"))) {
                            setState(() {
                              i['price'] = data['price'];
                              if (i['id'] != null && !updatedTopping.contains(i['id'])) {
                                updatedTopping.add(i['id']);
                              }
                            });
                            toppingTextBox.clear();
                            toppingPrice.clear();
                          }
                          return;
                        }
                      } // Kiểm tra nếu tên đã tồn tại
                      setState(() {
                        _topping.add(data);
                      });
                      toppingTextBox.clear();
                      toppingPrice.clear();
                    },
                  ),
                ],
              ),
            ),
            Container (
              height: 100,
              color: Colors.white,
              child: ListView.builder(
                itemCount: _topping.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        toppingTextBox.text = _topping[index]['name'];
                        if (_topping[index]['price'] != null) {
                          toppingPrice.text = _topping[index]['price'];
                        }
                      });
                    },
                    child: ListTile(
                      title: (_topping[index]['price'] != null) ? Text("${_topping[index]['name']} (${_topping[index]['price']} vnd)") : Text(_topping[index]['name']),
                      subtitle: null,
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            if (_topping[index]['id'] != null) {
                              removedTopping.add(_topping[index]);
                            }
                            _topping.removeAt(index);
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextButton(
                    onPressed: () {
                      _pickImage();
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
                  child: updateMode &&
                      !edited &&
                      widget.product?.imageUrl != null
                      ? Image.network(BackEndConfig.fetchImageString +
                      widget.product!.imageUrl!)
                      : webImage.isNotEmpty
                      ? Image.memory(
                    webImage,
                    fit: BoxFit.fill,
                  )
                      : const Center(
                      child: Text('No Image selected')),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextButton(
                onPressed: () {
                  if (updateMode) {
                    performUpdate(
                        productId.text,
                        productName.text,
                        productPrice.text,
                        productDescription.text,
                        chosenCategory,
                        webImage);
                  } else {
                    performInsert(
                        productId.text,
                        productName.text,
                        productPrice.text,
                        productDescription.text,
                        chosenCategory,
                        webImage);
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
      ),
    );
  }

  Future<void> fetchToppingList(String productId) async {
    final response = await getRequest(BackEndConfig.fetchToppingByProduct + productId);
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      setState(() {
        _topping = data.map((e) {
          return Map<String, dynamic>.from(e);
        }).toList();
      });
    }
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

Future<Category?> fetchCategoryById(String id) async {
  final response = await getRequest(BackEndConfig.getCategoryString + id);
  if (response.statusCode == 200) {
    return Category.fromJson(json.decode(response.body).cast<Map<String, dynamic>>());
  }
  return null;
}

bool isValidPositiveInt(String? s) {
  if (s == null) {
    return false;
  }
  final trimmed = s.trim();
  if (trimmed.isEmpty) {
    return false;
  }
  final parsedInt = int.tryParse(trimmed);
  return parsedInt != null && parsedInt > 0;
}

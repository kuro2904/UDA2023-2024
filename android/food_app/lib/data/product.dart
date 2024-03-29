import 'dart:convert';
import 'dart:typed_data';

import 'package:food_app/constants/backend_config.dart';
import 'package:food_app/utils/network.dart';

import 'category.dart';
import 'client_state.dart';

class Product {
  final String id;
  final String name;
  final String price;
  final String description;
  String? imageUrl;

  Product(
      {required this.id,
      required this.name,
      required this.price,
      required this.description, this.imageUrl});

  factory Product.fromJson(Map<String, dynamic> data) {
    return switch (data) {
      {
        'id': String id,
        'name': String name,
        'price': String price,
        'description': String description,

      } =>
        Product(
            id: id,
            name: name,
            price: price,
            description: description,
            imageUrl: data['imageUrl'] != null ? data['imageUrl'].toString() : ''),
      _ => throw const FormatException('Failed to load Product'),
    };
  }
  String getImageUrl() {
    if (imageUrl == null) {
      return ""; // TODO: default image url here
    }
    return BackEndConfig.fetchImageString+imageUrl!;
  }

  /// ## Fetch all product
  ///
  /// return empty list for all kind of error to prevent app crashing
  static Future<List<Product>> fetchAll() async {
    final response = await getRequest(BackEndConfig.fetchAllProductString);
    if (response.statusCode == 200) {
      final parser = json.decode(response.body).cast<Map<String, dynamic>>();
      return parser.map<Product>((json) => Product.fromJson(json)).toList();
    }
    // NOTE: log error if needed
    return [];
  }

  /// ## Insert product
  ///
  /// ### input:
  ///
  ///   **<span style="color: yellow">[id]</span>** product id
  ///
  ///   **<span style="color: yellow">[name]</span>** product name
  ///
  ///   **<span style="color: yellow">[price]</span>** product price
  ///
  ///   **<span style="color: yellow">[description]</span>** product description
  ///
  ///   **<span style="color: yellow">[category]</span>** product category
  ///
  ///   **<span style="color: yellow">[image]</span>** product image
  ///
  ///   **<span style="color: yellow">[onException]</span>** callback use for debug
  ///
  /// ### return:
  ///
  ///   **<span style="color: blue">true</span>** when success
  ///
  ///   **<span style="color: red">false</span>** when error occurred
  static Future<bool> insert (
    String id,
    String name,
    String price,
    String description,
    Category? category,
    Uint8List image,
    {
      void Function(Exception)? onException
    }) async {
    Map<String,String> header = {
      'Authorization': ClientState().token,
      'Content-Type': 'multipart/form-data;',
    };
    Map<String, String> body = {
      'id': id,
      'name': name,
      'price': '${price}k VND',
      'description':description,
    };
    if(category != null){
      body['categoryId'] = category.id;
    }
    Map<String, String> fields = {
      'request': jsonEncode(body).toString()
    };
    Map<String, UploadFile> files = {
      'image': UploadFile(data: image, filename: 'asd.jpg')
    };
    final response = await formRequest(
      BackEndConfig.insertProductString,
      'POST',
      header,
      fields,
      files,
      onException: onException,
    );
    if (response == null) {
      return false;
    }
    if (response.statusCode == 201) {
      return true;
    }
    // NOTE: log error if needed
    return false;
  }

  /// ## Update product
  ///
  /// ### input:
  ///
  ///   **<span style="color: yellow">[id]</span>** product id
  ///
  ///   **<span style="color: yellow">[name]</span>** product name
  ///
  ///   **<span style="color: yellow">[price]</span>** product price
  ///
  ///   **<span style="color: yellow">[description]</span>** product description
  ///
  ///   **<span style="color: yellow">[category]</span>** product category
  ///
  ///   **<span style="color: yellow">[image]</span>** product image
  ///
  ///   **<span style="color: yellow">[onException]</span>** callback use for debug
  ///
  /// ### return:
  ///
  ///   **<span style="color: blue">true</span>** when success
  ///
  ///   **<span style="color: red">false</span>** when error occurred
  static Future<bool> update (
    String id,
    String name,
    String price,
    String description,
    Category? category,
    Uint8List image,
    {
      void Function(Exception)? onException
    }) async {
    Map<String,String> header = {
      'Authorization': ClientState().token,
      'Content-Type': 'multipart/form-data;',
    };
    Map<String, String> body = {
      'name': name,
      'price': '${price}k VND',
      'description':description,
    };
    Map<String, String> fields = {
      'request': jsonEncode(body).toString()
    };
    Map<String, UploadFile> files = {
      'image': UploadFile(data: image, filename: 'asd.jpg')
    };
    if(category != null){
      body['categoryId'] = category.id;
    }
    final response = await formRequest(
      BackEndConfig.updateProductString+id,
      'PUT',
      header,
      fields,
      files,
      onException: onException,
    );
    if (response == null) {
      return false;
    }
    if (response.statusCode == 200) {
      return true;
    }
    // NOTE: log error if needed
    return false;
  }

}

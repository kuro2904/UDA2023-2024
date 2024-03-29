import 'dart:convert';
import 'dart:typed_data';

import 'package:food_app/data/product.dart';

import '../constants/backend_config.dart';
import '../utils/network.dart';
import 'client_state.dart';

class Category {
  final String id;
  final String name;
  final String description;
  String? imageUrl;

  Category(
      {required this.id,
      required this.name,
      required this.description, this.imageUrl});

  factory Category.fromJson(Map<String, dynamic> data) {
    return switch (data) {
      {
        'id': String id,
        'name': String name,
        'description': String description,
      } =>
        Category(
            id: id, name: name, description: description, imageUrl: data['imageUrl'] != null ? data['imageUrl'].toString() : ''),
      _ => throw const FormatException('Failed to load Category')
    };
  }
  Map<String,String> toJson() => {
    'id':id,
    'name':name,
    'description':description
  };
  String getImageUrl() {
    if (imageUrl == null) {
      return ""; // TODO: default image url here
    }
    return BackEndConfig.fetchImageString+imageUrl!;
  }

  /// ## Fetch categories
  ///
  /// Fetch all categories
  ///
  /// return empty list on all kind of error to prevent app crashing
  static Future<List<Category>> fetchAll() async {
    final response = await getRequest(BackEndConfig.fetchAllCategoryString);
    if (response.statusCode == 200) {
      final parser = json.decode(response.body).cast<Map<String, dynamic>>();
      return parser.map<Category>((json) => Category.fromJson(json)).toList();
    }
    // NOTE: log error if needed
    return [];
  }

  /// ## Find products
  ///
  /// Fetch product from given category id
  ///
  /// Take **<span style="color: yellow">[categoryID]</span>** as input
  ///
  /// return empty list for all kind of error to prevent app crashing
  static Future<List<Product>> fetchProduct(String categoryID) async {
    final response = await getRequest("${BackEndConfig.getProductByCategory}$categoryID");
    if (response.statusCode == 200) {
      final parser = json.decode(response.body).cast<Map<String, dynamic>>();
      return parser.map<Product>((json) => Product.fromJson(json)).toList();
    }
    // NOTE: log error if needed
    return [];
  }

  /// ## Insert category
  ///
  /// ### input:
  ///
  ///   **<span style="color: yellow">[id]</span>** category id
  ///
  ///   **<span style="color: yellow">[name]</span>** category name
  ///
  ///   **<span style="color: yellow">[description]</span>** category description
  ///
  ///   **<span style="color: yellow">[image]</span>** category image
  ///
  ///   **<span style="color: yellow">[onException]</span>** callback use for debug
  ///
  /// ### return:
  ///
  ///   **<span style="color: blue">true</span>** when success
  ///
  ///   **<span style="color: red">false</span>** when error occurred
  static Future<bool> insert(String id, String name, String description, Uint8List image, { void Function(Exception)? onException }) async {
    Map<String, String> header = {
      'Authorization': ClientState().token,
      'Content-Type': 'multipart/form-data;'
    };
    Map<String, String> body = {
      'id': id,
      'name': name,
      'description': description
    };
    Map<String, String> fields = {
      'request': jsonEncode(body).toString()
    };
    Map<String, UploadFile> files = {
      'image': UploadFile(data: image, filename: 'asd.jpg')
    };
    final response = await formRequest(
      BackEndConfig.insertCategoryString,
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
    // Log error if needed
    return false;
  }

  /// ## Update category
  ///
  /// ### input:
  ///
  ///   **<span style="color: yellow">[id]</span>** category id
  ///
  ///   **<span style="color: yellow">[name]</span>** category name
  ///
  ///   **<span style="color: yellow">[description]</span>** category description
  ///
  ///   **<span style="color: yellow">[image]</span>** category image
  ///
  ///   **<span style="color: yellow">[onException]</span>** callback use for debug
  ///
  /// ### return:
  ///
  ///   **<span style="color: blue">true</span>** when success
  ///
  ///   **<span style="color: red">false</span>** when error occurred
  static Future<bool> update(String id, String name, String description, Uint8List image, { void Function(Exception)? onException }) async {
    Map<String, String> header = {
      'Authorization': ClientState().token,
      'Content-Type': 'multipart/form-data;'
    };
    Map<String, String> body = {
      'id': id,
      'name': name,
      'description': description
    };
    Map<String, String> fields = {
      'request': jsonEncode(body).toString()
    };
    Map<String, UploadFile> files = {
      'image': UploadFile(data: image, filename: 'asd.jpg')
    };
    final response = await formRequest(
      BackEndConfig.updateCategoryString+id,
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
    // Log error if needed
    return false;
  }

  /// ## Delete category
  ///
  /// ### Input:
  ///
  ///   **<span style="color: yellow">[id]</span>** id
  ///
  /// ### Return:
  ///
  ///   **<span style="color: blue">true</span>** when success
  ///
  ///   **<span style="color: red">false</span>** when error occurred
  static Future<bool> delete(String id) async {
    Map<String, String> header = {
      'Authorization': ClientState().token,
      'Content-Type': 'application/json; charset=UTF-8'
    };
    final response = await deleteRequest(BackEndConfig.deleteCategoryString + id, headers: header);
    if (response.statusCode == 200) {
      return true;
    }
    // NOTE: Log error if needed
    return false;
  }
}

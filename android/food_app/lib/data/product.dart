import 'dart:convert';

import 'package:food_app/data/client_state.dart';

import '../constants/backend_config.dart';
import '../utils/network.dart';

class Product {
  final String id;
  final String name;
  final String price;
  final String description;
  final String categoryId;
  String? imageUrl;

  Product(
      {required this.id,
      required this.name,
      required this.price,
      required this.description,
      required this.categoryId,
      this.imageUrl});

  factory Product.fromJson(Map<String, dynamic> data) {
    return switch (data) {
      {
        'id': String id,
        'name': String name,
        'price': String price,
        'description': String description,
        'categoryId': String categoryId,
      } =>
        Product(
            id: id,
            name: name,
            price: price,
            description: description,
            categoryId: categoryId,
            imageUrl:
                data['imageUrl'] != null ? data['imageUrl'].toString() : ''),
      _ => throw const FormatException('Failed to load Product'),
    };
  }

  static Future<List<Map<String, dynamic>>> fetchTopping(String productId) async {
    final response = await getRequest(BackEndConfig.fetchToppingByProduct + productId);
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((e) {
        return Map<String, dynamic>.from(e);
      }).toList();
    }
    return [];
  }

  static Future<Product> getProduct(String id) async {
    final response = await getRequest(BackEndConfig.getProductString + id);
    if (response.statusCode == 200) {
      final parser = json.decode(response.body);
      return Product.fromJson(parser);
    }
    return Product(id: "invalid", name: "invalid", price: "invalid", description: "invalid", categoryId: "invalid");
  }

  static Future<bool> deleteProduct(String id, {void Function(String serverMessage)? debug}) async {
    String url = "${BackEndConfig.deleteProductString}$id";
    final response = await deleteRequest(url, headers: ClientState().header);
    if (debug != null) {
      debug(response.body);
    }
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  static Future<bool> addTopping(String productId, String name, int price, {void Function(String serverMessage)? debug}) async {
    final data = {
      "name": name,
      "price": price
    };
    String url = "${BackEndConfig.addToppingString}$productId/topping";
    final response = await putJsonRequest(url, ClientState().header, data);
    if (debug != null) {
      debug(response.body);
    }
    if (response.statusCode == 201) {
      return true;
    }
    return false;
  }

  static Future<bool> updateTopping(String id, String name, int price, {void Function(String serverMessage)? debug}) async {
    final data = {
      "name": name,
      "price": price
    };
    String url = "${BackEndConfig.updateToppingString}$id";
    final response = await putJsonRequest(url, ClientState().header, data);
    if (debug != null) {
      debug(response.body);
    }
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  static Future<bool> deleteTopping(String id, {void Function(String serverMessage)? debug}) async {
    final url = "${BackEndConfig.deleteToppingString}$id";
    final response = await deleteRequest(url, headers: ClientState().header);
    if (debug != null) {
      debug(response.body);
    }
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}

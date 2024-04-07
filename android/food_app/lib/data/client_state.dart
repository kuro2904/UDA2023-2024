import 'dart:convert';

import 'package:food_app/constants/backend_config.dart';
import 'package:food_app/data/OrderDetail.dart';
import 'package:food_app/data/category.dart';
import 'package:food_app/data/product.dart';
import 'package:food_app/utils/network.dart';

class ClientState {
  // Singleton
  static final ClientState _instance = ClientState._internal();

  bool isLogin = false;
  String serverMessage = "";
  String userName = "";
  String userPassword = "";
  String token = "";
  String role = "";
  List<OrderDetail> cart = [];

  Map<String, String> header = {};

  factory ClientState() {
    return _instance;
  }

  logout() {
    isLogin = false;
    serverMessage = "";
    userName = "";
    userPassword = "";
    token = "";
    cart = [];
  }

  Future<List<Category>> getAllCategories() async {
    final response = await getRequest(BackEndConfig.fetchAllCategoryString);
    serverMessage = response.body;
    if (response.statusCode == 200) {
      final parser = json.decode(serverMessage).cast<Map<String, dynamic>>();
      return parser.map<Category>((json) => Category.fromJson(json)).toList();
    }
    return [];
  }

  Future<List<Product>> getProductByCategory(String categoryID) async {
    final response =
        await getRequest("${BackEndConfig.getProductByCategory}$categoryID");
    serverMessage = response.body;
    if (response.statusCode == 200) {
      final parser = json.decode(serverMessage).cast<Map<String, dynamic>>();
      return parser.map<Product>((json) => Product.fromJson(json)).toList();
    }
    return [];
  }

  ClientState._internal() {
    header.addEntries({"Accept": "*/*"}.entries);
    header.addEntries(
        {"Content-Type": "application/json; charset=UTF-8"}.entries);
  }
}

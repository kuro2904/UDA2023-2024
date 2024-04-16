import 'dart:async';
import 'dart:convert';

import 'package:food_app/constants/backend_config.dart';
import 'package:food_app/data/OrderDetail.dart';
import 'package:food_app/data/category.dart';
import 'package:food_app/data/product.dart';
import 'package:food_app/utils/network.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<void> saveState() async {
    final prefs = await SharedPreferences.getInstance();
    final selectedFood = cart.map((e) => e.toString()).toList();
    await prefs.setStringList('UDA2023-2024.cart', selectedFood);
    prefs.setString('UDA2023-2024.userName', userName);
    prefs.setString('UDA2023-2024.role', role);
    prefs.setString('UDA2023-2024.userPassword', userPassword);
    prefs.setString('UDA2023-2024.token', token);
    prefs.setBool('UDA2023-2024.loginState', isLogin);
  }

  Future<void> loadState() async {
    final prefs = await SharedPreferences.getInstance();
    final selectedFoodData = prefs.getStringList('UDA2023-2024.cart');
    cart = selectedFoodData!.map((e) async { return OrderDetail.fromString(e); }).cast<OrderDetail>().toList();
    userName = prefs.getString('UDA2023-2024.userName') ?? "";
    userPassword = prefs.getString('UDA2023-2024.userPassword') ?? "";
    token = prefs.getString('UDA2023-2024.token') ?? "";
    isLogin = prefs.getBool('UDA2023-2024.loginState') ?? false;
    role = prefs.getString('UDA2023-2024.role') ?? "";
  }

  bool isAdmin() {
    if (isLogin == false) {
      return false;
    }

    if (role == 'ROLE_OWNER') { // define your administrator row string here
      return true;
    }

    return false;
  }

  bool logout() {
    if (isLogin == false) {
      return false;
    }
    isLogin = false;
    serverMessage = "";
    userName = "";
    userPassword = "";
    token = "";
    cart = [];
    return true;
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

  void addToCart(OrderDetail data, { int? mergeWith, int? current }) {
    if (mergeWith != null) {
      if (cart[mergeWith].product.id == data.product.id
        && foundation.listEquals(cart[mergeWith].toppings, data.toppings)) {
        cart[mergeWith].quantity += data.quantity;
        if (current != null) {
          cart.removeAt(current);
        }
        return;
      }
    }
    cart.add(data);
  }

  void updateCart(int inCartId, OrderDetail data) {
    cart[inCartId] = data;
  }

  void clearCart() {
    cart.clear();
  }

  ClientState._internal() {
    header.addEntries({"Accept": "*/*"}.entries);
    header.addEntries(
        {"Content-Type": "application/json; charset=UTF-8"}.entries);
  }

  List<int> getCartDuplicate(int currentId, String productId, List<int> selectedTopping) {
    List<int> duplicatedList = [];
    for (int i = 0; i < cart.length; i++) {
      if (i == currentId) continue;
      final cartItem = cart[i];
      if (cartItem.product.id == productId && foundation.listEquals(cartItem.toppings, selectedTopping)) {
        duplicatedList.add(i);
      }
    }
    return duplicatedList;
  }
}

import 'dart:convert';
import 'package:food_app/data/product.dart';
import 'package:food_app/utils/network.dart';
import 'package:food_app/constants/backend_config.dart';
import 'package:food_app/data/category.dart';

class ClientState { // Singleton
  static final ClientState _instance = ClientState._internal();

  bool isLogin = false;
  String serverMessage = "";
  String userName = "";
  String userPassword = "";
  String token = "";

  Map<String, String> header = {};
  Map<String, String> headerWithAuth = {};
  factory ClientState() {
    return _instance;
  }

  Future<bool> login(String username, String password) async {
    final response = await postJsonRequest(
      BackEndConfig.loginString,
      header,
      {
        "email": username,
        "password": password
      },
    );

    serverMessage = response.body;
    if (response.statusCode == 200 &&
        serverMessage == "Login Successfully"
    ) {
      userName = username;
      userPassword = password;
      isLogin = true;
      token = "Basic ${base64Encode(utf8.encode('$username:$password'))}";
      return isLogin;
    }
    return false;
  }


  Future<bool> signup(String name, String password, String phoneNumber, String address) async {
    final response = await postJsonRequest(
      BackEndConfig.signUpAdminString,
      header,
      {
        "email": name,
        "password": password,
        "phoneNumber": phoneNumber,
        "address": address
      }
    );
    serverMessage = response.body;
    if (response.statusCode == 201) {
      isLogin = true;
      userName = name;
      userPassword = password;
      return true;
    }
    return false;
  }

  bool logout() {
    if (isLogin) {
      isLogin = false;
      return true;
    }
    return false;
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
    final response = await getRequest("${BackEndConfig.getProductByCategory}/$categoryID");
    serverMessage = response.body;
    if (response.statusCode == 200) {
      final parser = json.decode(serverMessage).cast<Map<String, dynamic>>();
      return parser.map<Product>((json) => Product.fromJson(json)).toList();
    }
    return [];
  }



  ClientState._internal() {
    header.addEntries({"Accept": "*/*"}.entries);
    header.addEntries({"Content-Type": "application/json; charset=UTF-8"}.entries);
  }
}
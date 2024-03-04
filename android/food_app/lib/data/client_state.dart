import 'dart:convert';

import 'package:food_app/Utils/dialog.dart';
import 'package:food_app/Utils/network.dart';
import 'package:food_app/constants/backend_config.dart';

class ClientState { // Singleton
  static final ClientState _instance = ClientState._internal();

  bool isLogin = false;
  String userRole = "";
  String serverMessage = "";
  String userName = "";
  String userPassword = "";

  Map<String, String> header = {};

  factory ClientState() {
    return _instance;
  }

  Future<bool> login(String username, String password) async {
    final response = await postJsonRequest(
      "${BackEndConfig.serverAddr}/api/auth/login",
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
      return isLogin;
    }
    return false;
  }

  Future<bool> signup(String name, String password, String phoneNumber, String address) async {
    final response = await postJsonRequest(
      "${BackEndConfig.serverAddr}/api/auth/register",
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

  Future<List<Map<String, String>>> getAllCategories() async {
    final response = await getRequest("${BackEndConfig.serverAddr}/api/categories");
    serverMessage = response.body;
    if (response.statusCode == 200) {
      return json.decode(serverMessage).cast<Map<String, String>>();
    }
    return [];
  }

  ClientState._internal() {
    header.addEntries({"Accept": "*/*"}.entries);
    header.addEntries({"Content-Type": "application/json"}.entries);
  }
}
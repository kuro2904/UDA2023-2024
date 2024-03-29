import 'dart:convert';
import 'package:food_app/data/OrderDetail.dart';
import 'package:food_app/utils/network.dart';
import 'package:food_app/constants/backend_config.dart';

class ClientState { // Singleton
  static final ClientState _instance = ClientState._internal();

  bool isLogin = false;
  String serverMessage = "";
  String userName = "";
  String userPassword = "";
  String token = "";
  List<OrderDetail> cart = [];

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
      token = "Basic ${base64Encode(utf8.encode('$userName:$userPassword'))}";
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
      token = "Basic ${base64Encode(utf8.encode('$userName:$userPassword'))}";
      return isLogin;
    }
    return false;
  }

  /// clearCart is optional for clearing cart on logout
  bool logout({ bool clearCart = false }) {
    if (isLogin) {
      isLogin = false; // set current state to not log in
      if (clearCart) {
        cart.clear();
      }
      return true;
    }
    return false;
  }

  ClientState._internal() {
    header.addAll({
      "Accept": "*/*",
      "Content-Type": "application/json; charset=UTF-8",
    });
    // header.addEntries({"Accept": "*/*"}.entries);
    // header.addEntries({"Content-Type": "application/json; charset=UTF-8"}.entries);
  }
}
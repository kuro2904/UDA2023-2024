import 'dart:convert';

import 'package:food_app/data/client_state.dart';
import 'package:food_app/utils/network.dart';

import '../constants/backend_config.dart';

class DeliveryMan {
  final String id;
  final String name;

  const DeliveryMan({required this.id, required this.name});

  factory DeliveryMan.fromJson(Map<String, dynamic> data) {
    return switch (data) {
      {'id': String id, 'name': String name} => DeliveryMan(id: id, name: name),
      _ => throw const FormatException('Failed to load Delivery Man')
    };
  }

  /// ## Fetch all delivery man
  ///
  /// return empty list for all kind of error to prevent app crashing
  static Future<List<DeliveryMan>> fetchAll() async {
    final response = await getRequest(BackEndConfig.fetchAllDeliveryMenString);
    if (response.statusCode == 200) {
      final parser = json.decode(response.body).cast<Map<String, dynamic>>();
      return parser.map<DeliveryMan>((json) => DeliveryMan.fromJson(json)).toList();
    }
    return [];
  }

  /// ## Insert delivery man
  ///
  /// ### Input:
  ///
  ///   **<span style="color: yellow">[id]</span>** id
  ///
  ///   **<span style="color: yellow">[name]</span>** name
  ///
  /// ### Return:
  ///
  ///   **<span style="color: blue">true</span>** when success
  ///
  ///   **<span style="color: red">false</span>** when error occurred
  static Future<bool> insert(String id, String name) async {
    Map<String,String> body = {
      'id':id,
      'name':name
    };
    final response = await postJsonRequest(BackEndConfig.insertDeliveryManString, ClientState().headerWithAuth, body);
    if (response.statusCode == 201) {
      return true;
    }
    // NOTE: Log error if needed
    return false;
  }

  /// ## Update delivery man
  ///
  /// ### Input:
  ///
  ///   **<span style="color: yellow">[id]</span>** id
  ///
  ///   **<span style="color: yellow">[name]</span>** name
  ///
  /// ### Return:
  ///
  ///   **<span style="color: blue">true</span>** when success
  ///
  ///   **<span style="color: red">false</span>** when error occurred
  static Future<bool> update(String id, String name) async {
    Map<String, String> body = {
      'name': name
    };
    final response = await putJsonRequest(BackEndConfig.updateDeliveryManString+id, ClientState().headerWithAuth, body);
    if (response.statusCode == 200) {
      return true;
    }
    // NOTE: Log error if needed
    return false;
  }

  /// ## Delete delivery man
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
    final response = await deleteRequest(BackEndConfig.deleteDeliveryManString + id, headers: ClientState().headerWithAuth);
    if (response.statusCode == 200) {
      return true;
    }
    // NOTE: Log error if needed
    return false;
  }
}

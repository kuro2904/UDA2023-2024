import 'dart:convert';

import 'package:food_app/data/client_state.dart';
import 'package:food_app/utils/network.dart';

import '../constants/backend_config.dart';

class Discount {
  final String id;
  final int discountPercent;
  final String startDate;
  final String expiredDate;

  const Discount(
      {required this.id,
      required this.discountPercent,
      required this.startDate,
      required this.expiredDate});

  factory Discount.fromJson(Map<String, dynamic> data){
    return switch (data) {
      {
      'id': String id,
      'discount_percent': int discountPercent,
      'start_date': String startDate,
      'expire_date': String expiredDate
      } =>
          Discount(id: id,
              discountPercent: discountPercent,
              startDate: startDate,
              expiredDate: expiredDate),
      _ => throw const FormatException('Failed to load Discount'),
    };
  }
  
  /// Fetch all Discount
  /// 
  /// return empty list on error
  static Future<List<Discount>> fetchAll() async {
    final response = await getRequest(BackEndConfig.fetchAllDiscountString);
    if (response.statusCode == 200) {
      final parser = json.decode(response.body).cast<Map<String, dynamic>>();
      return parser.map<Discount>((json) => Discount.fromJson(json)).toList();
    }
    // NOTE: log error if needed
    return [];
  }

  /// ## Insert discount
  ///
  ///
  /// ### input:
  ///
  ///   **<span style="color: yellow">[id]</span>** discount id
  ///
  ///   **<span style="color: yellow">[discountPercent]</span>** discount percentage
  ///
  ///   **<span style="color: yellow">[startDate]</span>** start date of discount
  ///
  ///   **<span style="color: yellow">[expiredDate]</span>** expired date of discount
  ///
  ///
  /// ### return:
  ///
  ///   **<span style="color: blue">true</span>** when success
  ///
  ///   **<span style="color: red">false</span>** when error occurred
  static Future<bool> insert(
      String id,
      int discountPercent,
      String startDate,
      String expiredDate) async {
    Map<String,dynamic> body = {
      'id': id,
      'discount_percent': discountPercent,
      'start_date': startDate,
      'expire_date': expiredDate
    };
    final response = await postJsonRequest(BackEndConfig.insertDiscountString, ClientState().headerWithAuth, body);
    if (response.statusCode == 201) {
      return true;
    }
    // NOTE: log error if needed
    return false;
  }
}

import 'dart:convert';

import 'package:food_app/constants/backend_config.dart';
import 'package:food_app/data/client_state.dart';
import 'package:food_app/data/payment_method.dart';
import 'package:food_app/utils/network.dart';

import 'OrderDetail.dart';
import 'discount.dart';

class Order {
  final String id;
  final String customerId;
  final String cusPhone;
  final String cusAddress;
  final String createDate;
  final String discount;
  final String paymentMethod;
  final List<OrderDetail> details = [];

  Order(this.id, this.customerId, this.discount,
      {required this.cusAddress,
      required this.cusPhone,
      required this.createDate,
      required this.paymentMethod,});

  /// ## Make Order
  ///
  /// ### input:
  ///
  ///   **<span style="color: yellow">[cusPhone]</span>** customer phone number
  ///
  ///   **<span style="color: yellow">[cusAddress]</span>** customer delivery address
  ///
  ///   **<span style="color: yellow">[paymentMethod]</span>** payment method
  ///
  ///   **<span style="color: yellow">[discount]</span>** bill discount
  ///
  ///   **<span style="color: yellow">[onResponseMessage]</span>** server response status code and message use for debug or else
  ///
  /// ### return:
  ///
  ///   **<span style="color: blue">true</span>** when success
  ///
  ///   **<span style="color: red">false</span>** when error occurred
  static Future<bool> makeOrder(String cusPhone, String cusAddress, PaymentMethod paymentMethod,
      {Discount? discount, void Function(int, String)? onResponseMessage}) async {
    Map<String, dynamic> body = {
      'cus_phone': cusPhone,
      'cus_address': cusAddress,
      'paymentMethod': paymentMethod.name,
      'discountId': discount?.id.toString(),
      'createDate': DateTime.now().toString(),
      'status': 'REQUEST',
      'details': ClientState().cart
    };
    var response = await postJsonRequest(BackEndConfig.placeOrderString, ClientState().header, body);
    if (onResponseMessage != null) {
      onResponseMessage(response.statusCode, response.body);
    }
    if (response.statusCode == 201) {
      return true;
    }
    return false;
  }

  /// ## Fetch all orders of current user
  ///
  /// return empty list for all kind of error to prevent app crashing
  static Future<List<Order>> fetchAll() async {
    if (!ClientState().isLogin) {
      return [];
    }
    Map<String, String> query = {'userEmail': ClientState().userName};
    final response = await getRequest(BackEndConfig.fetchHistoryOrder + ClientState().userName, headers: ClientState().header, query: query);
    if (response.statusCode == 200) {
      final parser = jsonDecode(response.body).cast<Map<String, dynamic>>();
      return parser
          .map<Order>((json) => Order(
          json['id'], json['user_email'], json['discountId'] ?? 'No discount',
          cusAddress: json['cus_address'],
          cusPhone: json['cus_phone'],
          createDate: json['createDate'],
          paymentMethod: json['paymentMethod']))
          .toList();
    }
    return [];
  }
}

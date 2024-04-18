import 'dart:convert';

import 'package:food_app/data/product.dart';

class OrderDetail {
  int? id;
  int quantity;
  final Product product;
  final String? totalPrice;
  List<int>? toppings;
  double? selectionPrice;

  OrderDetail({
    this.id,
    this.totalPrice,
    required this.quantity,
    required this.product,
    this.toppings,
    this.selectionPrice
  });

  static Future<OrderDetail> fromJson(Map<String, dynamic> json) async {
    final toppingList = json['topping'] as List<dynamic>;
    final topping = toppingList.map((e) => e['id'] as int).toList();

    final productId = json['productId'] as String;
    final product = await Product.getProduct(productId);

    return OrderDetail(quantity: json['quantity'] as int, product: product, toppings: topping);
  }

  Map<String, dynamic> toJson() {
    final data = {
      'quantity': quantity,
      'productId': product.id
    };
    if (toppings != null) {
      List<Map<String, dynamic>> listToppings = [];
      for (var i in toppings!) {
        listToppings.add({ 'id': i });
      }
      data['topping'] = listToppings;
    }
    return data;
  }

  double getTotalPrice() {
    String productPriceString = product.price.replaceAll('k VND', '');
    double productPrice = double.parse(productPriceString);
    if (selectionPrice != null) {
      productPrice += (selectionPrice! / 1000);
    }
    return productPrice * quantity;
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }

  static Future<OrderDetail> fromString(String data) async {
    final jsonData = json.decode(data);
    final result = await fromJson(jsonData);
    return result;
  }

}

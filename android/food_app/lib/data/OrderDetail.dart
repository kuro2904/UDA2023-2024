import 'package:food_app/data/product.dart';

class OrderDetail{
  final String id;
  int quantity;
  final String productId;
  String totalPrice;

  OrderDetail(this.id, this.totalPrice, { required this.quantity, required this.productId});

}
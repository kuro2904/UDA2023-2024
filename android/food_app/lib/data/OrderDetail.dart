import 'package:food_app/data/product.dart';

class OrderDetail{
  final String id;
  int quantity;
  final Product product;
  final String totalPrice;

  OrderDetail(this.id, this.totalPrice, { required this.quantity, required this.product});

}
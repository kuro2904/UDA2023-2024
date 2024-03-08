import 'package:food_app/data/product.dart';

class OrderDetail{
  final String id;
  final int quantity;
  final Set<Product> products;
  final String totalPrice;

  OrderDetail(this.id, this.totalPrice, { required this.quantity, required this.products});

}
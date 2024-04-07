import 'package:food_app/data/product.dart';

class OrderDetail {
  int? id;
  int quantity;
  final Product product;
  final String? totalPrice;

  OrderDetail({
    this.id,
    this.totalPrice,
    required this.quantity,
    required this.product,
  });

  Map toJson() => {
        'quantity': quantity,
        'productId': product.id,
        'total_price': totalPrice
      };
}

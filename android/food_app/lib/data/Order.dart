import 'package:food_app/data/discount.dart';
import 'package:food_app/data/payment_method.dart';
import 'package:food_app/data/user.dart';

import 'OrderDetail.dart';

class Order {
  final String id;
  final User customer;
  final String cusPhone;
  final String cusAddress;
  final String createDate;
  final Discount discount;
  final PaymentMethod paymentMethod;
  final List<OrderDetail> details = [];

  Order(this.id, this.customer, this.discount,
      {required this.cusAddress,
      required this.cusPhone,
      required this.createDate,
      required this.paymentMethod,});
}

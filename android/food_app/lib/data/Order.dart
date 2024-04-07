import 'OrderDetail.dart';

class Order {
  final String id;
  final String customerId;
  final String cusPhone;
  final String cusAddress;
  final String createDate;
  final String discount;
  final String paymentMethod;
  final List<OrderDetail> details = [];

  Order(
    this.id,
    this.customerId,
    this.discount, {
    required this.cusAddress,
    required this.cusPhone,
    required this.createDate,
    required this.paymentMethod,
  });
}

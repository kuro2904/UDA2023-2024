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

  factory Discount.fromJson(Map<String, dynamic> data) {
    return switch (data) {
      {
        'id': String id,
        'discount_percent': int discountPercent,
        'start_date': String startDate,
        'expire_date': String expiredDate
      } =>
        Discount(
            id: id,
            discountPercent: discountPercent,
            startDate: startDate,
            expiredDate: expiredDate),
      _ => throw const FormatException('Failed to load Discount'),
    };
  }
}

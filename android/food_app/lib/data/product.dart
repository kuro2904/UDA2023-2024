import 'dart:convert';

class Product {
  final String id;
  final String name;
  final String price;
  final String description;
  String? imageUrl;

  Product(
      {required this.id,
      required this.name,
      required this.price,
      required this.description,
      this.imageUrl});

  factory Product.fromJson(Map<String, dynamic> data) {
    return switch (data) {
      {
        'id': String id,
        'name': String name,
        'price': String price,
        'description': String description,
      } =>
        Product(
            id: id,
            name: name,
            price: price,
            description: description,
            imageUrl:
                data['imageUrl'] != null ? data['imageUrl'].toString() : ''),
      _ => throw const FormatException('Failed to load Product'),
    };
  }
}

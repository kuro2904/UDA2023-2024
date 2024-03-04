import 'dart:convert';

class Product {
  final String id;
  final String name;
  final String price;
  final String description;
  final String imageUrl;

  const Product(
      {required this.id,
      required this.name,
      required this.price,
      required this.description,
      required this.imageUrl});

  factory Product.fromJson(Map<String, dynamic> data) {
    return switch (data) {
      {
        'id': String id,
        'name': String name,
        'price': String price,
        'description': String description,
        'imageUrl': String imageUrl
      } =>
        Product(
            id: id,
            name: name,
            price: price,
            description: description,
            imageUrl: imageUrl),
      _ => throw const FormatException('Failed to load Product'),
    };
  }
}

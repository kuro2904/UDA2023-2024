import 'package:flutter/foundation.dart';

class Category {
  final String id;
  final String name;
  final String description;
  final String imageUrl;

  Category(
      {required this.id,
      required this.name,
      required this.description,
      required this.imageUrl});

  factory Category.fromJson(Map<String, dynamic> data) {
    return switch (data) {
      {
        'id': String id,
        'name': String name,
        'description': String description,
        'imageUrl': String imageUrl
      } =>
        Category(
            id: id, name: name, description: description, imageUrl: imageUrl),
      _ => throw const FormatException('Failed to load Category')
    };
  }
}

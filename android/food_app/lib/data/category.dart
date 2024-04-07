class Category {
  final String id;
  final String name;
  final String description;
  String? imageUrl;

  Category(
      {required this.id,
      required this.name,
      required this.description,
      this.imageUrl});

  factory Category.fromJson(Map<String, dynamic> data) {
    return switch (data) {
      {
        'id': String id,
        'name': String name,
        'description': String description,
      } =>
        Category(
            id: id,
            name: name,
            description: description,
            imageUrl:
                data['imageUrl'] != null ? data['imageUrl'].toString() : ''),
      _ => throw const FormatException('Failed to load Category')
    };
  }

  Map<String, String> toJson() =>
      {'id': id, 'name': name, 'description': description};
}

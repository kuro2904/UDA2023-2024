class DeliveryMan {
  final String id;
  final String name;

  const DeliveryMan({required this.id, required this.name});

  factory DeliveryMan.fromJson(Map<String, dynamic> data) {
    return switch (data) {
      {'id': String id, 'name': String name} => DeliveryMan(id: id, name: name),
      _ => throw const FormatException('Failed to load Delivery Man')
    };
  }
}

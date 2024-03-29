class User {
  final String id;
  final String email;
  final String phoneNumber;
  final String password;
  final String address;

  const User(
      {required this.id,
        required this.email,
        required this.password,
        required this.address,
        required this.phoneNumber});

  factory User.fromJson(Map<String, String> data) {
    return switch (data) {
      {
      'id': String id,
      'email': String email,
      'phoneNumber': String phoneNumber,
      'password': String password,
      'address': String address
      } =>
          User(
              id: id,
              email: email,
              password: password,
              phoneNumber: phoneNumber,
              address: address),
      _ => throw const FormatException('Failed to load User')
    };
  }
}

class User {
  final String id;
  final String email;
  final String name;
  final String? phone;
  final String? address;

  User({
    required this.id,
    required this.email,
    required this.name,
    this.phone,
    this.address,
  });

  User copyWith({
    String? id,
    String? email,
    String? name,
    String? phone,
    String? address,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      address: address ?? this.address,
    );
  }
}
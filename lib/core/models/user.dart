class User {
  final String id;
  final String email;
  final String name;
  final String? phone;
  final String? address;
  final DateTime? dateOfBirth;        // Add this
  final String? profileImageUrl;      // Add this
  final DateTime createdAt;           // Add this
  final DateTime updatedAt;           // Add this

  User({
    required this.id,
    required this.email,
    required this.name,
    this.phone,
    this.address,
    this.dateOfBirth,
    this.profileImageUrl,
    required this.createdAt,          // Make required or provide default
    required this.updatedAt,          // Make required or provide default
  });

  User copyWith({
    String? id,
    String? email,
    String? name,
    String? phone,
    String? address,
    DateTime? dateOfBirth,
    String? profileImageUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // Helper method to create a demo user
  static User createDemoUser() {
    final now = DateTime.now();
    return User(
      id: '1',
      email: 'demo@storelytech.com',
      name: 'John Doe',
      phone: '+1 (555) 123-4567',
      address: '123 Main Street, New York, NY 10001',
      dateOfBirth: DateTime(1990, 5, 15),
      profileImageUrl: null,
      createdAt: now,
      updatedAt: now,
    );
  }
}
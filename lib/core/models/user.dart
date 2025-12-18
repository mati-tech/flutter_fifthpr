class User {
  final int id;
  final String name;
  final String email;
  final bool isActive;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.isActive,
  });

  User copyWith({
    int? id,
    String? email,
    String? name,
    bool? isActive,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      isActive: isActive ?? this.isActive, // Исправлено: было null
    );
  }

  // Для отладки
  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email, isActive: $isActive)';
  }
}
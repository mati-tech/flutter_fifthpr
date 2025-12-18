// lib/data/dtos/user_dto.dart
/// DTO that matches the FastAPI User model:
/// id: int, username: str, email: str, is_active: bool
/// We keep some optional extras for backward compatibility.
class UserDto {
  final String id; // stored as String, backend sends int
  final String username;
  final String email;
  final bool isActive;

  // Optional extras (legacy fields)
  final String? name; // alias for username used in existing UI
  final String? phone;
  final String? address;
  final String? dateOfBirth;
  final String? profileImageUrl;
  final String? createdAt;
  final String? updatedAt;
  final String? token; // JWT token

  UserDto({
    required this.id,
    required this.username,
    required this.email,
    required this.isActive,
    this.name,
    this.phone,
    this.address,
    this.dateOfBirth,
    this.profileImageUrl,
    this.createdAt,
    this.updatedAt,
    this.token,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      id: json['id']?.toString() ?? '',
      username: json['username']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      isActive: json['is_active'] as bool? ?? true,
      // Legacy / optional fields
      name: json['name']?.toString() ?? json['username']?.toString(),
      phone: json['phone']?.toString(),
      address: json['address']?.toString(),
      dateOfBirth: json['date_of_birth']?.toString() ?? json['dateOfBirth']?.toString(),
      profileImageUrl: json['profile_image_url']?.toString() ?? json['profileImageUrl']?.toString(),
      createdAt: json['created_at']?.toString() ?? json['createdAt']?.toString(),
      updatedAt: json['updated_at']?.toString() ?? json['updatedAt']?.toString(),
      token: json['token']?.toString() ?? json['access_token']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'is_active': isActive,
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
      if (address != null) 'address': address,
      if (dateOfBirth != null) 'date_of_birth': dateOfBirth,
      if (profileImageUrl != null) 'profile_image_url': profileImageUrl,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (token != null) 'token': token,
    };
  }
}
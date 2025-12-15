// lib/data/dtos/user_dto.dart

class UserDto {
  final String id;
  final String email;
  final String name;
  final String? phone;
  final String? address;
  final String? dateOfBirth;
  final String? profileImageUrl;
  final String createdAt;
  final String updatedAt;
  final String? token; // JWT token

  UserDto({
    required this.id,
    required this.email,
    required this.name,
    this.phone,
    this.address,
    this.dateOfBirth,
    this.profileImageUrl,
    required this.createdAt,
    required this.updatedAt,
    this.token,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      id: json['id']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      phone: json['phone']?.toString(),
      address: json['address']?.toString(),
      dateOfBirth: json['date_of_birth']?.toString() ?? json['dateOfBirth']?.toString(),
      profileImageUrl: json['profile_image_url']?.toString() ?? json['profileImageUrl']?.toString(),
      createdAt: json['created_at']?.toString() ?? json['createdAt']?.toString() ?? '',
      updatedAt: json['updated_at']?.toString() ?? json['updatedAt']?.toString() ?? '',
      token: json['token']?.toString() ?? json['access_token']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      if (phone != null) 'phone': phone,
      if (address != null) 'address': address,
      if (dateOfBirth != null) 'date_of_birth': dateOfBirth,
      if (profileImageUrl != null) 'profile_image_url': profileImageUrl,
      'created_at': createdAt,
      'updated_at': updatedAt,
      if (token != null) 'token': token,
    };
  }
}
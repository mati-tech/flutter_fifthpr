import 'package:json_annotation/json_annotation.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserDto {
  final int id;
  final String email;
  final String username;
  final String password;
  @JsonKey(name: 'name')
  final Map<String, dynamic> name;
  final String phone;

  UserDto({
    required this.id,
    required this.email,
    required this.username,
    required this.password,
    required this.name,
    required this.phone,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);
}
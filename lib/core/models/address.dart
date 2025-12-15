/// Domain entity representing a shipping/billing address
/// Pure Dart class - no Flutter dependencies
class Address {
  final String id;
  final String street;
  final String city;
  final String state;
  final String zipCode;
  final String country;
  final String? apartment;
  final bool isDefault;

  Address({
    required this.id,
    required this.street,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.country,
    this.apartment,
    this.isDefault = false,
  });

  String get fullAddress {
    final parts = [
      street,
      if (apartment != null) apartment,
      city,
      state,
      zipCode,
      country,
    ].where((part) => part != null).toList();
    return parts.join(', ');
  }

  Address copyWith({
    String? id,
    String? street,
    String? city,
    String? state,
    String? zipCode,
    String? country,
    String? apartment,
    bool? isDefault,
  }) {
    return Address(
      id: id ?? this.id,
      street: street ?? this.street,
      city: city ?? this.city,
      state: state ?? this.state,
      zipCode: zipCode ?? this.zipCode,
      country: country ?? this.country,
      apartment: apartment ?? this.apartment,
      isDefault: isDefault ?? this.isDefault,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Address &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'Address(id: $id, fullAddress: $fullAddress)';
}


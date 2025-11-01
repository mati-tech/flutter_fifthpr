import 'package:flutter/material.dart';
import '../../auth/models/user.dart';

class ProfileContainer extends ChangeNotifier {
  User? _currentUser;
  bool _isLoading = false;

  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;


  // Add a method to initialize with sample data for testing
  void initializeWithSampleUser() {
    _currentUser = User(
      id: '1',
      name: 'John Doe',
      email: 'john.doe@example.com',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      // Add other required fields from your User model
    );
    notifyListeners();
  }

  void setUser(User user) {
    _currentUser = user;
    notifyListeners();
  }

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void updateProfile({
    String? name,
    String? phone,
    String? address,
    DateTime? dateOfBirth,
    String? profileImageUrl,
  }) {
    if (_currentUser != null) {
      _currentUser = _currentUser!.copyWith(
        name: name,
        phone: phone,
        address: address,
        dateOfBirth: dateOfBirth,
        profileImageUrl: profileImageUrl,
        updatedAt: DateTime.now(),
      );
      notifyListeners();
    }
  }

  Future<void> saveProfileChanges() async {
    if (_currentUser == null) return;

    setLoading(true);

    // Simulate API call to save profile
    await Future.delayed(const Duration(seconds: 2));

    setLoading(false);

    // In real app, you would save to backend here
  }

  Future<void> uploadProfileImage(String imageUrl) async {
    setLoading(true);

    // Simulate image upload
    await Future.delayed(const Duration(seconds: 1));

    updateProfile(profileImageUrl: imageUrl);
    setLoading(false);
  }
}
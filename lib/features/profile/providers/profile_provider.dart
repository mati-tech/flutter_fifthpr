import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../auth/models/user.dart';

part 'profile_provider.g.dart';

@riverpod
class ProfileNotifier extends _$ProfileNotifier {
  @override
  ProfileState build() {
    // Initialize with sample user for testing
    final sampleUser = User(
      id: '1',
      name: 'John Doe',
      email: 'john.doe@example.com',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    return ProfileState(
      currentUser: sampleUser,

      isLoading: false,
    );
  }

  void setUser(User user) {
    state = state.copyWith(currentUser: user);
  }

  void setLoading(bool loading) {
    state = state.copyWith(isLoading: loading);
  }

  void updateProfile({
    String? name,
    String? phone,
    String? address,
    DateTime? dateOfBirth,
    String? profileImageUrl,
  }) {
    if (state.currentUser != null) {
      state = state.copyWith(
        currentUser: state.currentUser!.copyWith(
          name: name,
          phone: phone,
          address: address,
          dateOfBirth: dateOfBirth,
          profileImageUrl: profileImageUrl,
          updatedAt: DateTime.now(),
        ),
      );
    }
  }

  Future<void> saveProfileChanges() async {
    if (state.currentUser == null) return;

    state = state.copyWith(isLoading: true);

    // Simulate API call to save profile
    await Future.delayed(const Duration(seconds: 2));

    state = state.copyWith(isLoading: false);

    // In real app, you would save to backend here
  }

  Future<void> uploadProfileImage(String imageUrl) async {
    state = state.copyWith(isLoading: true);

    // Simulate image upload
    await Future.delayed(const Duration(seconds: 1));

    updateProfile(profileImageUrl: imageUrl);
    state = state.copyWith(isLoading: false);
  }
}

class ProfileState {
  final User? currentUser;
  final bool isLoading;

  ProfileState({
    required this.currentUser,
    required this.isLoading,
  });

  ProfileState copyWith({
    User? currentUser,
    bool? isLoading,
  }) {
    return ProfileState(
      currentUser: currentUser ?? this.currentUser,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}


import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/user.dart';


part 'auth_provider.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  AuthState build() {
    return AuthState(
      currentUser: null,
      isLoading: false,
    );
  }

  void setUser(User user) {
    state = state.copyWith(currentUser: user);
  }

  void setLoading(bool loading) {
    state = state.copyWith(isLoading: loading);
  }

  void logout() {
    state = state.copyWith(currentUser: null);
  }

  void updateProfile({String? name, String? phone, String? address}) {
    if (state.currentUser != null) {
      state = state.copyWith(
        currentUser: state.currentUser!.copyWith(
          name: name,
          phone: phone,
          address: address,
        ),
      );
    }
  }
}

class AuthState {
  final User? currentUser;
  final bool isLoading;

  AuthState({
    required this.currentUser,
    required this.isLoading,
  });

  bool get isLoggedIn => currentUser != null;

  AuthState copyWith({
    User? currentUser,
    bool? isLoading,
  }) {
    return AuthState(
      currentUser: currentUser ?? this.currentUser,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}




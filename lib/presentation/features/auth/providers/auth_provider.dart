// lib/presentation/features/auth/providers/auth_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../data/datasources/Remote/auth_api_datasource.dart';
import '../../../../data/repositories/auth_repository_impl.dart';
import '../../../../core/models/user.dart';
import '../../../../domain/usecases/user/get_currentuser_usecase.dart';
import '../../../../domain/usecases/user/login_usecase.dart';
import '../../../../domain/usecases/user/logout_usecase.dart';
import '../../../../domain/usecases/user/register_usecase.dart';
import '../../../../domain/usecases/user/update_profile_usecase.dart';
import '../../../shared/api_client_provider.dart';

part 'auth_provider.g.dart';

// ========== DEPENDENCY PROVIDERS (Using Riverpod Generator) ==========

@riverpod
AuthApiDataSource authDataSource(AuthDataSourceRef ref) {
  final apiClient = ref.watch(apiClientProvider);
  return FastApiAuthApiDataSource(apiClient);
}

@riverpod
AuthRepositoryImpl authRepository(AuthRepositoryRef ref) {
  final dataSource = ref.watch(authDataSourceProvider);
  return AuthRepositoryImpl(dataSource);
}

@riverpod
RegisterUseCase registerUseCase(RegisterUseCaseRef ref) {
  final repository = ref.watch(authRepositoryProvider);
  return RegisterUseCase(repository);
}

@riverpod
LoginUseCase loginUseCase(LoginUseCaseRef ref) {
  final repository = ref.watch(authRepositoryProvider);
  return LoginUseCase(repository);
}

@riverpod
GetCurrentUserUseCase getCurrentUserUseCase(GetCurrentUserUseCaseRef ref) {
  final repository = ref.watch(authRepositoryProvider);
  return GetCurrentUserUseCase(repository);
}

@riverpod
LogoutUseCase logoutUseCase(LogoutUseCaseRef ref) {
  final repository = ref.watch(authRepositoryProvider);
  return LogoutUseCase(repository);
}

@riverpod
UpdateProfileUseCase updateProfileUseCase(UpdateProfileUseCaseRef ref) {
  final repository = ref.watch(authRepositoryProvider);
  return UpdateProfileUseCase(repository);
}



// ========== AUTH STATE NOTIFIER ==========

@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  AuthState build() {
    // Check login status on startup
    _checkInitialLoginStatus();
    return const AuthState();
  }

  Future<void> _checkInitialLoginStatus() async {
    try {
      final useCase = ref.read(getCurrentUserUseCaseProvider);
      final user = await useCase.execute();

      if (user != null) {
        state = state.copyWith(
          currentUser: user,
          isLoading: false,
        );
      }
    } catch (e) {
      // User not logged in, keep null
    }
  }

  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final useCase = ref.read(loginUseCaseProvider);
      final user = await useCase.execute(email: email, password: password);

      state = state.copyWith(
        currentUser: user,
        isLoading: false,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      rethrow;
    }
  }

  Future<void> register({
    required String username,
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final useCase = ref.read(registerUseCaseProvider);
      final user = await useCase.execute(
        username: username,
        email: email,
        password: password,
      );

      state = state.copyWith(
        currentUser: user,
        isLoading: false,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      rethrow;
    }
  }


  Future<void> logout() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final useCase = ref.read(logoutUseCaseProvider);
      await useCase.execute();

      state = const AuthState(); // Reset to initial state
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      rethrow;
    }
  }

  Future<void> updateProfile({
    required String name,
    String? phone,
    String? address,
    DateTime? dateOfBirth,
    String? profileImageUrl,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final useCase = ref.read(updateProfileUseCaseProvider);
      final updatedUser = await useCase.execute(
        name: name,
        phone: phone,
        address: address,
        dateOfBirth: dateOfBirth,
        profileImageUrl: profileImageUrl,
      );

      state = state.copyWith(
        currentUser: updatedUser,
        isLoading: false,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      rethrow;
    }
  }







  void clearError() {
    if (state.error != null) {
      state = state.copyWith(error: null);
    }
  }

  // Helper method (kept from your old provider)
  void setUser(User user) {
    state = state.copyWith(currentUser: user);
  }
}

// ========== AUTH STATE ==========

class AuthState {
  final User? currentUser;
  final bool isLoading;
  final String? error;

  const AuthState({
    this.currentUser,
    this.isLoading = false,
    this.error,
  });

  bool get isLoggedIn => currentUser != null;

  AuthState copyWith({
    User? currentUser,
    bool? isLoading,
    String? error,
  }) {
    return AuthState(
      currentUser: currentUser ?? this.currentUser,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
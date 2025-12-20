import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/user.dart';
import '../../../../data/repositories/providers.dart';
import '../../../../domain/usecases/product/providers.dart';
import '../../../../domain/usecases/user/get_currentuser_usecase.dart';
import '../../../../domain/usecases/user/delete_account_usecase.dart'; // Добавьте импорт

/// =======================================================
/// PROFILE PROVIDER
/// =======================================================
final profileProvider = StateNotifierProvider<ProfileNotifier, ProfileState>((ref) {
  final getUserByIdUseCase = ref.watch(getUserByIdUseCaseProvider);
  final deleteUserByIdUseCase = ref.watch(deleteUserByIdUseCaseProvider); // Добавьте
  return ProfileNotifier(getUserByIdUseCase, deleteUserByIdUseCase)..initialize();
});

// Провайдер для DeleteUserByIdUseCase
final deleteUserByIdUseCaseProvider = Provider<DeleteUserByIdUseCase>((ref) {
  final repository = ref.watch(productRepositoryProvider);
  return DeleteUserByIdUseCase(repository);
});

/// =======================================================
/// PROFILE STATE NOTIFIER
/// =======================================================
class ProfileNotifier extends StateNotifier<ProfileState> {
  final GetUserByIdUseCase _getUserByIdUseCase;
  final DeleteUserByIdUseCase _deleteUserByIdUseCase; // Добавьте

  ProfileNotifier(
      this._getUserByIdUseCase,
      this._deleteUserByIdUseCase, // Добавьте в конструктор
      ) : super(const ProfileState());

  /// Load user profile
  Future<void> initialize() async {
    state = state.copyWith(isLoading: true);
    try {
      // Используем ID текущего пользователя
      final user = await _getUserByIdUseCase.execute(1);
      state = state.copyWith(
        user: user,
        isLoading: false,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Refresh profile
  Future<void> refresh() async {
    state = state.copyWith(isRefreshing: true);
    try {
      final user = await _getUserByIdUseCase.execute(1);
      state = state.copyWith(
        user: user,
        isRefreshing: false,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(isRefreshing: false, error: e.toString());
    }
  }

  /// Delete user profile
  Future<void> deleteProfile() async {
    if (state.user == null) return;

    state = state.copyWith(isDeleting: true);
    try {
      final userId = state.user!.id;

      // Удаляем пользователя через UseCase
      await _deleteUserByIdUseCase.execute(userId);

      // После удаления очищаем состояние
      state = state.copyWith(
        user: null,
        isDeleting: false,
        error: null,
      );

      // Можно добавить навигацию на другой экран
      // Example: Navigator.of(context).pushReplacementNamed('/login');

    } catch (e) {
      state = state.copyWith(
        isDeleting: false,
        error: 'Failed to delete profile: $e',
      );
    }
  }

  /// Update user profile
  Future<void> updateProfile({
    String? firstname,
    String? lastname,
    String? phone,
    String? email,
  }) async {
    if (state.user == null) return;

    state = state.copyWith(isUpdating: true);
    try {
      final updatedUser = User(
        id: state.user!.id,
        email: email ?? state.user!.email,
        username: state.user!.username,
        password: state.user!.password,
        firstname: firstname ?? state.user!.firstname,
        lastname: lastname ?? state.user!.lastname,
        phone: phone ?? state.user!.phone,
      );

      // TODO: Отправить обновление на сервер
      // await _repository.updateUser(updatedUser);

      state = state.copyWith(
        user: updatedUser,
        isUpdating: false,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(isUpdating: false, error: e.toString());
    }
  }
}

/// =======================================================
/// PROFILE STATE
/// =======================================================
class ProfileState {
  final User? user;
  final bool isLoading;
  final bool isRefreshing;
  final bool isUpdating;
  final bool isDeleting; // Добавьте
  final String? error;

  const ProfileState({
    this.user,
    this.isLoading = false,
    this.isRefreshing = false,
    this.isUpdating = false,
    this.isDeleting = false, // Добавьте
    this.error,
  });

  ProfileState copyWith({
    User? user,
    bool? isLoading,
    bool? isRefreshing,
    bool? isUpdating,
    bool? isDeleting, // Добавьте
    String? error,
  }) =>
      ProfileState(
        user: user ?? this.user,
        isLoading: isLoading ?? this.isLoading,
        isRefreshing: isRefreshing ?? this.isRefreshing,
        isUpdating: isUpdating ?? this.isUpdating,
        isDeleting: isDeleting ?? this.isDeleting, // Добавьте
        error: error,
      );
}
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_provider.g.dart';

@riverpod
class SettingsNotifier extends _$SettingsNotifier {
  @override
  SettingsState build() {
    return SettingsState(
      notificationsEnabled: true,
      darkModeEnabled: false,
      currency: 'USD',
      language: 'English',
    );
  }

  void toggleNotifications(bool enabled) {
    state = state.copyWith(notificationsEnabled: enabled);
  }

  void toggleDarkMode(bool enabled) {
    state = state.copyWith(darkModeEnabled: enabled);
  }

  void setCurrency(String newCurrency) {
    state = state.copyWith(currency: newCurrency);
  }

  void setLanguage(String newLanguage) {
    state = state.copyWith(language: newLanguage);
  }
}

class SettingsState {
  final bool notificationsEnabled;
  final bool darkModeEnabled;
  final String currency;
  final String language;

  SettingsState({
    required this.notificationsEnabled,
    required this.darkModeEnabled,
    required this.currency,
    required this.language,
  });

  SettingsState copyWith({
    bool? notificationsEnabled,
    bool? darkModeEnabled,
    String? currency,
    String? language,
  }) {
    return SettingsState(
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      darkModeEnabled: darkModeEnabled ?? this.darkModeEnabled,
      currency: currency ?? this.currency,
      language: language ?? this.language,
    );
  }
}


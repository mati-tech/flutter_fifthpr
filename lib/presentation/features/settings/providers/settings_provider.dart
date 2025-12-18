// // lib/providers/settings_notifier.dart
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// // import '../../../data/datasources/local/shared_preferences.dart';
// // import '../data/datasources/local/shared_prefs_datasource.dart';
//
// class SettingsState {
//   final bool notificationsEnabled;
//   final bool isDarkMode;
//
//   SettingsState({
//     this.notificationsEnabled = true,
//     this.isDarkMode = false,
//   });
//
//   SettingsState copyWith({
//     bool? notificationsEnabled,
//     bool? isDarkMode,
//   }) {
//     return SettingsState(
//       notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
//       isDarkMode: isDarkMode ?? this.isDarkMode,
//     );
//   }
// }
//
// class SettingsNotifier extends StateNotifier<SettingsState> {
//   // final SharedPrefsDataSource _prefsDataSource;
//
//   SettingsNotifier(this._prefsDataSource) : super(SettingsState()) {
//     _loadSettings();
//   }
//
//   Future<void> _loadSettings() async {
//     try {
//       final notificationsEnabled = await _prefsDataSource.getNotificationsEnabled();
//       final isDarkMode = await _prefsDataSource.isDarkMode();
//
//       state = state.copyWith(
//         notificationsEnabled: notificationsEnabled,
//         isDarkMode: isDarkMode,
//       );
//     } catch (e) {
//       print('Ошибка загрузки настроек: $e');
//     }
//   }
//
//   Future<void> toggleNotifications(bool value) async {
//     await _prefsDataSource.setNotificationsEnabled(value);
//     state = state.copyWith(notificationsEnabled: value);
//   }
//
//   Future<void> toggleDarkMode(bool value) async {
//     await _prefsDataSource.setDarkMode(value);
//     state = state.copyWith(isDarkMode: value);
//   }
// }
//
// // Provider
// final settingsNotifierProvider = StateNotifierProvider<SettingsNotifier, SettingsState>(
//       (ref) {
//     final prefsDataSource = SharedPrefsDataSource();
//     return SettingsNotifier(prefsDataSource);
//   },
// );
//
//
//
//
// import 'package:riverpod_annotation/riverpod_annotation.dart';
//
// part 'settings_provider.g.dart';
//
// @riverpod
// class SettingsNotifier extends _$SettingsNotifier {
//   @override
//   SettingsState build() {
//     return SettingsState(
//       notificationsEnabled: true,
//       darkModeEnabled: false,
//       currency: 'USD',
//       language: 'English',
//     );
//   }
//
//   void toggleNotifications(bool enabled) {
//     state = state.copyWith(notificationsEnabled: enabled);
//   }
//
//   void toggleDarkMode(bool enabled) {
//     state = state.copyWith(darkModeEnabled: enabled);
//   }
//
//   void setCurrency(String newCurrency) {
//     state = state.copyWith(currency: newCurrency);
//   }
//
//   void setLanguage(String newLanguage) {
//     state = state.copyWith(language: newLanguage);
//   }
// }
//
// class SettingsState {
//   final bool notificationsEnabled;
//   final bool darkModeEnabled;
//   final String currency;
//   final String language;
//
//   SettingsState({
//     required this.notificationsEnabled,
//     required this.darkModeEnabled,
//     required this.currency,
//     required this.language,
//   });
//
//   SettingsState copyWith({
//     bool? notificationsEnabled,
//     bool? darkModeEnabled,
//     String? currency,
//     String? language,
//   }) {
//     return SettingsState(
//       notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
//       darkModeEnabled: darkModeEnabled ?? this.darkModeEnabled,
//       currency: currency ?? this.currency,
//       language: language ?? this.language,
//     );
//   }
// }
//
//
//
// // lib/providers/settings_notifier.dart
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../../data/datasources/local/shared_preferences.dart';
// import '../../../domain/usecases/manage_theme_usecase.dart';
// // import '../data/datasources/local/shared_prefs_datasource.dart';
// // import '../domain/usecases/manage_theme_usecase.dart';
//
// class SettingsState {
//   final bool notificationsEnabled;
//   final bool darkModeEnabled;
//   final String currency;
//   final String language;
//   final AppTheme theme;
//
//   SettingsState({
//     this.notificationsEnabled = true,
//     this.darkModeEnabled = false,
//     this.currency = 'USD',
//     this.language = 'English',
//     this.theme = AppTheme.light,
//   });
//
//   SettingsState copyWith({
//     bool? notificationsEnabled,
//     bool? darkModeEnabled,
//     String? currency,
//     String? language,
//     AppTheme? theme,
//   }) {
//     return SettingsState(
//       notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
//       darkModeEnabled: darkModeEnabled ?? this.darkModeEnabled,
//       currency: currency ?? this.currency,
//       language: language ?? this.language,
//       theme: theme ?? this.theme,
//     );
//   }
// }
//
// class SettingsNotifier extends StateNotifier<SettingsState> {
//   final SharedPrefsDataSource _prefsDataSource;
//   late ManageThemeUseCase _themeUseCase;
//
//   SettingsNotifier(this._prefsDataSource)
//       : super(SettingsState()) {
//     _themeUseCase = ManageThemeUseCase(_prefsDataSource);
//     _loadSettings();
//   }
//
//   Future<void> _loadSettings() async {
//     // Загружаем все настройки асинхронно
//     final notificationsEnabled = await _prefsDataSource.getNotificationsEnabled();
//     // final darkMode = await _prefsDataSource.getDarkMode();
//     final currency = await _prefsDataSource.getCurrency();
//     final languageCode = await _prefsDataSource.getLanguage();
//     final theme = await _themeUseCase.getCurrentTheme();
//
//     // Преобразуем код языка в название
//     final language = _getLanguageName(languageCode);
//
//     state = state.copyWith(
//       notificationsEnabled: notificationsEnabled,
//       darkModeEnabled: darkMode,
//       currency: currency,
//       language: language,
//       theme: theme,
//     );
//   }
//
//   String _getLanguageName(String code) {
//     switch (code) {
//       case 'ru':
//         return 'Russian';
//       case 'en':
//         return 'English';
//       default:
//         return 'English';
//     }
//   }
//
//   String _getLanguageCode(String name) {
//     switch (name) {
//       case 'Russian':
//         return 'ru';
//       case 'English':
//         return 'en';
//       default:
//         return 'en';
//     }
//   }
//
//   Future<void> toggleNotifications(bool value) async {
//     await _prefsDataSource.setNotificationsEnabled(value);
//     state = state.copyWith(notificationsEnabled: value);
//   }
//
//   Future<void> toggleDarkMode(bool value) async {
//     await _prefsDataSource.setDarkMode(value);
//     state = state.copyWith(darkModeEnabled: value);
//   }
//
//   Future<void> setCurrency(String currency) async {
//     await _prefsDataSource.saveCurrency(currency);
//     state = state.copyWith(currency: currency);
//   }
//
//   Future<void> setLanguage(String language) async {
//     final languageCode = _getLanguageCode(language);
//     await _prefsDataSource.saveLanguage(languageCode);
//     state = state.copyWith(language: language);
//   }
//
//   Future<void> toggleTheme() async {
//     final newTheme = await _themeUseCase.toggleTheme();
//     state = state.copyWith(theme: newTheme);
//   }
//
//   Future<void> setTheme(AppTheme theme) async {
//     await _themeUseCase.saveTheme(theme);
//     state = state.copyWith(theme: theme);
//   }
//
//   // Future<void> saveUserId(int userId) async {
//   //   await _prefsDataSource.saveUserId(userId);
//   // }
//
//   // Future<int?> getUserId() async {
//   //   return await _prefsDataSource.getUserId();
//   // }
//
//   // Future<void> clearAllSettings() async {
//   //   await _prefsDataSource.clearAll();
//   //   state = SettingsState();
//   // }
// }
//
// // Provider
// final settingsNotifierProvider = StateNotifierProvider<SettingsNotifier, SettingsState>(
//       (ref) {
//     final prefsDataSource = SharedPrefsDataSource();
//     return SettingsNotifier(prefsDataSource);
//   },
// );
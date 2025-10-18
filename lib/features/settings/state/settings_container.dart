import 'package:flutter/material.dart';

class SettingsContainer extends ChangeNotifier {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  String _currency = 'USD';
  String _language = 'English';

  bool get notificationsEnabled => _notificationsEnabled;
  bool get darkModeEnabled => _darkModeEnabled;
  String get currency => _currency;
  String get language => _language;

  void toggleNotifications(bool enabled) {
    _notificationsEnabled = enabled;
    notifyListeners();
  }

  void toggleDarkMode(bool enabled) {
    _darkModeEnabled = enabled;
    notifyListeners();
  }

  void setCurrency(String newCurrency) {
    _currency = newCurrency;
    notifyListeners();
  }

  void setLanguage(String newLanguage) {
    _language = newLanguage;
    notifyListeners();
  }
}
import 'package:flutter/material.dart';

import 'app.dart';
import 'core/setup_di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDI();
  runApp(const App());
}

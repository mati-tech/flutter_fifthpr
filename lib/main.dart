import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app.dart';
import 'core/setup_di.dart';

void main() {
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

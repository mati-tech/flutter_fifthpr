import 'package:flutter/material.dart';
import '../../../shared/widgets/app_button.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isLogin;

  const AuthButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.isLoading,
    this.isLogin = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppButton(
      text: text,
      onPressed: onPressed,
      isLoading: isLoading,
    );
  }
}
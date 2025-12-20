import 'package:flutter/material.dart';
import '../../../shared/app_theme.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final maxWidth = constraints.maxWidth;

            if (maxWidth >= 1024) {
              return _buildWebLayout();
            } else if (maxWidth >= 600) {
              return _buildTabletLayout();
            } else {
              return _buildMobileLayout();
            }
          },
        ),
      ),
    );
  }

  Widget _buildWebLayout() {
    return Center(
      child: Container(
        width: 400,
        padding: const EdgeInsets.all(48),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
            ),
          ],
        ),
        child: _buildFormColumn(),
      ),
    );
  }

  Widget _buildTabletLayout() {
    return Center(
      child: Container(
        width: 500,
        padding: const EdgeInsets.all(32),
        child: _buildFormColumn(),
      ),
    );
  }

  Widget _buildMobileLayout() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: _buildFormColumn(),
    );
  }

  Widget _buildFormColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 60),
        const Text(
          'Welcome Back!',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'Sign in to your Storely account',
          style: TextStyle(
            fontSize: 16,
            color: AppTheme.secondaryColor,
          ),
        ),
        const SizedBox(height: 48),
        // Username field
        AppTextField(
          label: 'Username',
          hintText: 'Enter your username',
          keyboardType: TextInputType.text,
        ),
        const SizedBox(height: 24),
        // Password field
        AppTextField(
          label: 'Password',
          hintText: 'Enter your password',
          obscureText: true,
        ),
        const SizedBox(height: 32),
        // Sign In button
        AppButton(
          text: 'Sign In',
          onPressed: () {},
        ),
        const SizedBox(height: 24),
        // Sign up link
        Center(
          child: GestureDetector(
            onTap: () {},
            child: RichText(
              text: const TextSpan(
                text: "Don't have an account? ",
                style: TextStyle(color: AppTheme.secondaryColor),
                children: [
                  TextSpan(
                    text: 'Sign Up',
                    style: TextStyle(
                      color: AppTheme.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
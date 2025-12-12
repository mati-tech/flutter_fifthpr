import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../shared/app_theme.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_text_field.dart';
import '../../home/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;


  void _login() async {
    context.go('/home');
    // Navigator.pushReplacementNamed(context, '/home');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
        builder: (context, constraints){
          double maxWidth = constraints.maxWidth;
          
          if (maxWidth >= 1024){
            return _buildWebLayout();
          }
          else if (maxWidth >= 600){
            return _buildTabletLayout();
          }
          else {
            return _buildMobileLayout(); 
          }
       }
       ),
      )
    );
  }

  Widget _buildWebLayout() {
    return Center(
      child: Container(
        width: 400, // fixed width for web
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
        width: 500, // limit max width for tablet
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
    return Form(
      key: _formKey,
      child: Column(
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
          AppTextField(
            label: 'Email',
            hintText: 'Enter your email',
            keyboardType: TextInputType.emailAddress,
            controller: _emailController,
            validator: (value) {
              if (value == null || value.isEmpty) return 'Please enter your email';
              if (!value.contains('@')) return 'Please enter a valid email';
              return null;
            },
          ),
          const SizedBox(height: 24),
          AppTextField(
            label: 'Password',
            hintText: 'Enter your password',
            obscureText: true,
            controller: _passwordController,
            validator: (value) {
              if (value == null || value.isEmpty) return 'Please enter your password';
              if (value.length < 6) return 'Password must be at least 6 characters';
              return null;
            },
          ),
          const SizedBox(height: 32),
          AppButton(
            text: 'Sign In',
            onPressed: _login,
            isLoading: _isLoading,
          ),
          const SizedBox(height: 24),
          Center(
            child: GestureDetector(
              onTap: () => context.push('/register'),
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
      ),
    );
  }



// @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: SafeArea( // here a safe area to avoid the operating system interface for the app
  //       child: SingleChildScrollView(
  //         padding: const EdgeInsets.all(24),
  //         child: Form(
  //           key: _formKey,
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             children: [
  //               const SizedBox(height: 60),
  //               // Header
  //               const Text(
  //                 'Welcome Back!',
  //                 style: TextStyle(
  //                   fontSize: 32,
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //                 textAlign: TextAlign.center,
  //               ),
  //               const SizedBox(height: 8),
  //               Text(
  //                 'Sign in to your Storely account',
  //                 style: TextStyle(
  //                   fontSize: 16,
  //                   color: AppTheme.secondaryColor,
  //                 ),
  //               ),
  //               const SizedBox(height: 48),
  //               // Email Field
  //               AppTextField(
  //                 label: 'Email',
  //                 hintText: 'Enter your email',
  //                 keyboardType: TextInputType.emailAddress,
  //                 controller: _emailController,
  //                 validator: (value) {
  //                   if (value == null || value.isEmpty) {
  //                     return 'Please enter your email';
  //                   }
  //                   if (!value.contains('@')) {
  //                     return 'Please enter a valid email';
  //                   }
  //                   return null;
  //                 },
  //               ),
  //               const SizedBox(height: 24),
  //               // Password Field
  //               AppTextField(
  //                 label: 'Password',
  //                 hintText: 'Enter your password',
  //                 obscureText: true,
  //                 controller: _passwordController,
  //                 validator: (value) {
  //                   if (value == null || value.isEmpty) {
  //                     return 'Please enter your password';
  //                   }
  //                   if (value.length < 6) {
  //                     return 'Password must be at least 6 characters';
  //                   }
  //                   return null;
  //                 },
  //               ),
  //               const SizedBox(height: 32),
  //               // Login Button
  //               AppButton(
  //                 text: 'Sign In',
  //                 onPressed: _login,
  //                 isLoading: _isLoading,
  //               ),
  //               const SizedBox(height: 24),
  //               // Sign Up Link
  //               Center(
  //                 child: GestureDetector(
  //                   onTap: () {
  //                     Navigator.pushNamed(context, '/register');
  //                   },
  //                   child: RichText(
  //                     text: const TextSpan(
  //                       text: "Don't have an account? ",
  //                       style: TextStyle(color: AppTheme.secondaryColor),
  //                       children: [
  //                         TextSpan(
  //                           text: 'Sign Up',
  //                           style: TextStyle(
  //                             color: AppTheme.primaryColor,
  //                             fontWeight: FontWeight.bold,
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  
}
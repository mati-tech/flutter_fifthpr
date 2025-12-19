// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import '../../../shared/app_theme.dart';
// import '../../../shared/widgets/app_button.dart';
// import '../../../shared/widgets/app_text_field.dart';
// import '../providers/auth_provider.dart'; // Import your auth provider
//
// class RegisterScreen extends ConsumerStatefulWidget {
//   const RegisterScreen({super.key});
//
//   @override
//   ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
// }
//
// class _RegisterScreenState extends ConsumerState<RegisterScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _usernameController = TextEditingController(); // Changed from name to username
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _confirmPasswordController = TextEditingController();
//
//   @override
//   void dispose() {
//     _usernameController.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//     _confirmPasswordController.dispose();
//     super.dispose();
//   }
//
//   Future<void> _register() async {
//     if (_formKey.currentState!.validate()) {
//       if (_passwordController.text != _confirmPasswordController.text) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Passwords do not match'),
//             backgroundColor: Colors.red,
//           ),
//         );
//         return;
//       }
//
//       try {
//         await ref.read(authNotifierProvider.notifier).register(
//           username: _usernameController.text.trim(),
//           email: _emailController.text.trim(),
//           password: _passwordController.text,
//         );
//
//         // Success - navigate to home
//         if (context.mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text('Registration successful!'),
//               backgroundColor: Colors.green,
//             ),
//           );
//           context.go('/home'); // or '/login' if you want them to login first
//         }
//       } catch (e) {
//         if (context.mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text('Registration failed: ${e.toString()}'),
//               backgroundColor: Colors.red,
//             ),
//           );
//         }
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final authState = ref.watch(authNotifierProvider);
//
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(24),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 40),
//                 // Header
//                 const Text(
//                   'Create Account',
//                   style: TextStyle(
//                     fontSize: 32,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   'Sign up to get started',
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: AppTheme.secondaryColor,
//                   ),
//                 ),
//                 const SizedBox(height: 40),
//
//                 // Username Field (changed from Name)
//                 AppTextField(
//                   label: 'Username',
//                   hintText: 'Enter your username',
//                   controller: _usernameController,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter a username';
//                     }
//                     if (value.length < 3) {
//                       return 'Username must be at least 3 characters';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 20),
//
//                 // Email Field
//                 AppTextField(
//                   label: 'Email',
//                   hintText: 'Enter your email',
//                   keyboardType: TextInputType.emailAddress,
//                   controller: _emailController,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter your email';
//                     }
//                     if (!value.contains('@')) {
//                       return 'Please enter a valid email';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 20),
//
//                 // Password Field
//                 AppTextField(
//                   label: 'Password',
//                   hintText: 'Enter your password',
//                   obscureText: true,
//                   controller: _passwordController,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter your password';
//                     }
//                     if (value.length < 6) {
//                       return 'Password must be at least 6 characters';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 20),
//
//                 // Confirm Password Field
//                 AppTextField(
//                   label: 'Confirm Password',
//                   hintText: 'Confirm your password',
//                   obscureText: true,
//                   controller: _confirmPasswordController,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please confirm your password';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 32),
//
//                 // Error message if any
//                 if (authState.error != null)
//                   Container(
//                     padding: const EdgeInsets.all(12),
//                     margin: const EdgeInsets.only(bottom: 16),
//                     decoration: BoxDecoration(
//                       color: Colors.red.shade50,
//                       borderRadius: BorderRadius.circular(8),
//                       border: Border.all(color: Colors.red.shade200),
//                     ),
//                     child: Row(
//                       children: [
//                         const Icon(Icons.error_outline, color: Colors.red, size: 20),
//                         const SizedBox(width: 8),
//                         Expanded(
//                           child: Text(
//                             authState.error!,
//                             style: const TextStyle(color: Colors.red),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//
//                 // Register Button
//                 AppButton(
//                   text: 'Create Account',
//                   onPressed: authState.isLoading ? (){} : () => _register(),
//                   isLoading: authState.isLoading,
//                 ),
//                 const SizedBox(height: 24),
//
//                 // Login Link
//                 Center(
//                   child: GestureDetector(
//                     onTap: () {
//                       context.go('/login');
//                     },
//                     child: RichText(
//                       text: const TextSpan(
//                         text: "Already have an account? ",
//                         style: TextStyle(color: AppTheme.secondaryColor),
//                         children: [
//                           TextSpan(
//                             text: 'Sign In',
//                             style: TextStyle(
//                               color: AppTheme.primaryColor,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
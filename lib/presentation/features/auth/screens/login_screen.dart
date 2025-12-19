// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import '../../../shared/app_theme.dart';
// import '../../../shared/widgets/app_button.dart';
// import '../../../shared/widgets/app_text_field.dart';
// import '../providers/auth_provider.dart';
//
// class LoginScreen extends ConsumerStatefulWidget {
//   const LoginScreen({super.key});
//
//   @override
//   ConsumerState<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends ConsumerState<LoginScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _usernameController = TextEditingController(); // Changed from email
//   final _passwordController = TextEditingController();
//   bool _isLoading = false;
//
//   Future<void> _login() async {
//     if (_formKey.currentState!.validate()) {
//       setState(() => _isLoading = true);
//
//       try {
//         // Pass username instead of email
//         await ref.read(authNotifierProvider.notifier).login(
//           _usernameController.text.trim(),
//           _passwordController.text,
//         );
//
//         if (context.mounted) {
//           context.go('/home');
//         }
//       } catch (e) {
//         if (context.mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text('Login failed: ${e.toString()}'),
//               backgroundColor: Colors.red,
//             ),
//           );
//         }
//       } finally {
//         if (mounted) {
//           setState(() => _isLoading = false);
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
//         body: SafeArea(
//           child: LayoutBuilder(
//               builder: (context, constraints) {
//                 double maxWidth = constraints.maxWidth;
//
//                 if (maxWidth >= 1024) {
//                   return _buildWebLayout(authState);
//                 } else if (maxWidth >= 600) {
//                   return _buildTabletLayout(authState);
//                 } else {
//                   return _buildMobileLayout(authState);
//                 }
//               }
//           ),
//         )
//     );
//   }
//
//   Widget _buildWebLayout(AuthState authState) {
//     return Center(
//       child: SingleChildScrollView( // ADD THIS
//         child: Container(
//           width: 400,
//           padding: const EdgeInsets.all(48),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(16),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black12,
//                 blurRadius: 10,
//               ),
//             ],
//           ),
//           child: _buildFormColumn(authState),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTabletLayout(AuthState authState) {
//     return Center(
//       child: SingleChildScrollView( // ADD THIS
//         child: Container(
//           width: 500,
//           padding: const EdgeInsets.all(32),
//           child: _buildFormColumn(authState),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildMobileLayout(AuthState authState) {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(24),
//       child: _buildFormColumn(authState),
//     );
//   }
//
//   Widget _buildFormColumn(AuthState authState) {
//     return Form(
//       key: _formKey,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           const SizedBox(height: 60),
//           const Text(
//             'Welcome Back!',
//             style: TextStyle(
//               fontSize: 32,
//               fontWeight: FontWeight.bold,
//             ),
//             textAlign: TextAlign.center,
//           ),
//           const SizedBox(height: 8),
//           Text(
//             'Sign in to your Storely account',
//             style: TextStyle(
//               fontSize: 16,
//               color: AppTheme.secondaryColor,
//             ),
//           ),
//           const SizedBox(height: 48),
//
//           // Error message
//           if (authState.error != null)
//             Container(
//               padding: const EdgeInsets.all(12),
//               margin: const EdgeInsets.only(bottom: 16),
//               decoration: BoxDecoration(
//                 color: Colors.red.shade50,
//                 borderRadius: BorderRadius.circular(8),
//                 border: Border.all(color: Colors.red.shade200),
//               ),
//               child: Row(
//                 children: [
//                   const Icon(Icons.error_outline, color: Colors.red, size: 20),
//                   const SizedBox(width: 8),
//                   Expanded(
//                     child: Text(
//                       authState.error!,
//                       style: const TextStyle(color: Colors.red),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//           // Username field (changed from Email)
//           AppTextField(
//             label: 'Username', // Changed label
//             hintText: 'Enter your username',
//             keyboardType: TextInputType.text,
//             controller: _usernameController,
//             validator: (value) {
//               if (value == null || value.isEmpty) return 'Please enter your username';
//               if (value.length < 3) return 'Username must be at least 3 characters';
//               return null;
//             },
//           ),
//           const SizedBox(height: 24),
//           AppTextField(
//             label: 'Password',
//             hintText: 'Enter your password',
//             obscureText: true,
//             controller: _passwordController,
//             validator: (value) {
//               if (value == null || value.isEmpty) return 'Please enter your password';
//               if (value.length < 6) return 'Password must be at least 6 characters';
//               return null;
//             },
//           ),
//           const SizedBox(height: 32),
//           AppButton(
//             text: 'Sign In',
//             onPressed: _isLoading ? (){} : _login,
//             isLoading: _isLoading || authState.isLoading,
//           ),
//           const SizedBox(height: 24),
//           Center(
//             child: GestureDetector(
//               onTap: () => context.push('/register'),
//               child: RichText(
//                 text: const TextSpan(
//                   text: "Don't have an account? ",
//                   style: TextStyle(color: AppTheme.secondaryColor),
//                   children: [
//                     TextSpan(
//                       text: 'Sign Up',
//                       style: TextStyle(
//                         color: AppTheme.primaryColor,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
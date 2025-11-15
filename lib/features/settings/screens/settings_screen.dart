// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import '../../../shared/app_theme.dart';
// import '../../../shared/widgets/app_button.dart';
// import '../state/settings_container.dart';
// import '../../../features/auth/state/auth_container.dart';
// import '../../../core/setup_di.dart';
// import '../../../core/widgets/listenable_builder.dart';
//
// class SettingsScreen extends StatelessWidget {
//   const SettingsScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return ContainerListenableBuilder<SettingsContainer>(
//       getNotifier: () => getIt<SettingsContainer>(),
//       builder: (context, settingsContainer) {
//         return ContainerListenableBuilder<AuthContainer>(
//           getNotifier: () => getIt<AuthContainer>(),
//           builder: (context, authContainer) {
//             return Scaffold(
//               appBar: AppBar(
//                 title: const Text('Settings'),
//               ),
//               body: ListView(
//                 padding: const EdgeInsets.all(16),
//                 children: [
//                   // Profile Section
//                   Card(
//                     child: Padding(
//                       padding: const EdgeInsets.all(16),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text(
//                         'Profile',
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 12),
//                       if (authContainer.currentUser != null) ...[
//                         ListTile(
//                           leading: Container(
//                             width: 40,
//                             height: 40,
//                             decoration: BoxDecoration(
//                               color: AppTheme.primaryColor,
//                               shape: BoxShape.circle,
//                             ),
//                             child: Icon(
//                               Icons.person,
//                               color: Colors.white,
//                             ),
//                           ),
//                           title: Text(
//                             authContainer.currentUser!.name,
//                             style: const TextStyle(fontWeight: FontWeight.w500),
//                       ),
//                       subtitle: Text(authContainer.currentUser!.email),
//                     ),
//                   ],
//                   const SizedBox(height: 8),
//                   AppButton(
//                     text: 'Edit Profile',
//                     onPressed: () {
//                       Navigator.pushNamed(context, 'profile');
//                     },
//                     isFullWidth: true,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           const SizedBox(height: 16),
//           // Preferences Section
//           Card(
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'Preferences',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 12),
//                   SwitchListTile(
//                     title: const Text('Push Notifications'),
//                     subtitle: const Text('Receive order updates and promotions'),
//                     value: settingsContainer.notificationsEnabled,
//                     onChanged: settingsContainer.toggleNotifications,
//                   ),
//                   SwitchListTile(
//                     title: const Text('Dark Mode'),
//                     subtitle: const Text('Use dark theme'),
//                     value: settingsContainer.darkModeEnabled,
//                     onChanged: settingsContainer.toggleDarkMode,
//                   ),
//                   ListTile(
//                     title: const Text('Currency'),
//                     subtitle: Text(settingsContainer.currency),
//                     trailing: const Icon(Icons.arrow_forward_ios, size: 16),
//                     onTap: () {
//                       _showCurrencyDialog(context, settingsContainer);
//                     },
//                   ),
//                   ListTile(
//                     title: const Text('Language'),
//                     subtitle: Text(settingsContainer.language),
//                     trailing: const Icon(Icons.arrow_forward_ios, size: 16),
//                     onTap: () {
//                       _showLanguageDialog(context, settingsContainer);
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           const SizedBox(height: 16),
//           // Support Section
//           Card(
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'Support',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 12),
//                   ListTile(
//                     leading: const Icon(Icons.help_outline),
//                     title: const Text('Help Center'),
//                     onTap: () {},
//                   ),
//                   ListTile(
//                     leading: const Icon(Icons.security),
//                     title: const Text('Privacy Policy'),
//                     onTap: () {},
//                   ),
//                   ListTile(
//                     leading: const Icon(Icons.description),
//                     title: const Text('Terms of Service'),
//                     onTap: () {},
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           const SizedBox(height: 16),
//           // Account Actions
//           Card(
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'Account',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 12),
//                   AppButton(
//                     text: 'Sign Out',
//                     onPressed: () {
//                       _showSignOutDialog(context, authContainer);
//                     },
//                     isFullWidth: true,
//                     backgroundColor: AppTheme.errorColor,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//             );
//           },
//         );
//       },
//     );
//   }
//
//   void _showCurrencyDialog(BuildContext context, SettingsContainer container) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Select Currency'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             ListTile(
//               title: const Text('USD - US Dollar'),
//               trailing: container.currency == 'USD' ? const Icon(Icons.check) : null,
//               onTap: () {
//                 container.setCurrency('USD');
//                 Navigator.pop(context);
//               },
//             ),
//             ListTile(
//               title: const Text('EUR - Euro'),
//               trailing: container.currency == 'EUR' ? const Icon(Icons.check) : null,
//               onTap: () {
//                 container.setCurrency('EUR');
//                 Navigator.pop(context);
//               },
//             ),
//             ListTile(
//               title: const Text('GBP - British Pound'),
//               trailing: container.currency == 'GBP' ? const Icon(Icons.check) : null,
//               onTap: () {
//                 container.setCurrency('GBP');
//                 Navigator.pop(context);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _showLanguageDialog(BuildContext context, SettingsContainer container) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Select Language'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             ListTile(
//               title: const Text('English'),
//               trailing: container.language == 'English' ? const Icon(Icons.check) : null,
//               onTap: () {
//                 container.setLanguage('English');
//                 Navigator.pop(context);
//               },
//             ),
//             ListTile(
//               title: const Text('Spanish'),
//               trailing: container.language == 'Spanish' ? const Icon(Icons.check) : null,
//               onTap: () {
//                 container.setLanguage('Spanish');
//                 Navigator.pop(context);
//               },
//             ),
//             ListTile(
//               title: const Text('French'),
//               trailing: container.language == 'French' ? const Icon(Icons.check) : null,
//               onTap: () {
//                 container.setLanguage('French');
//                 Navigator.pop(context);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _showSignOutDialog(BuildContext context, AuthContainer authContainer) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Sign Out'),
//         content: const Text('Are you sure you want to sign out?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () {
//               authContainer.logout();
//               Navigator.pop(context);
//               Navigator.pushReplacementNamed(context, '/login');
//             },
//             child: const Text(
//               'Sign Out',
//               style: TextStyle(color: AppTheme.errorColor),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../shared/app_theme.dart';
import '../../../shared/widgets/app_button.dart';
import '../providers/settings_provider.dart';
import '../../auth/providers/auth_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsState = ref.watch(settingsNotifierProvider);
    final authState = ref.watch(authNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Profile Section
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Profile',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (authState.currentUser != null) ...[
                    ListTile(
                      leading: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        authState.currentUser!.name,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text(authState.currentUser!.email),
                    ),
                  ],
                  const SizedBox(height: 8),
                  AppButton(
                    text: 'Edit Profile',
                    onPressed: () {
                      context.push('/profile');
                    },
                    isFullWidth: true,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Preferences Section
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Preferences',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SwitchListTile(
                    title: const Text('Push Notifications'),
                    subtitle: const Text('Receive order updates and promotions'),
                    value: settingsState.notificationsEnabled,
                    onChanged: (value) => ref.read(settingsNotifierProvider.notifier)
                        .toggleNotifications(value),
                  ),
                  SwitchListTile(
                    title: const Text('Dark Mode'),
                    subtitle: const Text('Use dark theme'),
                    value: settingsState.darkModeEnabled,
                    onChanged: (value) => ref.read(settingsNotifierProvider.notifier)
                        .toggleDarkMode(value),
                  ),
                  ListTile(
                    title: const Text('Currency'),
                    subtitle: Text(settingsState.currency),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      _showCurrencyDialog(context, ref);
                    },
                  ),
                  ListTile(
                    title: const Text('Language'),
                    subtitle: Text(settingsState.language),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      _showLanguageDialog(context, ref);
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Support Section
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Support',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ListTile(
                    leading: const Icon(Icons.help_outline),
                    title: const Text('Help Center'),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.security),
                    title: const Text('Privacy Policy'),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.description),
                    title: const Text('Terms of Service'),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Account Actions
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Account',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  AppButton(
                    text: 'Sign Out',
                    onPressed: () {
                      _showSignOutDialog(context, ref);
                    },
                    isFullWidth: true,
                    backgroundColor: AppTheme.errorColor,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showCurrencyDialog(BuildContext context, WidgetRef ref) {
    final currentCurrency = ref.read(settingsNotifierProvider).currency;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Currency'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('USD - US Dollar'),
              trailing: currentCurrency == 'USD' ? const Icon(Icons.check) : null,
              onTap: () {
                ref.read(settingsNotifierProvider.notifier).setCurrency('USD');
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('EUR - Euro'),
              trailing: currentCurrency == 'EUR' ? const Icon(Icons.check) : null,
              onTap: () {
                ref.read(settingsNotifierProvider.notifier).setCurrency('EUR');
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('GBP - British Pound'),
              trailing: currentCurrency == 'GBP' ? const Icon(Icons.check) : null,
              onTap: () {
                ref.read(settingsNotifierProvider.notifier).setCurrency('GBP');
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showLanguageDialog(BuildContext context, WidgetRef ref) {
    final currentLanguage = ref.read(settingsNotifierProvider).language;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Language'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('English'),
              trailing: currentLanguage == 'English' ? const Icon(Icons.check) : null,
              onTap: () {
                ref.read(settingsNotifierProvider.notifier).setLanguage('English');
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Spanish'),
              trailing: currentLanguage == 'Spanish' ? const Icon(Icons.check) : null,
              onTap: () {
                ref.read(settingsNotifierProvider.notifier).setLanguage('Spanish');
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('French'),
              trailing: currentLanguage == 'French' ? const Icon(Icons.check) : null,
              onTap: () {
                ref.read(settingsNotifierProvider.notifier).setLanguage('French');
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showSignOutDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              ref.read(authNotifierProvider.notifier).logout();
              Navigator.pop(context);
              context.go('/login');
            },
            child: const Text(
              'Sign Out',
              style: TextStyle(color: AppTheme.errorColor),
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/models/user.dart';
import '../providers/profile_provider.dart';
import '../../../shared/app_theme.dart';
import '../../../shared/widgets/app_button.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileProvider);
    final user = profileState.user;
    final isLoading = profileState.isLoading;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: profileState.isRefreshing
                ? null
                : () => ref.read(profileProvider.notifier).refresh(),
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : user == null
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('No user data available'),
            const SizedBox(height: 16),
            AppButton(
              text: 'Retry',
              onPressed: () =>
                  ref.read(profileProvider.notifier).refresh(),
            ),
          ],
        ),
      )
          : RefreshIndicator(
        onRefresh: () =>
            ref.read(profileProvider.notifier).refresh(),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Avatar section
            _buildAvatarSection(user),
            const SizedBox(height: 24),
            // Personal info
            _buildInfoCard('Personal Information', [
              _buildInfoRow('First Name', user.firstname),
              _buildInfoRow('Last Name', user.lastname),
              _buildInfoRow('Email', user.email),
              _buildInfoRow('Username', user.username),
              _buildInfoRow('Phone', user.phone),
            ]),
            const SizedBox(height: 24),
            // Account info
            _buildInfoCard('Account Information', [
              _buildInfoRow('User ID', user.id.toString()),
              // Можно скрыть пароль: _buildInfoRow('Password', '••••••••'),
            ]),
            const SizedBox(height: 32),
            // Action buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  AppButton(
                    text: 'Edit Profile',
                    onPressed: () {
                      // TODO: Переход на экран редактирования
                    },
                  ),
                  const SizedBox(height: 12),
                  AppButton(
                    text: 'Change Password',
                    onPressed: () {
                      // TODO: Изменение пароля
                    },
                    backgroundColor: Colors.grey[300],
                    // textColor: Colors.black,
                  ),
                  const SizedBox(height: 12),
                  AppButton(
                    text: profileState.isDeleting
                        ? 'Deleting...'
                        : 'Delete Account',
                    onPressed: () {
                      _showDeleteConfirmationDialog(context, ref);
                    },
                    backgroundColor: Colors.red,
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatarSection(User user) {
    return Column(
      children: [
        CircleAvatar(
          radius: 60,
          backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
          child: Text(
            user.firstname[0].toUpperCase() + user.lastname[0].toUpperCase(),
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryColor,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          '${user.firstname} ${user.lastname}',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          user.email,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard(String title, List<Widget> children) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: const Text('Delete Account'),
            content: const Text(
                'Are you sure you want to delete your account? This action cannot be undone.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                  // await ref.read(profileProvider.notifier).deleteProfile();
                  // После удаления перейти на другой экран
                  context.go('/login');
                },
                child: const Text(
                    'Delete', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
    );
  }
}
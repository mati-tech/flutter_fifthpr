import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../auth/models/user.dart';
import '../state/profile_container.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileContainer = Provider.of<ProfileContainer>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back, color: Colors.black),
        //   onPressed: () {
        //     context.pop();
        //   },
        // ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.pushNamed(context, '/edit-profile');
            },
          ),

        ],
      ),
      body: profileContainer.currentUser == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
             padding: const EdgeInsets.all(16),
              child: Column(
                  children: [
                    // Profile Header
                    _buildProfileHeader(context, profileContainer.currentUser!),
                    const SizedBox(height: 24),

                    // Personal Information
                    _buildPersonalInfoCard(profileContainer.currentUser!),
                    const SizedBox(height: 16),

                    // Account Settings
                    _buildAccountSettingsCard(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context, User user) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Profile Image
            Stack(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppTheme.primaryColor.withOpacity(0.1),

                  ),
                  child:  Icon(
                    Icons.person,
                    size: 40,
                    color: AppTheme.primaryColor,
                  )
                      ,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: const BoxDecoration(
                      color: AppTheme.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.camera_alt, size: 18, color: Colors.white),
                      onPressed: () {
                        _showImageSourceDialog(context);
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // User Name
            Text(
              user.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            // User Email
            Text(
              user.email,
              style: const TextStyle(
                fontSize: 16,
                color: AppTheme.secondaryColor,
              ),
            ),
            const SizedBox(height: 16),
            // Member since
            Text(
              'Member since ${_formatDate(user.createdAt)}',
              style: const TextStyle(
                fontSize: 14,
                color: AppTheme.secondaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPersonalInfoCard(User user) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Personal Information',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildInfoRow('Phone', user.phone ?? 'Not provided'),
            _buildInfoRow('Address', user.address ?? 'Not provided'),
            _buildInfoRow(
                'Date of Birth',
                user.dateOfBirth != null
                    ? _formatDate(user.dateOfBirth!)
                    : 'Not provided'
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountSettingsCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Account Settings',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Push Notifications'),
              trailing: Switch(
                value: true,
                onChanged: (value) {},
              ),
            ),
            ListTile(
              leading: const Icon(Icons.email),
              title: const Text('Email Notifications'),
              trailing: Switch(
                value: true,
                onChanged: (value) {},
              ),
            ),
            ListTile(
              leading: const Icon(Icons.security),
              title: const Text('Privacy Settings'),
              onTap: () {
                // Navigate to privacy settings
              },
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('Help & Support'),
              onTap: () {
                // Navigate to help
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: AppTheme.secondaryColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _showImageSourceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Update Profile Picture'),
        content: const Text('Choose image source'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Implement camera
            },
            child: const Text('Camera'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Implement gallery
            },
            child: const Text('Gallery'),
          ),
        ],
      ),
    );
  }
}
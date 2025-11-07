import 'package:flutter/material.dart';
import '../state/profile_container.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_text_field.dart';
import '../../../core/setup_di.dart';
import '../../../core/widgets/listenable_builder.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;
  late TextEditingController _dobController;

  @override
  void initState() {
    super.initState();
    final profileContainer = getIt<ProfileContainer>();
    final user = profileContainer.currentUser;

    _nameController = TextEditingController(text: user?.name ?? '');
    _phoneController = TextEditingController(text: user?.phone ?? '');
    _addressController = TextEditingController(text: user?.address ?? '');
    _dobController = TextEditingController(
        text: user?.dateOfBirth != null
            ? '${user!.dateOfBirth!.day}/${user.dateOfBirth!.month}/${user.dateOfBirth!.year}'
            : ''
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  void _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      final profileContainer = getIt<ProfileContainer>();

      profileContainer.updateProfile(
        name: _nameController.text,
        phone: _phoneController.text,
        address: _addressController.text,
      );

      await profileContainer.saveProfileChanges();

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully!')),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder<ProfileContainer>(
      getNotifier: () => getIt<ProfileContainer>(),
      builder: (context, profileContainer) {
        return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveProfile,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              AppTextField(
                label: 'Full Name',
                controller: _nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              AppTextField(
                label: 'Phone Number',
                controller: _phoneController,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),
              AppTextField(
                label: 'Address',
                controller: _addressController,

              ),
              const SizedBox(height: 16),
              AppTextField(
                label: 'Date of Birth (DD/MM/YYYY)',
                controller: _dobController,
                keyboardType: TextInputType.datetime,
              ),
              const SizedBox(height: 32),
              AppButton(
                text: 'Save Changes',
                onPressed: _saveProfile,
                isLoading: profileContainer.isLoading,
              ),
            ],
          ),
        ),
      ),
        );
      },
    );
  }
}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/app_colors.dart';
import '../../providers/auth_provider.dart';
import '../../providers/locale_provider.dart';
import '../../models/user_model.dart';
import '../../widgets/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  UserRole _selectedRole = UserRole.guest;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final localeProvider = Provider.of<LocaleProvider>(context);
    final lang = localeProvider.locale.languageCode;

    return Scaffold(
      appBar: AppBar(title: const Text('JOIN STARLUX')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            CustomTextField(
              label: 'Full Name',
              icon: Icons.person_outline,
              controller: _nameController,
            ),
            CustomTextField(
              label: 'Email Address',
              icon: Icons.email_outlined,
              controller: _emailController,
            ),
            CustomTextField(
              label: 'Password',
              icon: Icons.lock_outline,
              isPassword: true,
              controller: _passwordController,
            ),
            const SizedBox(height: 20),
            
            // Role Selection
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Select Your Role', style: TextStyle(color: Colors.white70)),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.surface.withOpacity(0.5),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.primaryNeon.withOpacity(0.3)),
              ),
              child: DropdownButton<UserRole>(
                value: _selectedRole,
                isExpanded: true,
                underline: const SizedBox(),
                dropdownColor: AppColors.surface,
                items: UserRole.values.map((role) {
                  return DropdownMenuItem(
                    value: role,
                    child: Text(role.name.toUpperCase(), style: const TextStyle(color: Colors.white)),
                  );
                }).toList(),
                onChanged: (val) => setState(() => _selectedRole = val!),
              ),
            ),
            
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    await authProvider.register(
                      _emailController.text,
                      _passwordController.text,
                      _nameController.text,
                      _selectedRole,
                    );
                    Navigator.pop(context);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(e.toString())),
                    );
                  }
                },
                child: const Text('CREATE ACCOUNT'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

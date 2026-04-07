import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/app_colors.dart';
import '../../providers/auth_provider.dart';
import '../../providers/locale_provider.dart';
import '../../widgets/premium_widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final localeProvider = Provider.of<LocaleProvider>(context);
    final user = authProvider.user;

    if (user == null) return const Scaffold(body: Center(child: Text('Not logged in')));

    return Scaffold(
      appBar: AppBar(title: const Text('MY PROFILE')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundColor: AppColors.primaryNeon,
              child: Icon(Icons.person, size: 60, color: Colors.black),
            ),
            const SizedBox(height: 20),
            Text(
              user.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            Text(
              user.role.name.toUpperCase(),
              style: const TextStyle(color: AppColors.secondaryGold, letterSpacing: 2),
            ),
            const SizedBox(height: 40),
            
            PremiumCard(
              child: Column(
                children: [
                  _buildProfileTile(Icons.email, 'Email', user.email),
                  const Divider(color: Colors.white12),
                  _buildProfileTile(Icons.language, 'Language', localeProvider.isArabic ? 'العربية' : 'English'),
                  const Divider(color: Colors.white12),
                  _buildProfileTile(Icons.security, 'Account Status', 'Verified'),
                ],
              ),
            ),
            
            const SizedBox(height: 30),
            PremiumCard(
              child: SwitchListTile(
                title: const Text('Notifications', style: TextStyle(color: Colors.white)),
                value: true,
                activeColor: AppColors.primaryNeon,
                onChanged: (v) {},
              ),
            ),
            
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.redAccent),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                onPressed: () => authProvider.logout(),
                child: const Text('LOGOUT', style: TextStyle(color: Colors.redAccent)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileTile(IconData icon, String label, String value) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primaryNeon, size: 22),
      title: Text(label, style: const TextStyle(color: Colors.white54, fontSize: 13)),
      subtitle: Text(value, style: const TextStyle(color: Colors.white, fontSize: 16)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.white24),
    );
  }
}

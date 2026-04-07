import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/app_colors.dart';
import '../../providers/auth_provider.dart';
import '../../providers/locale_provider.dart';
import '../../widgets/custom_text_field.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final localeProvider = Provider.of<LocaleProvider>(context);
    final lang = localeProvider.locale.languageCode;

    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient/Image
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.topRight,
                radius: 1.5,
                colors: [Color(0xFF1A1A1A), AppColors.background],
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Language Toggle
                  Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                      onPressed: () {
                        localeProvider.setLocale(
                          localeProvider.isArabic ? const Locale('en') : const Locale('ar')
                        );
                      },
                      child: Text(
                        localeProvider.isArabic ? 'English' : 'العربية',
                        style: const TextStyle(color: AppColors.primaryNeon),
                      ),
                    ),
                  ),
                  const SizedBox(height: 60),
                  Text(
                    AppStrings.get('welcome', lang),
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: AppColors.textMain,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 4,
                    width: 60,
                    decoration: BoxDecoration(
                      color: AppColors.primaryNeon,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 50),
                  CustomTextField(
                    label: AppStrings.get('email', lang),
                    icon: Icons.email_outlined,
                    controller: _emailController,
                  ),
                  CustomTextField(
                    label: AppStrings.get('password', lang),
                    icon: Icons.lock_outline,
                    isPassword: true,
                    controller: _passwordController,
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () async {
                        try {
                          await authProvider.login(
                            _emailController.text,
                            _passwordController.text,
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(e.toString())),
                          );
                        }
                      },
                      child: Text(
                        AppStrings.get('login', lang),
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  const SizedBox(height: 100),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const RegisterScreen()),
                        );
                      },
                      child: const Text(
                        "Don't have an account? Register Now",
                        style: TextStyle(color: Colors.white70),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/app_theme.dart';
import 'providers/auth_provider.dart';
import 'providers/locale_provider.dart';
import 'providers/data_provider.dart';
import 'models/user_model.dart';
import 'screens/auth/login_screen.dart';
import 'screens/guest/guest_dashboard.dart';
import 'screens/staff/staff_dashboard.dart';
import 'screens/security/security_dashboard.dart';
import 'screens/admin/admin_dashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Note: Firebase.initializeApp() requires valid config files (google-services.json / GoogleService-Info.plist)
  // await Firebase.initializeApp(); 
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
        ChangeNotifierProvider(create: (_) => DataProvider()),
      ],
      child: const StarluxApp(),
    ),
  );
}

class StarluxApp extends StatelessWidget {
  const StarluxApp({super.key});

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    
    return MaterialApp(
      title: 'Starlux Hotel',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme(context),
      locale: localeProvider.locale,
      supportedLocales: const [Locale('en'), Locale('ar')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const AuthWrapper(),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    if (authProvider.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (authProvider.user == null) {
      return const LoginScreen();
    }

    // Role-based routing
    switch (authProvider.user!.role) {
      case UserRole.guest: return const GuestDashboard();
      case UserRole.staff: return const StaffDashboard();
      case UserRole.security: return const SecurityDashboard();
      case UserRole.admin: return const AdminDashboard();
    }
  }
}

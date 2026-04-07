import 'package:flutter/material.dart';

class LocaleProvider with ChangeNotifier {
  Locale _locale = const Locale('ar'); // Default to Arabic as requested

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    if (!['en', 'ar'].contains(locale.languageCode)) return;
    _locale = locale;
    notifyListeners();
  }

  bool get isArabic => _locale.languageCode == 'ar';
}

class AppStrings {
  static Map<String, Map<String, String>> localizedValues = {
    'en': {
      'login': 'Login',
      'email': 'Email',
      'password': 'Password',
      'welcome': 'Welcome to Starlux',
      'guest': 'Guest',
      'staff': 'Staff',
      'security': 'Security',
      'admin': 'Admin',
      'logout': 'Logout',
    },
    'ar': {
      'login': 'تسجيل الدخول',
      'email': 'البريد الإلكتروني',
      'password': 'كلمة المرور',
      'welcome': 'مرحباً بك في ستارلوكس',
      'guest': 'ضيف',
      'staff': 'موظف',
      'security': 'أمن',
      'admin': 'مدير',
      'logout': 'تسجيل الخروج',
    },
  };

  static String get(String key, String lang) {
    return localizedValues[lang]?[key] ?? key;
  }
}

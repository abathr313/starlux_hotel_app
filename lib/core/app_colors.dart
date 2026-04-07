import 'package:flutter/material.dart';

class AppColors {
  static const Color background = Color(0xFF0D0D0D);
  static const Color surface = Color(0xFF1E1E1E);
  static const Color primaryNeon = Color(0xFF00E5FF);
  static const Color secondaryGold = Color(0xFFD4AF37);
  static const Color textMain = Colors.white;
  static const Color textSecondary = Colors.white70;
  static const Color accentRose = Color(0xFFFF4081);
  
  static const LinearGradient premiumGradient = LinearGradient(
    colors: [primaryNeon, secondaryGold],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

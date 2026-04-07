import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import '../core/app_colors.dart';

class PremiumBottomNav extends StatelessWidget {
  final int index;
  final Function(int) onTap;

  const PremiumBottomNav({
    super.key,
    required this.index,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      index: index,
      backgroundColor: Colors.transparent,
      color: AppColors.surface,
      buttonBackgroundColor: AppColors.primaryNeon,
      height: 60,
      items: const [
        Icon(Icons.home, size: 30, color: Colors.white),
        Icon(Icons.calendar_month, size: 30, color: Colors.white),
        Icon(Icons.notifications, size: 30, color: Colors.white),
        Icon(Icons.person, size: 30, color: Colors.white),
      ],
      onTap: onTap,
    );
  }
}

class PremiumCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;

  const PremiumCard({super.key, required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface.withOpacity(0.7),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.primaryNeon.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Alignment(0, 5),
          ),
        ],
      ),
      child: child,
    );
  }
}

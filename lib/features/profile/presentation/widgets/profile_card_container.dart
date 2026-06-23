import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/colors_manager.dart';
import '../../../../core/theme/app_theme.dart';

class ProfileCardContainer extends StatelessWidget {
  final Widget child;

  const ProfileCardContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDark
            ? ColorsManager.grey900.withValues(alpha: 0.7)
            : ColorsManager.white.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(32.r),
        border: Border.all(
          color: isDark
              ? ColorsManager.grey800.withValues(alpha: 0.5)
              : ColorsManager.white.withValues(alpha: 0.5),
          width: 1.r,
        ),
        boxShadow: [
          BoxShadow(
            color:
                ColorsManager.primary.withValues(alpha: isDark ? 0.04 : 0.12),
            offset: Offset(0, 10.h),
            blurRadius: 40.r,
            spreadRadius: -10.r,
          ),
        ],
      ),
      child: child,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/colors_manager.dart';
import '../../../../core/theme/app_theme.dart';

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? trailingText;
  final VoidCallback onTap;
  final bool isDestructive;

  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.title,
    this.trailingText,
    required this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    final Color itemColor = isDestructive
        ? ColorsManager.error
        : (isDark ? ColorsManager.white : ColorsManager.grey900);

    final Color badgeBg = isDestructive
        ? ColorsManager.error.withOpacity(0.1)
        : ColorsManager.primary.withOpacity(0.12);

    final Color iconColor = isDestructive
        ? ColorsManager.error
        : ColorsManager.primary;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        child: Row(
          children: [
            // Icon Badge
            Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: badgeBg,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 20.sp,
              ),
            ),
            SizedBox(width: 16.w),
            // Title Text
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.inter(
                  color: itemColor,
                  fontSize: 16.sp,
                  fontWeight: isDestructive ? FontWeight.bold : FontWeight.w600,
                ),
              ),
            ),
            // Trailing info/icons
            if (trailingText != null) ...[
              Text(
                trailingText!,
                style: GoogleFonts.inter(
                  color: isDark ? ColorsManager.grey400 : ColorsManager.grey500,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.6,
                ),
              ),
              SizedBox(width: 8.w),
            ],
            if (!isDestructive)
              Icon(
                Icons.chevron_right,
                color: ColorsManager.grey400,
                size: 20.sp,
              ),
          ],
        ),
      ),
    );
  }
}

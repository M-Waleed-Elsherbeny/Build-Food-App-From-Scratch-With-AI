import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/colors_manager.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/theme/app_theme.dart';

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 4.h),
      leading: Container(
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: isDark ? ColorsManager.grey800 : ColorsManager.grey100,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Icon(icon, color: isDark ? ColorsManager.grey300 : ColorsManager.grey700, size: 24.sp),
      ),
      title: Text(
        title,
        style: isDark ? AppTextStyle.font16WhiteRegular : AppTextStyle.font16Grey700Regular,
      ),
      trailing: Icon(Icons.chevron_right, color: ColorsManager.grey400, size: 24.sp),
      onTap: onTap,
    );
  }
}

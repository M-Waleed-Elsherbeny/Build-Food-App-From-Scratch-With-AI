import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/core/theme/app_theme.dart';
import 'home_search_bar.dart';
import 'home_header_info.dart';

class HomeTopBar extends StatelessWidget {
  final bool isVisible;

  const HomeTopBar({super.key, required this.isVisible});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: isVisible ? 130.h : 0,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        boxShadow: isVisible
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.05),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ]
            : [],
      ),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: 16.h),
            const HomeHeaderInfo(),
            SizedBox(height: 16.h),
            HomeSearchBar(onFilterTap: () {}),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
}

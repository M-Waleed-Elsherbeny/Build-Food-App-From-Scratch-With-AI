import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/colors_manager.dart';
import '../../../../core/theme/app_text_style.dart';

import 'package:go_router/go_router.dart';
import '../../../../core/routes/app_router.dart';

class HomeSearchBar extends StatelessWidget {
  final VoidCallback? onFilterTap;

  const HomeSearchBar({
    super.key,
    this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(AppRoutes.search),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        decoration: BoxDecoration(
          color: ColorsManager.grey100,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Icon(Icons.search, color: ColorsManager.grey400, size: 20.sp),
            SizedBox(width: 8.w),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                child: Text(
                  'Search food, restaurants...',
                  style: AppTextStyle.font14Grey400Regular,
                ),
              ),
            ),
            IconButton(
              onPressed: onFilterTap,
              icon: Icon(Icons.tune, color: ColorsManager.primary, size: 20.sp),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/core/theme/colors_manager.dart';
import 'package:food_app/core/theme/app_text_style.dart';
import 'package:food_app/core/widgets/primary_button.dart';

/// Empty state widget shown when the favorites list is empty.
class FavoritesEmptyState extends StatelessWidget {
  const FavoritesEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120.w,
              height: 120.w,
              decoration: BoxDecoration(
                color: ColorsManager.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.favorite_border_rounded,
                size: 56.sp,
                color: ColorsManager.primary,
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              'No Favorites Yet',
              style: AppTextStyle.font20Grey900Bold,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10.h),
            Text(
              'Save your favorite dishes and restaurants here for quick access.',
              style: AppTextStyle.font14Grey600Regular,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32.h),
            PrimaryButton(
              text: 'Explore Restaurants',
              onPressed: () => Navigator.of(context).pop(),
              width: 200.w,
            ),
          ],
        ),
      ),
    );
  }
}

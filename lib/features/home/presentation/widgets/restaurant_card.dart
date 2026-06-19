import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/theme/colors_manager.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../restaurant_details/data/models/restaurant_model.dart';

class RestaurantCard extends StatelessWidget {
  final RestaurantModel restaurant;
  final VoidCallback onTap;
  final double? width;

  const RestaurantCard({
    super.key,
    required this.restaurant,
    required this.onTap,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? 280.w,
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: ColorsManager.black.withOpacity(isDark ? 0.3 : 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
                  child: Image.network(
                    restaurant.imageUrl,
                    width: double.infinity,
                    height: 140.h,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: double.infinity,
                      height: 140.h,
                      color: isDark ? ColorsManager.grey800 : ColorsManager.grey200,
                      child: Icon(Icons.restaurant, color: ColorsManager.grey400),
                    ),
                  ),
                ),
                Positioned(
                  top: 12.h,
                  right: 12.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: context.colorScheme.surface,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.star, color: ColorsManager.warning, size: 14.sp),
                        SizedBox(width: 4.w),
                        Text(
                          restaurant.rating.toString(),
                          style: (isDark ? AppTextStyle.font12Grey500Regular.copyWith(color: ColorsManager.white) : AppTextStyle.font12Grey500Regular.copyWith(color: ColorsManager.grey900)).copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurant.name,
                    style: isDark ? AppTextStyle.font16WhiteSemiBold : AppTextStyle.font16WhiteSemiBold.copyWith(color: ColorsManager.grey900),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '${restaurant.cuisine} • ${restaurant.deliveryTime}',
                    style: AppTextStyle.font12Grey500Regular,
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Icon(Icons.delivery_dining, color: ColorsManager.primary, size: 16.sp),
                      SizedBox(width: 4.w),
                      Text(
                        restaurant.deliveryFee == 0 ? tr('free_delivery') : '\$${restaurant.deliveryFee.toStringAsFixed(2)}',
                        style: AppTextStyle.font12Grey500Regular.copyWith(
                          color: ColorsManager.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

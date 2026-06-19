import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/features/restaurant_details/data/models/restaurant_model.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/theme/colors_manager.dart';

class RestaurantInfoSection extends StatelessWidget {
  final RestaurantModel restaurant;

  const RestaurantInfoSection({
    super.key,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            restaurant.name,
            style: AppTextStyle.font24BlackBold,
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Icon(Icons.star, color: ColorsManager.warning, size: 20.sp),
              SizedBox(width: 4.w),
              Text(
                '${restaurant.rating} (${restaurant.reviewsCount} reviews)',
                style: AppTextStyle.font14Grey600Regular.copyWith(color: ColorsManager.grey900),
              ),
              SizedBox(width: 16.w),
              Icon(Icons.access_time, color: ColorsManager.primary, size: 20.sp),
              SizedBox(width: 4.w),
              Text(
                restaurant.deliveryTime,
                style: AppTextStyle.font14Grey600Regular
                    .copyWith(color: ColorsManager.grey900),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Icon(Icons.delivery_dining, color: ColorsManager.primary, size: 20.sp),
              SizedBox(width: 8.w),
              Text(
                restaurant.deliveryFee == 0 
                  ? 'Free Delivery' 
                  : '\$${restaurant.deliveryFee.toStringAsFixed(2)} Delivery Fee',
                style: AppTextStyle.font14Grey600Regular
                    .copyWith(color: ColorsManager.grey700),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: restaurant.tags.map((tag) => Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: ColorsManager.grey100,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Text(
                tag,
                style: AppTextStyle.font12Grey500Regular.copyWith(color: ColorsManager.grey800),
              ),
            )).toList(),
          ),
          SizedBox(height: 16.h),
          Text(
            restaurant.cuisine,
            style: AppTextStyle.font14Grey600Regular,
          ),
        ],
      ),
    );
  }
}

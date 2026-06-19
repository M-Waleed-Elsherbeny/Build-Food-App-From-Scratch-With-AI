import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/core/theme/app_text_style.dart';
import 'package:food_app/core/theme/colors_manager.dart';
import 'package:food_app/features/food_details/data/models/food_details_model.dart';

class FoodInfoSection extends StatelessWidget {
  final FoodDetailsModel? food;

  const FoodInfoSection({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    if (food == null) return const SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            food!.name,
            style: AppTextStyle.font24BlackBold,
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Icon(Icons.star, color: Colors.orange, size: 20.sp),
              SizedBox(width: 4.w),
              Text(
                '${food!.rating}',
                style: AppTextStyle.font14Grey700Medium,
              ),
              SizedBox(width: 4.w),
              Text(
                '(${food!.reviewsCount}+ Reviews)',
                style: AppTextStyle.font14Grey400Regular,
              ),
              const Spacer(),
              Icon(Icons.access_time, color: ColorsManager.primary, size: 20.sp),
              SizedBox(width: 4.w),
              Text(
                '${food!.deliveryTimeMin}-${food!.deliveryTimeMax} min',
                style: AppTextStyle.font14PrimarySemiBold,
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            food!.description,
            style: AppTextStyle.font14Grey400Regular,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

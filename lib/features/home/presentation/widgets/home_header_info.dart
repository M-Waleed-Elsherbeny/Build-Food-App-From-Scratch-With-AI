import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/core/theme/app_text_style.dart';
import 'package:food_app/core/theme/colors_manager.dart';


class HomeHeaderInfo extends StatelessWidget {
  const HomeHeaderInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Deliver to', style: AppTextStyle.font12Grey500Regular),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: ColorsManager.primary,
                  size: 16.sp,
                ),
                SizedBox(width: 4.w),
                Text(
                  'San Francisco, CA',
                  style: AppTextStyle.font14Grey700Medium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: ColorsManager.grey500,
                  size: 16.sp,
                ),
              ],
            ),
          ],
        ),
        Row(
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              // ignore: prefer_const_constructors
              decoration: BoxDecoration(
                color: ColorsManager.grey200,
                shape: BoxShape.circle,
                image: const DecorationImage(
                  image: NetworkImage('https://i.pravatar.cc/150?u=waleed'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

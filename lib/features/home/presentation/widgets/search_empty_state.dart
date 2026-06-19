import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/core/theme/app_text_style.dart';
import 'package:food_app/core/theme/colors_manager.dart';

class SearchEmptyState extends StatelessWidget {
  const SearchEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 80.sp, color: ColorsManager.grey300),
          SizedBox(height: 16.h),
          Text(
            'No results found',
            style: AppTextStyle.font16Grey700Regular.copyWith(color: ColorsManager.grey500),
          ),
        ],
      ),
    );
  }
}

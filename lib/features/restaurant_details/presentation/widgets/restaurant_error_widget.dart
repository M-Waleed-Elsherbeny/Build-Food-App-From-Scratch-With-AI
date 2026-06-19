import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/colors_manager.dart';
import '../../../../core/theme/app_text_style.dart';

class RestaurantErrorWidget extends StatelessWidget {
  final String error;
  final VoidCallback onRetry;

  const RestaurantErrorWidget({
    super.key,
    required this.error,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, color: ColorsManager.error, size: 48.sp),
          SizedBox(height: 16.h),
          Text(
            error,
            style: AppTextStyle.font16WhiteSemiBold.copyWith(color: ColorsManager.grey900),
          ),
          SizedBox(height: 24.h),
          ElevatedButton(
            onPressed: onRetry,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}

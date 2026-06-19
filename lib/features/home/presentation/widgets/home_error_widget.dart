import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/core/theme/app_text_style.dart';
import 'package:food_app/core/theme/colors_manager.dart';

class HomeErrorWidget extends StatelessWidget {
  final String? error;
  final VoidCallback onRetry;

  const HomeErrorWidget({super.key, this.error, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Error: $error',
            style: AppTextStyle.font14Grey700Medium,
          ),
          SizedBox(height: 16.h),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsManager.primary,
              foregroundColor: ColorsManager.white,
            ),
            onPressed: onRetry,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}

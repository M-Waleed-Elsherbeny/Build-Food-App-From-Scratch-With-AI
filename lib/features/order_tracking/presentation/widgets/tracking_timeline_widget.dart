import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/core/theme/colors_manager.dart';
import 'package:food_app/core/theme/app_text_style.dart';
import 'package:food_app/core/theme/app_theme.dart';
import 'package:food_app/features/order_tracking/data/models/tracking_timeline_model.dart';

/// Vertical timeline widget displaying the order progress steps.
class TrackingTimelineWidget extends StatelessWidget {
  final List<TrackingTimelineModel> timeline;

  const TrackingTimelineWidget({super.key, required this.timeline});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: isDark ? ColorsManager.grey800 : ColorsManager.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.3 : 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Order Status', style: AppTextStyle.font16Grey900Medium),
          SizedBox(height: 16.h),
          ...List.generate(timeline.length, (index) {
            final step = timeline[index];
            final isLast = index == timeline.length - 1;
            return _buildTimelineStep(context, step, isLast, isDark);
          }),
        ],
      ),
    );
  }

  Widget _buildTimelineStep(
    BuildContext context,
    TrackingTimelineModel step,
    bool isLast,
    bool isDark,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left column: dot + connector line
        Column(
          children: [
            _buildDot(step),
            if (!isLast)
              Container(
                width: 2.w,
                height: 52.h,
                color: step.isCompleted ? ColorsManager.primary : ColorsManager.grey200,
              ),
          ],
        ),
        SizedBox(width: 12.w),
        // Right column: step details
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    step.title,
                    style: step.isActive
                        ? AppTextStyle.font14PrimaryBold
                        : step.isCompleted
                            ? AppTextStyle.font14Grey700Medium
                            : AppTextStyle.font14Grey400Regular,
                  ),
                  Text(step.time, style: AppTextStyle.font12Grey500Regular),
                ],
              ),
              SizedBox(height: 4.h),
              Text(step.description, style: AppTextStyle.font12Grey500Regular),
              SizedBox(height: isLast ? 0 : 12.h),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDot(TrackingTimelineModel step) {
    if (step.isCompleted) {
      return Container(
        width: 24.w,
        height: 24.w,
        decoration: const BoxDecoration(
          color: ColorsManager.primary,
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.check_rounded, color: ColorsManager.white, size: 14.sp),
      );
    } else if (step.isActive) {
      return Container(
        width: 24.w,
        height: 24.w,
        decoration: BoxDecoration(
          color: ColorsManager.primary.withOpacity(0.15),
          shape: BoxShape.circle,
          border: Border.all(color: ColorsManager.primary, width: 2),
        ),
        child: Center(
          child: Container(
            width: 10.w,
            height: 10.w,
            decoration: const BoxDecoration(
              color: ColorsManager.primary,
              shape: BoxShape.circle,
            ),
          ),
        ),
      );
    } else {
      return Container(
        width: 24.w,
        height: 24.w,
        decoration: BoxDecoration(
          color: ColorsManager.grey200,
          shape: BoxShape.circle,
          border: Border.all(color: ColorsManager.grey300, width: 2),
        ),
      );
    }
  }
}

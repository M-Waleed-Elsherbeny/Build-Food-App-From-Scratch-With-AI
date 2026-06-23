import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/theme/colors_manager.dart';

class StickyCartCta extends StatelessWidget {
  final VoidCallback onCheckoutTap;
  final bool isUpdating;

  const StickyCartCta({
    super.key,
    required this.onCheckoutTap,
    this.isUpdating = false,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 24.h,
      left: 16.w,
      right: 16.w,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: ColorsManager.primary.withValues(alpha: 0.3),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: isUpdating ? null : onCheckoutTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorsManager.primary,
            foregroundColor: ColorsManager.white,
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 24.w),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.r),
            ),
            elevation: 0,
          ),
          child: isUpdating
              ? SizedBox(
                  height: 24.h,
                  width: 24.h,
                  child: const CircularProgressIndicator(
                      color: ColorsManager.white, strokeWidth: 2),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: ColorsManager.white.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.shopping_bag_outlined,
                          color: ColorsManager.white, size: 20.sp),
                    ),
                    Text(
                      'View Cart & Checkout',
                      style: AppTextStyle.font16WhiteSemiBold,
                    ),
                    Icon(Icons.arrow_forward_ios,
                        color: ColorsManager.white, size: 16.sp),
                  ],
                ),
        ),
      ),
    );
  }
}

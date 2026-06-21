import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/core/theme/colors_manager.dart';
import 'package:food_app/core/theme/app_text_style.dart';
import 'package:food_app/core/theme/app_theme.dart';
import 'package:food_app/features/order_tracking/data/models/driver_model.dart';

/// Card widget showing driver details with call and message actions.
class DriverInfoCard extends StatelessWidget {
  final DriverModel driver;

  const DriverInfoCard({super.key, required this.driver});

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
      child: Row(
        children: [
          // Driver avatar
          ClipRRect(
            borderRadius: BorderRadius.circular(40.r),
            child: driver.avatar.isNotEmpty
                ? Image.network(
                    driver.avatar,
                    width: 56.w,
                    height: 56.w,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => _buildAvatarPlaceholder(),
                  )
                : _buildAvatarPlaceholder(),
          ),
          SizedBox(width: 12.w),
          // Driver info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Your Delivery Driver', style: AppTextStyle.font12Grey500Regular),
                SizedBox(height: 4.h),
                Text(driver.name, style: AppTextStyle.font16Grey900Medium),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Icon(Icons.star_rounded, color: ColorsManager.warning, size: 14.sp),
                    SizedBox(width: 4.w),
                    Text(
                      '${driver.rating.toStringAsFixed(1)} · ${driver.ratingsCount}',
                      style: AppTextStyle.font12Grey500Regular,
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Action buttons
          Row(
            children: [
              _buildActionButton(
                icon: Icons.chat_bubble_outline_rounded,
                onTap: () {},
                isDark: isDark,
              ),
              SizedBox(width: 8.w),
              _buildActionButton(
                icon: Icons.call_outlined,
                onTap: () {},
                isDark: isDark,
                isPrimary: true,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required VoidCallback onTap,
    required bool isDark,
    bool isPrimary = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40.w,
        height: 40.w,
        decoration: BoxDecoration(
          color: isPrimary ? ColorsManager.primary : (isDark ? ColorsManager.grey700 : ColorsManager.grey100),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 18.sp,
          color: isPrimary ? ColorsManager.white : (isDark ? ColorsManager.grey300 : ColorsManager.grey700),
        ),
      ),
    );
  }

  Widget _buildAvatarPlaceholder() {
    return Container(
      width: 56.w,
      height: 56.w,
      decoration: const BoxDecoration(
        color: ColorsManager.grey200,
        shape: BoxShape.circle,
      ),
      child: Icon(Icons.person_rounded, color: ColorsManager.grey500, size: 28.sp),
    );
  }
}

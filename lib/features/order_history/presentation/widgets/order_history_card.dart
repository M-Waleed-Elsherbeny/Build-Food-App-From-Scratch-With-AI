import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:food_app/core/routes/app_router.dart';
import 'package:food_app/core/theme/colors_manager.dart';
import 'package:food_app/core/theme/app_text_style.dart';
import 'package:food_app/core/theme/app_theme.dart';
import 'package:food_app/core/widgets/primary_button.dart';
import 'package:food_app/features/order_history/data/models/order_history_model.dart';

/// Card widget displaying a single order from the user's history.
class OrderHistoryCard extends StatelessWidget {
  final OrderHistoryModel order;

  const OrderHistoryCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final isActive = order.status == 'Preparing' || order.status == 'On the Way';

    return Container(
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
        children: [
          // Header row with restaurant info
          Padding(
            padding: EdgeInsets.all(14.r),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: order.restaurantImage.isNotEmpty
                      ? Image.network(
                          order.restaurantImage,
                          width: 52.w,
                          height: 52.w,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => _buildImagePlaceholder(),
                        )
                      : _buildImagePlaceholder(),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(order.restaurantName, style: AppTextStyle.font16Grey900Medium),
                      SizedBox(height: 4.h),
                      Text(order.date, style: AppTextStyle.font12Grey500Regular),
                    ],
                  ),
                ),
                // Status chip
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: _getStatusColor(order.status).withOpacity(0.12),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    order.status,
                    style: AppTextStyle.font12Grey500Regular.copyWith(
                      color: _getStatusColor(order.status),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Divider
          Divider(
            height: 1,
            thickness: 1,
            color: isDark ? ColorsManager.grey700 : ColorsManager.grey100,
          ),

          // Order items preview
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
            child: Column(
              children: [
                ...order.items.take(2).map(
                  (item) => Padding(
                    padding: EdgeInsets.only(bottom: 4.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${item.quantity}x ${item.name}',
                          style: AppTextStyle.font14Grey600Regular,
                        ),
                        Text(
                          '\$${(item.price * item.quantity).toStringAsFixed(2)}',
                          style: AppTextStyle.font14Grey700Medium,
                        ),
                      ],
                    ),
                  ),
                ),
                if (order.items.length > 2)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '+${order.items.length - 2} more items',
                      style: AppTextStyle.font12Grey500Regular,
                    ),
                  ),
              ],
            ),
          ),

          // Divider
          Divider(
            height: 1,
            thickness: 1,
            color: isDark ? ColorsManager.grey700 : ColorsManager.grey100,
          ),

          // Footer: total + action button
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Total', style: AppTextStyle.font12Grey500Regular),
                    Text(
                      '\$${order.totalPrice.toStringAsFixed(2)}',
                      style: AppTextStyle.font16PrimaryBold,
                    ),
                  ],
                ),
                isActive
                    ? PrimaryButton(
                        text: 'Track Order',
                        onPressed: () => context.push(AppRoutes.orderTracking, extra: order.id),
                        width: 130.w,
                      )
                    : OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: ColorsManager.primary),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                        ),
                        child: Text('Reorder', style: AppTextStyle.font14PrimarySemiBold),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Preparing':
        return ColorsManager.warning;
      case 'On the Way':
        return ColorsManager.info;
      case 'Delivered':
        return ColorsManager.success;
      default:
        return ColorsManager.grey500;
    }
  }

  Widget _buildImagePlaceholder() {
    return Container(
      width: 52.w,
      height: 52.w,
      color: ColorsManager.grey100,
      child: Icon(Icons.restaurant_rounded, color: ColorsManager.grey300, size: 24.sp),
    );
  }
}

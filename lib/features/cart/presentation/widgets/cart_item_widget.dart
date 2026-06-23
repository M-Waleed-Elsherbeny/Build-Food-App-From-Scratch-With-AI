import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/colors_manager.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../data/models/cart_item_model.dart';
import '../cubit/cart_cubit.dart';

class CartItemWidget extends StatelessWidget {
  final CartItemModel item;

  const CartItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: ColorsManager.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: ColorsManager.grey900.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Image placeholder or network image
          Container(
            width: 80.w,
            height: 80.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: ColorsManager.grey100,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.network(
                item.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.fastfood, color: ColorsManager.grey400, size: 30.sp);
                },
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item.name,
                  style: AppTextStyle.font16Grey900Medium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Text(
                  item.restaurantName,
                  style: AppTextStyle.font12Grey500Regular,
                ),
                SizedBox(height: 8.h),
                Text(
                  '\$${item.price.toStringAsFixed(2)}',
                  style: AppTextStyle.font16PrimarySemiBold,
                ),
              ],
            ),
          ),
          // Quantity Controls
          Row(
            children: [
              _buildControlButton(
                icon: Icons.remove,
                onTap: () => context.read<CartCubit>().decreaseQuantity(item.id),
              ),
              SizedBox(width: 12.w),
              Text(
                item.quantity.toString(),
                style: AppTextStyle.font16Grey900Medium,
              ),
              SizedBox(width: 12.w),
              _buildControlButton(
                icon: Icons.add,
                onTap: () => context.read<CartCubit>().increaseQuantity(item.id),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32.w,
        height: 32.h,
        // ignore: prefer_const_constructors
        decoration: BoxDecoration(
          color: ColorsManager.grey100,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 18.sp,
          color: ColorsManager.grey900,
        ),
      ),
    );
  }
}

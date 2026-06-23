import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/core/theme/colors_manager.dart';
import 'package:food_app/core/theme/app_text_style.dart';
import 'package:food_app/core/theme/app_theme.dart';
import 'package:food_app/features/favorites/data/models/favorite_item_model.dart';

/// Card widget displaying a single favorite food item.
class FavoriteItemCard extends StatelessWidget {
  final FavoriteItemModel item;
  final VoidCallback onRemove;

  const FavoriteItemCard({
    super.key,
    required this.item,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? ColorsManager.grey800 : ColorsManager.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Food image with remove button
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
                child: item.image.isNotEmpty
                    ? Image.network(
                        item.image,
                        height: 130.h,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _buildImagePlaceholder(),
                      )
                    : _buildImagePlaceholder(),
              ),
              // Remove from favorites button
              Positioned(
                top: 8.h,
                right: 8.w,
                child: GestureDetector(
                  onTap: onRemove,
                  child: Container(
                    width: 32.w,
                    height: 32.w,
                    decoration: const BoxDecoration(
                      color: ColorsManager.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.favorite,
                      size: 18.sp,
                      color: ColorsManager.error,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Item details
          Padding(
            padding: EdgeInsets.all(10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: AppTextStyle.font14Grey700Medium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Text(
                  item.restaurantName,
                  style: AppTextStyle.font12Grey500Regular,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 6.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${item.price.toStringAsFixed(2)}',
                      style: AppTextStyle.font14PrimaryBold,
                    ),
                    Row(
                      children: [
                        Icon(Icons.star_rounded, color: ColorsManager.warning, size: 14.sp),
                        SizedBox(width: 2.w),
                        Text(item.rating.toStringAsFixed(1), style: AppTextStyle.font12Grey500Regular),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImagePlaceholder() {
    return Container(
      height: 130.h,
      width: double.infinity,
      color: ColorsManager.grey100,
      child: Icon(Icons.fastfood_rounded, color: ColorsManager.grey300, size: 40.sp),
    );
  }
}

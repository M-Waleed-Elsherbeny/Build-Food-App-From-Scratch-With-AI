import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/theme/colors_manager.dart';
import '../../data/models/menu_item_model.dart';
import '../cubit/restaurant_details_state.dart';

class RestaurantMenuItemsSection extends StatelessWidget {
  final List<MenuItemModel> menuItems;
  final RestaurantDetailsStatus status;
  final Function(MenuItemModel) onAddToCart;

  const RestaurantMenuItemsSection({
    super.key,
    required this.menuItems,
    required this.status,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    if (status == RestaurantDetailsStatus.loading) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    if (menuItems.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 40.h),
        child: Center(
          child: Text(
            'No items available in this category.',
            style: AppTextStyle.font14Grey400Regular,
          ),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(16.w),
      itemCount: menuItems.length,
      separatorBuilder: (context, index) => SizedBox(height: 16.h),
      itemBuilder: (context, index) {
        final item = menuItems[index];
        return _buildMenuItemCard(context, item);
      },
    );
  }

  Widget _buildMenuItemCard(BuildContext context, MenuItemModel item) {
    return Container(
      decoration: BoxDecoration(
        color: ColorsManager.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: ColorsManager.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.network(
                item.image,
                width: 100.w,
                height: 100.w,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 100.w,
                  height: 100.w,
                  color: ColorsManager.grey200,
                  child: Icon(Icons.fastfood, color: ColorsManager.grey400),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: AppTextStyle.font16WhiteSemiBold.copyWith(color: ColorsManager.grey900),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    item.description,
                    style: AppTextStyle.font12Grey500Regular,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${item.price.toStringAsFixed(2)}',
                        style: AppTextStyle.font16WhiteSemiBold.copyWith(color: ColorsManager.primary),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Simple animation interaction
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${item.name} added to cart!'),
                              duration: const Duration(seconds: 1),
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: ColorsManager.success,
                            ),
                          );
                          onAddToCart(item);
                        },
                        child: Container(
                          padding: EdgeInsets.all(8.w),
                          decoration: BoxDecoration(
                            color: ColorsManager.primary,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Icon(Icons.add, color: ColorsManager.white, size: 20.sp),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

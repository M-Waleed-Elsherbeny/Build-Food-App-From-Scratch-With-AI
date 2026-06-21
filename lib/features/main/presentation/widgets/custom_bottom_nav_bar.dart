import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/core/theme/colors_manager.dart';
import 'package:food_app/core/theme/app_theme.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;
  final bool isVisible;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
    this.isVisible = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: isVisible ? 80.h : 0,
      child: Wrap(
        children: [
          Container(
            height: 80.h,
            decoration: BoxDecoration(
              color: context.colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(isDark ? 0.3 : 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(context, 0, Icons.home_outlined, Icons.home, 'Home'),
                _buildNavItem(context, 1, Icons.favorite_border, Icons.favorite, 'Favorites'),
                _buildNavItem(context, 2, Icons.receipt_long_outlined, Icons.receipt_long, 'Orders'),
                _buildNavItem(context, 3, Icons.shopping_cart_outlined, Icons.shopping_cart, 'Cart'),
                _buildNavItem(context, 4, Icons.person_outline, Icons.person, 'Profile'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, int index, IconData icon, IconData activeIcon, String label) {
    final isSelected = selectedIndex == index;
    final isDark = context.isDarkMode;

    return GestureDetector(
      onTap: () => onItemSelected(index),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 60.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                if (isSelected)
                  Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                      color: ColorsManager.primary.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                  ),
                Icon(
                  isSelected ? activeIcon : icon,
                  color: isSelected ? ColorsManager.primary : (isDark ? ColorsManager.grey400 : ColorsManager.grey500),
                  size: 24.sp,
                ),
              ],
            ),
            SizedBox(height: 4.h),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? ColorsManager.primary : (isDark ? ColorsManager.grey400 : ColorsManager.grey500),
                fontSize: 12.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

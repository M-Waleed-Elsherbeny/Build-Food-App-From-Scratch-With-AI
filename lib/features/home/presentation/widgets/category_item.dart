import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/colors_manager.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../data/models/category_model.dart';

class CategoryItem extends StatelessWidget {
  final CategoryModel category;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryItem({
    super.key,
    required this.category,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 64.w,
            height: 64.w,
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: isSelected ? ColorsManager.primary : ColorsManager.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: ColorsManager.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Image.network(
              category.image,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => Icon(
                Icons.fastfood,
                color: isSelected ? ColorsManager.white : ColorsManager.primary,
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            category.name,
            style: AppTextStyle.font12Grey500Regular.copyWith(
              color: isSelected ? ColorsManager.primary : ColorsManager.grey500,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

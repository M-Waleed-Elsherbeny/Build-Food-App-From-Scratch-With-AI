import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:food_app/core/theme/colors_manager.dart';

class FoodDetailsHeader extends StatelessWidget {
  final String imageUrl;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;

  const FoodDetailsHeader({
    super.key,
    required this.imageUrl,
    required this.isFavorite,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 300.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: ColorsManager.grey200,
            image: imageUrl.isNotEmpty
                ? DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          child: imageUrl.isEmpty
              ? Center(child: Icon(Icons.fastfood, size: 80.sp, color: ColorsManager.grey400))
              : null,
        ),
        Positioned(
          top: 50.h,
          left: 20.w,
          child: CircleAvatar(
            backgroundColor: ColorsManager.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: ColorsManager.black),
              onPressed: () => context.pop(),
            ),
          ),
        ),
        Positioned(
          top: 50.h,
          right: 20.w,
          child: CircleAvatar(
            backgroundColor: ColorsManager.white,
            child: IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: ColorsManager.primary,
              ),
              onPressed: onFavoriteToggle,
            ),
          ),
        ),
      ],
    );
  }
}

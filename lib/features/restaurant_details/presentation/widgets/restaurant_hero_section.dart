import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/colors_manager.dart';

class RestaurantHeroSection extends StatelessWidget {
  final String imageUrl;
  final bool isFavorite;
  final VoidCallback onFavoriteTap;

  const RestaurantHeroSection({
    super.key,
    required this.imageUrl,
    required this.isFavorite,
    required this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(
          imageUrl,
          width: double.infinity,
          height: 250.h,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container(
            width: double.infinity,
            height: 250.h,
            color: ColorsManager.grey200,
            child: Icon(Icons.restaurant, color: ColorsManager.grey400, size: 50.sp),
          ),
        ),
        Positioned(
          top: 40.h,
          left: 16.w,
          child: InkWell(
            onTap: () => context.pop(),
            child: CircleAvatar(
              backgroundColor: ColorsManager.white,
              radius: 20.r,
              child: Icon(Icons.arrow_back, color: ColorsManager.black, size: 24.sp),
            ),
          ),
        ),
        Positioned(
          top: 40.h,
          right: 16.w,
          child: InkWell(
            onTap: onFavoriteTap,
            child: CircleAvatar(
              backgroundColor: ColorsManager.white,
              radius: 20.r,
              child: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? ColorsManager.error : ColorsManager.black,
                size: 24.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

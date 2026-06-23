import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/colors_manager.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../data/models/offer_model.dart';

class OfferBanner extends StatelessWidget {
  final OfferModel offer;
  final VoidCallback onTap;

  const OfferBanner({
    super.key,
    required this.offer,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 320.w,
        margin: EdgeInsets.only(right: 16.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              ColorsManager.primaryGradientStart,
              ColorsManager.primaryGradientEnd,
            ],
          ),
        ),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: ColorsManager.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      offer.code,
                      style: AppTextStyle.font12Grey500Regular.copyWith(
                        color: ColorsManager.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    offer.title,
                    style: AppTextStyle.font20Grey900Bold
                        .copyWith(color: ColorsManager.white),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    offer.description,
                    style: AppTextStyle.font12Grey500Regular.copyWith(
                        color: ColorsManager.white.withValues(alpha: 0.9)),
                  ),
                ],
              ),
            ),
            Positioned(
              right: -20.w,
              bottom: -10.h,
              child: Opacity(
                opacity: 0.2,
                child: Icon(
                  Icons.local_offer,
                  size: 100.sp,
                  color: ColorsManager.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

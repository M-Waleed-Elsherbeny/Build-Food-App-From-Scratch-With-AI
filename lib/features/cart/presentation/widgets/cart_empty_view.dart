import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/core/routes/app_router.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/colors_manager.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/widgets/primary_button.dart';

class CartEmptyView extends StatelessWidget {
  const CartEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_cart_outlined,
              size: 80.sp, color: ColorsManager.grey300),
          SizedBox(height: 16.h),
          Text(
            'Your cart is empty',
            style: AppTextStyle.font20Grey900Bold,
          ),
          SizedBox(height: 8.h),
          Text(
            'Looks like you haven\'t added\nanything to your cart yet',
            textAlign: TextAlign.center,
            style: AppTextStyle.font14Grey600Regular,
          ),
          SizedBox(height: 32.h),
          SizedBox(
            width: 200.w,
            child: PrimaryButton(
              text: 'Start Shopping',
              onPressed: () => context.pushReplacement(AppRoutes.main),
            ),
          )
        ],
      ),
    );
  }
}

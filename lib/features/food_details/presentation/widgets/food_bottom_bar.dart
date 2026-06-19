import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/core/theme/app_text_style.dart';
import 'package:food_app/core/theme/colors_manager.dart';
import 'package:food_app/core/widgets/primary_button.dart'; // Assume this exists based on common rules
import 'package:food_app/features/food_details/presentation/cubit/food_details_cubit.dart';

class FoodBottomBar extends StatelessWidget {
  final double price;
  final int quantity;

  const FoodBottomBar({
    Key? key,
    required this.price,
    required this.quantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: ColorsManager.white,
        boxShadow: [
          BoxShadow(
            color: ColorsManager.grey200,
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            // Quantity Control
            Container(
              decoration: BoxDecoration(
                color: ColorsManager.grey100,
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.remove, color: ColorsManager.grey900, size: 20.sp),
                    onPressed: () {
                      context.read<FoodDetailsCubit>().decrementQuantity();
                    },
                  ),
                  Text(
                    '$quantity',
                    style: AppTextStyle.font16Grey900Medium,
                  ),
                  IconButton(
                    icon: Icon(Icons.add, color: ColorsManager.primary, size: 20.sp),
                    onPressed: () {
                      context.read<FoodDetailsCubit>().incrementQuantity();
                    },
                  ),
                ],
              ),
            ),
            SizedBox(width: 16.w),
            // Add to Cart Button
            Expanded(
              child: PrimaryButton(
                onPressed: () {
                  context.read<FoodDetailsCubit>().addToCart();
                },
                text: 'Add to Cart • \$${price.toStringAsFixed(2)}',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

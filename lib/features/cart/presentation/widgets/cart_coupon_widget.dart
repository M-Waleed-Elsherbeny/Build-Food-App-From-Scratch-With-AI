import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/colors_manager.dart';
import '../../../../core/theme/app_text_style.dart';
import '../cubit/cart_cubit.dart';
import '../cubit/cart_state.dart';

class CartCouponWidget extends StatefulWidget {
  const CartCouponWidget({super.key});

  @override
  State<CartCouponWidget> createState() => _CartCouponWidgetState();
}

class _CartCouponWidgetState extends State<CartCouponWidget> {
  final TextEditingController _couponController = TextEditingController();

  @override
  void dispose() {
    _couponController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        if (state.appliedCoupon != null) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: ColorsManager.success.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: ColorsManager.success.withValues(alpha: 0.5)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.local_offer, color: ColorsManager.success, size: 20.sp),
                    SizedBox(width: 8.w),
                    Text(
                      'Coupon ${state.appliedCoupon!.code} applied!',
                      style: AppTextStyle.font14Grey700Medium.copyWith(color: ColorsManager.success),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    _couponController.clear();
                    context.read<CartCubit>().removeCoupon();
                  },
                  child: Icon(Icons.close, color: ColorsManager.grey500, size: 20.sp),
                ),
              ],
            ),
          );
        }

        return Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 48.h,
                child: TextField(
                  controller: _couponController,
                  decoration: InputDecoration(
                    hintText: 'Enter Promo Code',
                    hintStyle: AppTextStyle.font14Grey400Regular,
                    filled: true,
                    fillColor: ColorsManager.grey100,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: AppTextStyle.font14Grey700Medium,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            SizedBox(
              height: 48.h,
              child: ElevatedButton(
                onPressed: state.isCouponLoading
                    ? null
                    : () {
                        context.read<CartCubit>().validateCoupon(_couponController.text.trim());
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorsManager.grey900,
                  foregroundColor: ColorsManager.white,
                  minimumSize: Size(0, 48.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                ),
                child: state.isCouponLoading
                    ? SizedBox(
                        height: 20.h,
                        width: 20.w,
                        child: const CircularProgressIndicator(color: ColorsManager.white, strokeWidth: 2),
                      )
                    : Text('Apply', style: AppTextStyle.font14Grey700Medium.copyWith(color: ColorsManager.white)),
              ),
            ),
          ],
        );
      },
    );
  }
}

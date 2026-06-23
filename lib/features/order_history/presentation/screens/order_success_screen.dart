import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:food_app/core/routes/app_router.dart';
import 'package:food_app/core/theme/colors_manager.dart';
import 'package:food_app/core/theme/app_text_style.dart';
import 'package:food_app/core/theme/app_theme.dart';
import 'package:food_app/core/widgets/primary_button.dart';
import 'package:food_app/features/order_history/data/models/order_success_model.dart';
import '../cubit/order_success_cubit.dart';
import '../cubit/order_success_state.dart';

/// Screen displayed after a successful order checkout.
class OrderSuccessScreen extends StatefulWidget {
  const OrderSuccessScreen({super.key});

  @override
  State<OrderSuccessScreen> createState() => _OrderSuccessScreenState();
}

class _OrderSuccessScreenState extends State<OrderSuccessScreen> {
  @override
  void initState() {
    super.initState();
    context.read<OrderSuccessCubit>().loadOrderSuccessData();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return Scaffold(
      backgroundColor:
          isDark ? ColorsManager.backgroundDark : ColorsManager.backgroundLight,
      body: SafeArea(
        child: BlocBuilder<OrderSuccessCubit, OrderSuccessState>(
          builder: (context, state) {
            final data = state.orderSuccessData ?? OrderSuccessModel.fake();

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  // Animated success checkmark placeholder
                  Container(
                    width: 120.w,
                    height: 120.w,
                    decoration: BoxDecoration(
                      color: ColorsManager.success.withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.check_circle_rounded,
                        color: ColorsManager.success,
                        size: 80.sp,
                      ),
                    ),
                  ),
                  SizedBox(height: 32.h),
                  Text(
                    'Order Placed Successfully!',
                    style: AppTextStyle.font20Grey900Bold,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    'Your delicious meal will be prepared shortly.',
                    style: AppTextStyle.font14Grey600Regular,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 40.h),

                  // Order Summary Card
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20.r),
                    decoration: BoxDecoration(
                      color:
                          isDark ? ColorsManager.grey800 : ColorsManager.white,
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black
                              .withValues(alpha: isDark ? 0.3 : 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        _buildSummaryRow(
                          'Order Number',
                          '#${data.orderNumber}',
                          isDark,
                          isHighlight: true,
                        ),
                        Divider(
                            color: isDark
                                ? ColorsManager.grey700
                                : ColorsManager.grey200,
                            height: 24.h),
                        _buildSummaryRow(
                          'Restaurant',
                          data.restaurantName,
                          isDark,
                        ),
                        SizedBox(height: 12.h),
                        _buildSummaryRow(
                          'Estimated Delivery',
                          '${data.etaMinutes} mins',
                          isDark,
                        ),
                        SizedBox(height: 12.h),
                        _buildSummaryRow(
                          'Payment Details',
                          '${data.paymentMethod} (${data.paymentDetails})',
                          isDark,
                        ),
                        SizedBox(height: 12.h),
                        _buildSummaryRow(
                          'Total Price',
                          '\$${data.totalPrice.toStringAsFixed(2)}',
                          isDark,
                          isPrice: true,
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),

                  // Navigation Action Buttons
                  PrimaryButton(
                    text: 'Track Order',
                    onPressed: () {
                      context.push(AppRoutes.orderTracking,
                          extra: data.orderNumber);
                    },
                  ),
                  SizedBox(height: 12.h),
                  OutlinedButton(
                    onPressed: () {
                      context.go(AppRoutes.main);
                    },
                    style: OutlinedButton.styleFrom(
                      minimumSize: Size(double.infinity, 56.h),
                      side: const BorderSide(color: ColorsManager.primary),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      'Back to Home',
                      style: AppTextStyle.font16PrimaryBold,
                    ),
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSummaryRow(
    String title,
    String value,
    bool isDark, {
    bool isHighlight = false,
    bool isPrice = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTextStyle.font14Grey600Regular,
        ),
        Text(
          value,
          style: isPrice
              ? AppTextStyle.font16PrimaryBold
              : isHighlight
                  ? AppTextStyle.font14Grey700Medium.copyWith(
                      color: ColorsManager.primary,
                      fontWeight: FontWeight.w700,
                    )
                  : AppTextStyle.font14Grey700Medium,
        ),
      ],
    );
  }
}

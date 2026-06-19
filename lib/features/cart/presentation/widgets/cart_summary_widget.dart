import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/colors_manager.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../data/models/cart_summary_model.dart';

class CartSummaryWidget extends StatelessWidget {
  final CartSummaryModel summary;

  const CartSummaryWidget({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: ColorsManager.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: ColorsManager.grey900.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Summary',
            style: AppTextStyle.font18Grey900SemiBold,
          ),
          SizedBox(height: 16.h),
          _buildSummaryRow('Subtotal', summary.subtotal),
          SizedBox(height: 12.h),
          _buildSummaryRow('Delivery Fee', summary.deliveryFee),
          SizedBox(height: 12.h),
          _buildSummaryRow('Tax', summary.taxAmount),
          if (summary.discountAmount > 0) ...[
            SizedBox(height: 12.h),
            _buildSummaryRow('Discount', -summary.discountAmount, isDiscount: true),
          ],
          SizedBox(height: 16.h),
          const Divider(color: ColorsManager.grey200),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: AppTextStyle.font18Grey900SemiBold,
              ),
              Text(
                '\$${summary.total.toStringAsFixed(2)}',
                style: AppTextStyle.font24BlackBold.copyWith(color: ColorsManager.primary),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, double amount, {bool isDiscount = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyle.font14Grey600Regular,
        ),
        Text(
          '${isDiscount ? '' : '\$'}${amount.toStringAsFixed(2)}',
          style: AppTextStyle.font16Grey900Medium.copyWith(
            color: isDiscount ? ColorsManager.success : ColorsManager.grey900,
          ),
        ),
      ],
    );
  }
}

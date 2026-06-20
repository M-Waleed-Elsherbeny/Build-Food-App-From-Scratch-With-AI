import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/theme/colors_manager.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/theme/app_theme.dart';
import '../../data/models/cart_item_model.dart';
import '../cubit/cart_cubit.dart';
import '../cubit/cart_state.dart';
import '../widgets/cart_coupon_widget.dart';
import '../widgets/cart_item_widget.dart';
import '../widgets/cart_summary_widget.dart';
import '../widgets/cart_empty_view.dart';
import '../widgets/cart_checkout_bottom_bar.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return Scaffold(
      backgroundColor: isDark
          ? ColorsManager.backgroundDark
          : ColorsManager.backgroundLight,
      appBar: AppBar(
        backgroundColor: isDark ? ColorsManager.grey900 : ColorsManager.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'My Cart',
          style: isDark
              ? AppTextStyle.font18WhiteSemiBold
              : AppTextStyle.font18Grey900SemiBold,
        ),
        leading: const SizedBox(),
      ),
      body: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {
          if (state.errorMsg.isNotEmpty &&
              !state.isLoading &&
              !state.isCouponLoading) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.errorMsg,
                  style: AppTextStyle.font14Grey700Medium.copyWith(
                    color: ColorsManager.white,
                  ),
                ),
                backgroundColor: ColorsManager.error,
              ),
            );
          }
          if (state.status == CartStatus.checkoutReady) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Processing checkout...',
                  style: AppTextStyle.font14Grey700Medium.copyWith(
                    color: ColorsManager.white,
                  ),
                ),
                backgroundColor: ColorsManager.success,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state.status == CartStatus.empty) {
            return const CartEmptyView();
          }

          final items = state.isLoading
              ? List.generate(3, (_) => CartItemModel.fake())
              : state.items;

          return Skeletonizer(
            enabled: state.isLoading,
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.all(20.w),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return CartItemWidget(item: items[index]);
                    }, childCount: items.length),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CartCouponWidget(),
                        SizedBox(height: 24.h),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    padding: EdgeInsets.only(bottom: 120.h),
                    child: CartSummaryWidget(summary: state.summary),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomSheet: const CartCheckoutBottomBar(),
    );
  }
}

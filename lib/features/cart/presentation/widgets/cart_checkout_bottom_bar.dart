import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/colors_manager.dart';
import '../../../../core/widgets/primary_button.dart';
import '../cubit/cart_cubit.dart';
import '../cubit/cart_state.dart';

class CartCheckoutBottomBar extends StatelessWidget {
  const CartCheckoutBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        if (state.status == CartStatus.empty || state.isLoading) {
          return const SizedBox.shrink();
        }

        return SizedBox(
          width: 1.sw,
          child: Container(
            padding: EdgeInsets.only(
              left: 20.w,
              right: 20.w,
              top: 16.h,
              bottom: MediaQuery.of(context).padding.bottom + 16.h,
            ),
            decoration: BoxDecoration(
              color: ColorsManager.white,
              boxShadow: [
                BoxShadow(
                  color: ColorsManager.grey900.withValues(alpha: 0.08),
                  blurRadius: 20,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: SafeArea(
              child: PrimaryButton(
                text: state.status == CartStatus.checkoutReady
                    ? 'Processing...'
                    : 'Checkout • \$${state.summary.total.toStringAsFixed(2)}',
                onPressed: state.status == CartStatus.checkoutReady
                    ? null
                    : () {
                        context.read<CartCubit>().checkout();
                      },
              ),
            ),
          ),
        );
      },
    );
  }
}

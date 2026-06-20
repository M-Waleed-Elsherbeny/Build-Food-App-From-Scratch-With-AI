import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:food_app/features/food_details/presentation/cubit/food_details_cubit.dart';
import 'package:food_app/features/food_details/presentation/cubit/food_details_state.dart';
import 'package:food_app/features/food_details/presentation/widgets/food_details_header.dart';
import 'package:food_app/features/food_details/presentation/widgets/food_info_section.dart';
import 'package:food_app/features/food_details/presentation/widgets/food_customization_section.dart';
import 'package:food_app/features/food_details/presentation/widgets/food_addons_section.dart';
import 'package:food_app/features/food_details/presentation/widgets/food_bottom_bar.dart';
import 'package:food_app/core/theme/colors_manager.dart';

class FoodDetailsScreen extends StatelessWidget {
  final String foodId;

  const FoodDetailsScreen({super.key, required this.foodId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.white,
      body: BlocConsumer<FoodDetailsCubit, FoodDetailsState>(
        listener: (context, state) {
          if (state.status == FoodDetailsStatus.addToCartSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Item added to cart successfully!'),
                backgroundColor: ColorsManager.success,
                behavior: SnackBarBehavior.floating,
              ),
            );
            context.pop();
          } else if (state.status == FoodDetailsStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMsg),
                backgroundColor: ColorsManager.error,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state.status == FoodDetailsStatus.loading || state.status == FoodDetailsStatus.initial;
          final food = state.food;

          return Skeletonizer(
            enabled: isLoading,
            child: food == null && !isLoading 
                ? const Center(child: Text('Food details not found'))
                : Stack(
                    children: [
                      SingleChildScrollView(
                        padding: const EdgeInsets.only(bottom: 100), // Space for bottom bar
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FoodDetailsHeader(
                              imageUrl: food?.image ?? '',
                              isFavorite: state.isFavorite,
                              onFavoriteToggle: () => context.read<FoodDetailsCubit>().toggleFavorite(),
                            ),
                            FoodInfoSection(food: food),
                            if (food?.customizations.isNotEmpty == true)
                              FoodCustomizationSection(
                                customizations: food!.customizations,
                                selectedOptions: state.selectedCustomizations,
                              ),
                            if (food?.addons.isNotEmpty == true)
                              FoodAddonsSection(
                                addons: food!.addons,
                                selectedAddons: state.selectedAddons,
                              ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: FoodBottomBar(
                          price: state.totalPrice,
                          quantity: state.quantity,
                        ),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}

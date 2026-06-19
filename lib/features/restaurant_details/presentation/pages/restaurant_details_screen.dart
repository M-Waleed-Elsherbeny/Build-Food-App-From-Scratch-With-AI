import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/features/restaurant_details/data/models/menu_item_model.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/theme/colors_manager.dart';
import '../cubit/restaurant_details_cubit.dart';
import '../cubit/restaurant_details_state.dart';
import '../widgets/restaurant_hero_section.dart';
import '../widgets/restaurant_info_section.dart';
import '../widgets/restaurant_menu_tabs.dart';
import '../widgets/restaurant_menu_items_section.dart';
import '../widgets/sticky_cart_cta.dart';
import '../widgets/restaurant_error_widget.dart';
import '../../data/models/restaurant_model.dart';

class RestaurantDetailsScreen extends StatelessWidget {
  const RestaurantDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.backgroundLight,
      body: BlocConsumer<RestaurantDetailsCubit, RestaurantDetailsState>(
        listenWhen: (previous, current) =>
            previous.error != current.error && current.error != null,
        listener: (context, state) {
          if (state.restaurant != null && state.error != null) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error!),
                backgroundColor: ColorsManager.error,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state.status == RestaurantDetailsStatus.loading && state.restaurant == null;
          
          if (state.status == RestaurantDetailsStatus.failure && state.restaurant == null) {
            return RestaurantErrorWidget(
              error: state.error ?? 'Failed to load restaurant details',
              onRetry: () => context.read<RestaurantDetailsCubit>().loadRestaurantData(''), // ID should be handled better
            );
          }

          final restaurant = isLoading ? RestaurantModel.fake() : state.restaurant;
          final menuItems = isLoading ? List.generate(6, (_) => MenuItemModel.fake()) : state.menuItems;

          if (restaurant == null && !isLoading) return const SizedBox.shrink();

          return Skeletonizer(
            enabled: isLoading,
            child: Stack(
              children: [
                SingleChildScrollView(
                  padding: EdgeInsets.only(bottom: 100.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RestaurantHeroSection(
                        imageUrl: restaurant!.imageUrl,
                        isFavorite: restaurant.isFavorite,
                        onFavoriteTap: () {
                          context.read<RestaurantDetailsCubit>().toggleFavorite();
                        },
                      ),
                      RestaurantInfoSection(
                        restaurant: restaurant,
                      ),
                      SizedBox(height: 16.h),
                      RestaurantMenuTabs(
                        categories: state.categories,
                        selectedCategoryId: state.selectedCategoryId,
                        onCategorySelected: (categoryId) {
                          context
                              .read<RestaurantDetailsCubit>()
                              .selectCategory(categoryId);
                        },
                      ),
                      SizedBox(height: 8.h),
                      RestaurantMenuItemsSection(
                        menuItems: menuItems,
                        status: state.status,
                        onAddToCart: (item) {
                          context.read<RestaurantDetailsCubit>().addToCart(item);
                        },
                      ),
                    ],
                  ),
                ),
                if (!isLoading)
                  StickyCartCta(
                    isUpdating: state.isCartUpdating,
                    onCheckoutTap: () {
                      context.push(AppRoutes.cart);
                    },
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

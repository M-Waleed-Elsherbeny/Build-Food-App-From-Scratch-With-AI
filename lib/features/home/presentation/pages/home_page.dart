import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/core/theme/app_theme.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/theme/colors_manager.dart';
import '../../data/models/category_model.dart';
import '../../data/models/food_model.dart';
import '../../data/models/offer_model.dart';
import '../../../restaurant_details/data/models/restaurant_model.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';
import '../widgets/home_top_bar.dart';
import '../widgets/home_error_widget.dart';
import '../widgets/home_offers_list_view.dart';
import '../widgets/home_categories_list_view.dart';
import '../widgets/home_popular_restaurants_list_view.dart';
import '../widgets/home_recommended_meals_list_view.dart';

class HomePage extends StatefulWidget {
  final Function(bool)? onScrollDirectionChanged;

  const HomePage({super.key, this.onScrollDirectionChanged});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedCategoryId = '1';
  bool _isHeaderVisible = true;

  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().getHomeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.isDarkMode
          ? ColorsManager.backgroundDark
          : ColorsManager.backgroundLight,
      body: SafeArea(
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            final isLoading = state.status == HomeStatus.loading;
            final categories = isLoading
                ? List.generate(6, (_) => CategoryModel.fake())
                : state.categories;
            final offers = isLoading
                ? List.generate(3, (_) => OfferModel.fake())
                : state.offers;
            final restaurants = isLoading
                ? List.generate(4, (_) => RestaurantModel.fake())
                : state.restaurants;
            final meals = isLoading
                ? List.generate(4, (_) => FoodModel.fake())
                : state.meals;

            if (state.status == HomeStatus.failure) {
              return HomeErrorWidget(
                error: state.error,
                onRetry: () => context.read<HomeCubit>().getHomeData(),
              );
            }

            return Column(
              children: [
                HomeTopBar(isVisible: _isHeaderVisible),
                Expanded(
                  child: NotificationListener<UserScrollNotification>(
                    onNotification: (notification) {
                      if (notification.direction == ScrollDirection.reverse) {
                        _updateVisibility(false);
                      } else if (notification.direction ==
                          ScrollDirection.forward) {
                        _updateVisibility(true);
                      }
                      return true;
                    },
                    child: Skeletonizer(
                      enabled: isLoading,
                      child: RefreshIndicator(
                        onRefresh: () => context.read<HomeCubit>().refresh(),
                        color: ColorsManager.primary,
                        child: CustomScrollView(
                          slivers: [
                            SliverToBoxAdapter(child: SizedBox(height: 16.h)),
                            HomeOffersListView(offers: offers),
                            HomeCategoriesListView(
                              categories: categories,
                              selectedCategoryId: selectedCategoryId,
                              onCategorySelected: (id) {
                                setState(() => selectedCategoryId = id);
                              },
                            ),
                            HomePopularRestaurantsListView(
                              restaurants: restaurants,
                            ),
                            HomeRecommendedMealsListView(meals: meals),
                            SliverToBoxAdapter(child: SizedBox(height: 24.h)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _updateVisibility(bool visible) {
    if (_isHeaderVisible != visible) {
      setState(() => _isHeaderVisible = visible);
      widget.onScrollDirectionChanged?.call(!visible);
    }
  }
}

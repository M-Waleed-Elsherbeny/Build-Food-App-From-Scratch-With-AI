import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/features/restaurant_details/data/models/restaurant_model.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/colors_manager.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/routes/app_router.dart';
import '../../../home/presentation/widgets/restaurant_card.dart';
import '../../../home/presentation/widgets/search_empty_state.dart';
import '../cubit/search_cubit.dart';
import '../cubit/search_state.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.backgroundLight,
      appBar: AppBar(
        backgroundColor: ColorsManager.white,
        elevation: 0,
        title: TextField(
          controller: _searchController,
          autofocus: true,
          style: AppTextStyle.font14Grey700Medium,
          onChanged: (query) => context.read<SearchCubit>().search(query),
          onSubmitted: (query) =>
              context.read<SearchCubit>().submitSearch(query),
          decoration: const InputDecoration(
            hintText: 'Search food, restaurants...',
            hintStyle: TextStyle(color: ColorsManager.grey400),
            border: InputBorder.none,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: ColorsManager.grey900),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: ColorsManager.grey500),
            onPressed: () {
              _searchController.clear();
              context.read<SearchCubit>().search('');
            },
          ),
        ],
      ),
      body: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          if (state.query.isEmpty && state.status == SearchStatus.initial) {
            return _buildInitialState(context, state);
          }

          final isLoading = state.status == SearchStatus.loading;
          final restaurants = isLoading
              ? List.generate(5, (_) => RestaurantModel.fake())
              : (state.searchResult?.restaurants ?? []);

          if (!isLoading && restaurants.isEmpty) {
            return const SearchEmptyState();
          }

          return Skeletonizer(
            enabled: isLoading,
            child: ListView.builder(
              padding: EdgeInsets.all(16.w),
              itemCount: restaurants.length,
              itemBuilder: (context, index) {
                final restaurant = restaurants[index];
                return Padding(
                  padding: EdgeInsets.only(bottom: 16.h),
                  child: RestaurantCard(
                    restaurant: restaurant,
                    width: double.infinity,
                    onTap: () {
                      context.push(AppRoutes.restaurantDetails,
                          extra: restaurant.id);
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildInitialState(BuildContext context, SearchState state) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (state.recentSearches.isNotEmpty) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Recent Searches',
                    style: AppTextStyle.font18Grey900SemiBold),
                TextButton(
                  onPressed: () =>
                      context.read<SearchCubit>().clearRecentSearches(),
                  child: Text('Clear All',
                      style: AppTextStyle.font14PrimarySemiBold),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: state.recentSearches.map((query) {
                return ActionChip(
                  label: Text(query, style: AppTextStyle.font14Grey700Medium),
                  backgroundColor: ColorsManager.white,
                  side: const BorderSide(color: ColorsManager.grey300),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r)),
                  onPressed: () {
                    _searchController.text = query;
                    context.read<SearchCubit>().submitSearch(query);
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 24.h),
          ],
          if (state.trendingSearches.isNotEmpty) ...[
            Text('Trending Searches',
                style: AppTextStyle.font18Grey900SemiBold),
            SizedBox(height: 12.h),
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: state.trendingSearches.map((query) {
                return ActionChip(
                  avatar: Icon(Icons.trending_up,
                      size: 16.sp, color: ColorsManager.primary),
                  label: Text(query, style: AppTextStyle.font14Grey700Medium),
                  backgroundColor: ColorsManager.primary.withValues(alpha: 0.1),
                  side: BorderSide.none,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r)),
                  onPressed: () {
                    _searchController.text = query;
                    context.read<SearchCubit>().submitSearch(query);
                  },
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }
}

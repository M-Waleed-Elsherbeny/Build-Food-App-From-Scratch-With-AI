import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:food_app/core/theme/colors_manager.dart';
import 'package:food_app/core/theme/app_text_style.dart';
import 'package:food_app/core/theme/app_theme.dart';
import 'package:food_app/features/favorites/data/models/favorite_item_model.dart';
import '../cubit/favorites_cubit.dart';
import '../cubit/favorites_state.dart';
import '../widgets/favorite_item_card.dart';
import '../widgets/favorites_empty_state.dart';

/// Favorites screen showing a grid of saved food items.
class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FavoritesCubit>().loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return Scaffold(
      backgroundColor:
          isDark ? ColorsManager.backgroundDark : ColorsManager.backgroundLight,
      appBar: AppBar(
        backgroundColor: isDark
            ? ColorsManager.backgroundDark
            : ColorsManager.backgroundLight,
        elevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: Text('My Favorites', style: AppTextStyle.font20Grey900Bold),
        actions: [
          BlocBuilder<FavoritesCubit, FavoritesState>(
            builder: (context, state) {
              if (state.favorites.isNotEmpty) {
                return TextButton(
                  onPressed: () {
                    for (final item in List.from(state.favorites)) {
                      context.read<FavoritesCubit>().removeFavorite(item.id);
                    }
                  },
                  child: Text('Clear All',
                      style: AppTextStyle.font14PrimarySemiBold),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: BlocBuilder<FavoritesCubit, FavoritesState>(
        builder: (context, state) {
          final isLoading = state.status == FavoritesStatus.loading || state.status == FavoritesStatus.initial;
          final items = isLoading
              ? List.generate(6, (_) => FavoriteItemModel.fake())
              : state.favorites;

          if (!isLoading &&
              (state.status == FavoritesStatus.empty || items.isEmpty)) {
            return const FavoritesEmptyState();
          }

          return Skeletonizer(
            enabled: isLoading,
            child: GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12.w,
                mainAxisSpacing: 12.h,
                childAspectRatio: 0.6,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return FavoriteItemCard(
                  item: items[index],
                  onRemove: () => context
                      .read<FavoritesCubit>()
                      .removeFavorite(items[index].id),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/routes/app_router.dart';
import '../../../restaurant_details/data/models/restaurant_model.dart';
import 'restaurant_card.dart';

class HomePopularRestaurantsListView extends StatelessWidget {
  final List<RestaurantModel> restaurants;

  const HomePopularRestaurantsListView({super.key, required this.restaurants});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  tr('popular_restaurants'),
                  style: context.isDarkMode 
                      ? AppTextStyle.font18WhiteSemiBold 
                      : AppTextStyle.font18Grey900SemiBold,
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    tr('see_all'),
                    style: AppTextStyle.font14PrimarySemiBold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 250.h,
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              scrollDirection: Axis.horizontal,
              itemCount: restaurants.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(right: 16.w),
                  child: RestaurantCard(
                    restaurant: restaurants[index],
                    onTap: () {
                      context.push(AppRoutes.restaurantDetails,
                          extra: restaurants[index].id);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

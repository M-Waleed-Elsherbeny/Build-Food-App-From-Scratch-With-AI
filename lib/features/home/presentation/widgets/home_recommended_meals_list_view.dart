import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/core/routes/app_router.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../data/models/food_model.dart';
import 'meal_card.dart';

class HomeRecommendedMealsListView extends StatelessWidget {
  final List<FoodModel> meals;

  const HomeRecommendedMealsListView({super.key, required this.meals});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recommended for you',
                  style: AppTextStyle.font18Grey900SemiBold,
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'See All',
                    style: AppTextStyle.font14PrimarySemiBold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 200.h,
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              scrollDirection: Axis.horizontal,
              itemCount: meals.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(right: 16.w),
                  child: MealCard(
                    meal: meals[index],
                    onTap: () => context.push(AppRoutes.foodDetails,
                        extra: meals[index].id),
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

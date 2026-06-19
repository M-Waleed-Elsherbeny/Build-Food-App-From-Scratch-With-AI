import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../data/models/category_model.dart';
import '../cubit/home_cubit.dart';
import 'category_item.dart';

class HomeCategoriesListView extends StatelessWidget {
  final List<CategoryModel> categories;
  final String selectedCategoryId;
  final Function(String) onCategorySelected;

  const HomeCategoriesListView({
    super.key,
    required this.categories,
    required this.selectedCategoryId,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Categories',
              style: AppTextStyle.font18Grey900SemiBold,
            ),
            SizedBox(height: 16.h),
            SizedBox(
              height: 100.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                separatorBuilder: (context, _) => SizedBox(width: 16.w),
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return CategoryItem(
                    category: category,
                    isSelected: selectedCategoryId == category.id,
                    onTap: () {
                      onCategorySelected(category.id);
                      context.read<HomeCubit>().filterByCategory(category.name);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/core/theme/app_text_style.dart';
import 'package:food_app/core/theme/colors_manager.dart';
import 'package:food_app/features/food_details/data/models/customization_model.dart';
import 'package:food_app/features/food_details/presentation/cubit/food_details_cubit.dart';

class FoodCustomizationSection extends StatelessWidget {
  final List<CustomizationModel> customizations;
  final Map<String, String> selectedOptions;

  const FoodCustomizationSection({
    super.key,
    required this.customizations,
    required this.selectedOptions,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: customizations.map((customization) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    customization.title,
                    style: AppTextStyle.font18Grey900SemiBold,
                  ),
                  if (customization.isRequired)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: ColorsManager.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        'Required',
                        style: AppTextStyle.font14PrimarySemiBold,
                      ),
                    ),
                ],
              ),
              SizedBox(height: 8.h),
              Wrap(
                spacing: 12.w,
                children: customization.options.map((option) {
                  final isSelected = selectedOptions[customization.id] == option;
                  return ChoiceChip(
                    label: Text(option),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) {
                        context.read<FoodDetailsCubit>().selectCustomization(customization.id, option);
                      }
                    },
                    selectedColor: ColorsManager.primary,
                    backgroundColor: ColorsManager.grey100,
                    labelStyle: isSelected
                        ? AppTextStyle.font14WhiteRegular
                        : AppTextStyle.font14Grey700Medium,
                    showCheckmark: false,
                  );
                }).toList(),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

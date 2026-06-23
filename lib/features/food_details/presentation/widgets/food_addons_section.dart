import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/core/theme/app_text_style.dart';
import 'package:food_app/core/theme/colors_manager.dart';
import 'package:food_app/features/food_details/data/models/addon_model.dart';
import 'package:food_app/features/food_details/presentation/cubit/food_details_cubit.dart';

class FoodAddonsSection extends StatelessWidget {
  final List<AddonModel> addons;
  final List<AddonModel> selectedAddons;

  const FoodAddonsSection({super.key, required this.addons, required this.selectedAddons});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 24.h),
          Text(
            'Addons',
            style: AppTextStyle.font18Grey900SemiBold,
          ),
          SizedBox(height: 12.h),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: addons.length,
            itemBuilder: (context, index) {
              final addon = addons[index];
              final isSelected = selectedAddons.any((e) => e.id == addon.id);
              return CheckboxListTile(
                value: isSelected,
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: ColorsManager.primary,
                checkColor: ColorsManager.white,
                title: Text(
                  addon.name,
                  style: AppTextStyle.font16Grey900Medium,
                ),
                secondary: Text(
                  '+\$${addon.price.toStringAsFixed(2)}',
                  style: AppTextStyle.font16PrimarySemiBold,
                ),
                onChanged: (_) {
                  context.read<FoodDetailsCubit>().toggleAddon(addon);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

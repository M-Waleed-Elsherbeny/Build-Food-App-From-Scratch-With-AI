import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/colors_manager.dart';
import '../../../../core/theme/app_text_style.dart';
import '../cubit/profile_cubit.dart';

class ProfileLogoutButton extends StatelessWidget {
  const ProfileLogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: SizedBox(
        width: double.infinity,
        height: 56.h,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: ColorsManager.error),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
          ),
          onPressed: () {
            context.read<ProfileCubit>().logout();
          },
          child: Text(
            'Logout',
            style: AppTextStyle.font16WhiteSemiBold.copyWith(color: ColorsManager.error),
          ),
        ),
      ),
    );
  }
}

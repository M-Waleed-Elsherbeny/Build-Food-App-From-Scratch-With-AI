import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/colors_manager.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/routes/app_router.dart';
import '../cubit/profile_cubit.dart';
import '../cubit/profile_state.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_menu_section.dart';
import '../widgets/profile_logout_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.backgroundLight,
      appBar: AppBar(
        backgroundColor: ColorsManager.white,
        elevation: 0,
        title: Text('Profile', style: AppTextStyle.font18Grey900SemiBold),
        centerTitle: true,
        leading: SizedBox(),
      ),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state.status == ProfileStatus.error && state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error!),
                backgroundColor: ColorsManager.error,
              ),
            );
          }
          if (state.status == ProfileStatus.logoutSuccess) {
            context.go(AppRoutes.login);
          }
        },
        builder: (context, state) {
          final isLoading =
              state.status == ProfileStatus.loading ||
              state.status == ProfileStatus.initial;

          return Skeletonizer(
            enabled: isLoading,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 24.h),
                  ProfileHeader(state: state),
                  SizedBox(height: 32.h),
                  const ProfileMenuSection(),
                  SizedBox(height: 32.h),
                  const ProfileLogoutButton(),
                  SizedBox(height: 40.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

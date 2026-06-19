import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/colors_manager.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/theme/app_theme.dart';
import '../cubit/profile_state.dart';

class ProfileHeader extends StatelessWidget {
  final ProfileState state;

  const ProfileHeader({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final user = state.user;
    final isDark = context.isDarkMode;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40.r,
            backgroundColor: isDark ? ColorsManager.grey800 : ColorsManager.grey200,
            backgroundImage: user?.avatarUrl != null ? NetworkImage(user!.avatarUrl!) : null,
            child: user?.avatarUrl == null
                ? Icon(Icons.person, size: 40.sp, color: ColorsManager.grey400)
                : null,
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user?.name ?? 'Loading...',
                  style: isDark ? AppTextStyle.font18WhiteSemiBold : AppTextStyle.font18Grey900SemiBold,
                ),
                SizedBox(height: 4.h),
                Text(
                  user?.email ?? 'loading@example.com',
                  style: AppTextStyle.font14Grey600Regular,
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.edit, color: ColorsManager.primary, size: 24.sp),
            onPressed: () {
              // TODO: Navigate to Edit Profile
            },
          ),
        ],
      ),
    );
  }
}

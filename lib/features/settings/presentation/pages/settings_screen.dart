import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/theme/colors_manager.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/theme/app_theme.dart';
import '../cubit/settings_cubit.dart';
import '../cubit/settings_state.dart';
import '../widgets/settings_appearance_section.dart';
import '../widgets/settings_language_section.dart';
import '../widgets/settings_shared_widgets.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return Scaffold(
      backgroundColor: isDark ? ColorsManager.backgroundDark : ColorsManager.backgroundLight,
      appBar: AppBar(
        backgroundColor: isDark ? ColorsManager.grey900 : ColorsManager.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: isDark ? ColorsManager.white : ColorsManager.grey900, size: 20.sp),
          onPressed: () => context.pop(),
        ),
        title: Text(
          tr('settings'),
          style: isDark ? AppTextStyle.font18WhiteSemiBold : AppTextStyle.font18Grey900SemiBold,
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<SettingsCubit, SettingsState>(
        listener: (context, state) {
          if (state.status == SettingsStatus.error && state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error!), backgroundColor: ColorsManager.error),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state.status == SettingsStatus.loading || state.status == SettingsStatus.initial;

          return Skeletonizer(
            enabled: isLoading,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16.h),
                  SettingsAppearanceSection(state: state),
                  SizedBox(height: 24.h),
                  SettingsLanguageSection(state: state),
                  SizedBox(height: 24.h),
                  const SettingsSectionHeader(title: 'Notifications'),
                  SettingsItemContainer(
                    child: _buildNotificationSwitches(context, state),
                  ),
                  SizedBox(height: 24.h),
                  const SettingsSectionHeader(title: 'Privacy & Support'),
                  SettingsItemContainer(
                    child: _buildSupportList(context, isDark),
                  ),
                  SizedBox(height: 40.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNotificationSwitches(BuildContext context, SettingsState state) {
    final isDark = context.isDarkMode;
    final settings = state.settings;
    return Column(
      children: [
        SwitchListTile(
          activeColor: ColorsManager.primary,
          title: Text('Push Notifications', style: isDark ? AppTextStyle.font16WhiteRegular : AppTextStyle.font16Grey700Regular),
          value: settings?.pushNotifications ?? true,
          onChanged: (val) {
            context.read<SettingsCubit>().updateNotifications(val, settings?.promoEmails ?? false);
          },
        ),
        Divider(height: 1, color: ColorsManager.grey100, indent: 16.w, endIndent: 16.w),
        SwitchListTile(
          activeColor: ColorsManager.primary,
          title: Text('Promotional Emails', style: isDark ? AppTextStyle.font16WhiteRegular : AppTextStyle.font16Grey700Regular),
          value: settings?.promoEmails ?? false,
          onChanged: (val) {
            context.read<SettingsCubit>().updateNotifications(settings?.pushNotifications ?? true, val);
          },
        ),
      ],
    );
  }

  Widget _buildSupportList(BuildContext context, bool isDark) {
    final textStyle = isDark ? AppTextStyle.font16WhiteRegular : AppTextStyle.font16Grey700Regular;
    return Column(
      children: [
        ListTile(
          title: Text('Privacy Policy', style: textStyle),
          trailing: Icon(Icons.chevron_right, color: ColorsManager.grey400, size: 20.sp),
          onTap: () {},
        ),
        Divider(height: 1, color: ColorsManager.grey100, indent: 16.w, endIndent: 16.w),
        ListTile(
          title: Text('Terms of Service', style: textStyle),
          trailing: Icon(Icons.chevron_right, color: ColorsManager.grey400, size: 20.sp),
          onTap: () {},
        ),
      ],
    );
  }
}

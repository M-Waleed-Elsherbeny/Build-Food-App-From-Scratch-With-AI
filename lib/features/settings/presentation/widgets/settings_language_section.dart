import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/theme/colors_manager.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/theme/app_theme.dart';
import '../cubit/settings_cubit.dart';
import '../cubit/settings_state.dart';
import 'settings_shared_widgets.dart';

class SettingsLanguageSection extends StatelessWidget {
  final SettingsState state;
  const SettingsLanguageSection({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final settings = state.settings;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SettingsSectionHeader(title: 'Language'),
        SettingsItemContainer(
          child: ListTile(
            title: Text(
              'App Language',
              style: isDark ? AppTextStyle.font16WhiteRegular : AppTextStyle.font16Grey700Regular,
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  settings?.language == 'ar' ? 'العربية' : 'English',
                  style: AppTextStyle.font14Grey600Regular,
                ),
                SizedBox(width: 8.w),
                Icon(Icons.chevron_right, color: ColorsManager.grey400, size: 20.sp),
              ],
            ),
            onTap: () {
              final newLang = settings?.language == 'ar' ? 'en' : 'ar';
              context.read<SettingsCubit>().updateLanguage(newLang);
              
              // Apply language change
              if (newLang == 'ar') {
                context.setLocale(const Locale('ar', 'EG'));
              } else {
                context.setLocale(const Locale('en', 'US'));
              }
            },
          ),
        ),
      ],
    );
  }
}

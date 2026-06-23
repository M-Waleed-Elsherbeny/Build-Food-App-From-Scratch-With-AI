import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/theme/colors_manager.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/theme/app_theme.dart';
import '../cubit/settings_cubit.dart';
import '../cubit/settings_state.dart';
import 'settings_shared_widgets.dart';

class SettingsAppearanceSection extends StatelessWidget {
  final SettingsState state;
  const SettingsAppearanceSection({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SettingsSectionHeader(
            title: tr(
                'Appearance')), // Need to add translation key or just use tr('settings_appearance')
        SettingsItemContainer(
          child: SwitchListTile(
            activeThumbColor: ColorsManager.primary,
            title: Text(
              'Dark Mode',
              style: isDark
                  ? AppTextStyle.font16WhiteRegular
                  : AppTextStyle.font16Grey700Regular,
            ),
            value: state.settings?.isDarkMode ?? false,
            onChanged: (val) {
              context.read<SettingsCubit>().updateTheme(val);
            },
          ),
        ),
      ],
    );
  }
}

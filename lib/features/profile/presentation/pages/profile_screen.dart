import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_app/features/profile/data/models/profile_model.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/theme/colors_manager.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/routes/app_router.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';
import '../../../auth/presentation/cubit/auth_state.dart';
import '../cubit/profile_cubit.dart';
import '../cubit/profile_state.dart';
import '../widgets/profile_card_container.dart';
import '../widgets/profile_menu_item.dart';
import '../widgets/edit_profile_dialog.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    // Load profile on initialization
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileCubit>().loadProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, authState) {
        if (authState.status == AuthStatus.initial) {
          // Redirect to Welcome page on logout
          context.go(AppRoutes.welcome);
        }
      },
      child: Scaffold(
        backgroundColor:
            isDark ? ColorsManager.backgroundDark : ColorsManager.surfaceCream,
        appBar: AppBar(
          backgroundColor: isDark
              ? ColorsManager.backgroundDark
              : ColorsManager.surfaceCream,
          elevation: 0,
          leading: const SizedBox.shrink(),
          title: Text(
            tr('profile'),
            style: isDark
                ? AppTextStyle.font18WhiteSemiBold
                    .copyWith(color: ColorsManager.primary)
                : AppTextStyle.font18Grey900SemiBold
                    .copyWith(color: ColorsManager.primary),
          ),
          centerTitle: true,
          actions: [
            BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                final profile = state.profile;
                if (profile == null) return const SizedBox.shrink();

                return IconButton(
                  icon: Icon(
                    Icons.edit_outlined,
                    color: ColorsManager.primary,
                    size: 24.sp,
                  ),
                  onPressed: () => _showEditProfileDialog(context, profile),
                );
              },
            ),
            SizedBox(width: 8.w),
          ],
        ),
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            final isLoading = state.status == ProfileStatus.loading;
            // When skeletonizer is enabled, provide mock placeholder data
            final profile = isLoading
                ? ProfileModel.mock()
                : (state.profile ?? ProfileModel.mock());

            return Skeletonizer(
              enabled: isLoading && state.profile == null,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                  child: Column(
                    children: [
                      // Hero Section: Avatar & Info
                      _buildHeroSection(context, profile, isDark),
                      SizedBox(height: 24.h),

                      // First Menu Group
                      ProfileCardContainer(
                        child: Column(
                          children: [
                            ProfileMenuItem(
                              icon: Icons.location_on_outlined,
                              title: 'My Addresses',
                              onTap: () {
                                context.push(AppRoutes.manageAddresses);
                              },
                            ),
                            Divider(
                                height: 1,
                                color: ColorsManager.grey200
                                    .withValues(alpha: 0.3)),
                            ProfileMenuItem(
                              icon: Icons.payment_outlined,
                              title: 'Payment Methods',
                              onTap: () => _showSnackBar(context,
                                  'Payment Methods are under development'),
                            ),
                            Divider(
                                height: 1,
                                color: ColorsManager.grey200
                                    .withValues(alpha: 0.3)),
                            ProfileMenuItem(
                              icon: Icons.favorite_border,
                              title: 'My Favorites',
                              onTap: () => _showSnackBar(
                                  context, 'Favorites are under development'),
                            ),
                            Divider(
                                height: 1,
                                color: ColorsManager.grey200
                                    .withValues(alpha: 0.3)),
                            ProfileMenuItem(
                              icon: Icons.notifications_none_outlined,
                              title: 'Notifications',
                              onTap: () {
                                context.push(AppRoutes.settings);
                              },
                            ),
                            Divider(
                                height: 1,
                                color: ColorsManager.grey200
                                    .withValues(alpha: 0.3)),
                            ProfileMenuItem(
                              icon: Icons.language_outlined,
                              title: 'Language',
                              trailingText: context.locale.languageCode == 'ar'
                                  ? 'العربية'
                                  : 'English',
                              onTap: () {
                                final currentLocale = context.locale;
                                if (currentLocale.languageCode == 'en') {
                                  context.setLocale(const Locale('ar', 'EG'));
                                } else {
                                  context.setLocale(const Locale('en', 'US'));
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 24.h),

                      // Second Menu Group
                      ProfileCardContainer(
                        child: Column(
                          children: [
                            ProfileMenuItem(
                              icon: Icons.help_outline,
                              title: 'Help & Support',
                              onTap: () => _showSnackBar(context,
                                  'Help & Support is under development'),
                            ),
                            Divider(
                                height: 1,
                                color: ColorsManager.grey200
                                    .withValues(alpha: 0.3)),
                            ProfileMenuItem(
                              icon: Icons.info_outline,
                              title: 'About',
                              onTap: () => _showSnackBar(
                                  context, 'About FoodieGo v2.4.0'),
                            ),
                            Divider(
                                height: 1,
                                color: ColorsManager.grey200
                                    .withValues(alpha: 0.3)),
                            ProfileMenuItem(
                              icon: Icons.security_outlined,
                              title: 'Privacy Policy',
                              onTap: () => _showSnackBar(context,
                                  'Privacy Policy is under development'),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 24.h),

                      // Logout Button Card
                      ProfileCardContainer(
                        child: ProfileMenuItem(
                          icon: Icons.logout_outlined,
                          title: tr('logout'),
                          isDestructive: true,
                          onTap: () => _showLogoutConfirmation(context),
                        ),
                      ),
                      SizedBox(height: 24.h),

                      // Version Indicator
                      Center(
                        child: Text(
                          'V2.4.0',
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: ColorsManager.grey500.withValues(alpha: 0.6),
                            letterSpacing: 2.4,
                          ),
                        ),
                      ),
                      SizedBox(height: 40.h),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeroSection(
      BuildContext context, ProfileModel profile, bool isDark) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            // Outer white ring
            Container(
              padding: EdgeInsets.all(4.r),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
                border: Border.all(color: ColorsManager.white, width: 4.r),
                boxShadow: [
                  BoxShadow(
                    color: ColorsManager.primary.withValues(alpha: 0.12),
                    blurRadius: 40.r,
                    offset: Offset(0, 10.h),
                  ),
                ],
              ),
              child: Hero(
                tag: 'profile_avatar',
                child: CircleAvatar(
                  radius: 60.r,
                  backgroundColor: ColorsManager.grey200,
                  backgroundImage: profile.avatar!.isNotEmpty
                      ? NetworkImage(profile.avatar!)
                      : null,
                  child: Icon(
                    Icons.person,
                    size: 50.sp,
                    color: ColorsManager.grey500,
                  ),
                ),
              ),
            ),
            // Camera badge button
            GestureDetector(
              onTap: () =>
                  _showSnackBar(context, 'Change avatar feature coming soon'),
              child: Container(
                padding: EdgeInsets.all(8.r),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorsManager.primary,
                ),
                child: Icon(
                  Icons.camera_alt_outlined,
                  color: ColorsManager.white,
                  size: 16.sp,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Text(
          profile.name ?? 'Guest User',
          style: GoogleFonts.poppins(
            color: isDark ? ColorsManager.white : ColorsManager.grey900,
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          profile.email,
          style: GoogleFonts.inter(
            color: isDark ? ColorsManager.grey400 : ColorsManager.grey700,
            fontSize: 14.sp,
            fontWeight: FontWeight.normal,
          ),
        ),
        if (profile.phone.isNotEmpty) ...[
          SizedBox(height: 4.h),
          Text(
            profile.phone,
            style: GoogleFonts.inter(
              color: isDark ? ColorsManager.grey400 : ColorsManager.grey700,
              fontSize: 14.sp,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ],
    );
  }

  void _showEditProfileDialog(BuildContext context, ProfileModel profile) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => BlocProvider.value(
        value: context.read<ProfileCubit>(),
        child: EditProfileDialog(
          profile: profile,
          onSave: (name, email, phone) {
            context.read<ProfileCubit>().editProfile(
                  name: name,
                  email: email,
                  phone: phone,
                );
          },
        ),
      ),
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor:
            context.isDarkMode ? ColorsManager.grey900 : ColorsManager.white,
        title: Text('Log Out',
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        content: Text('Are you sure you want to log out of FoodieGo?',
            style: GoogleFonts.inter()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text('Cancel',
                style: GoogleFonts.inter(color: ColorsManager.grey500)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              context.read<AuthCubit>().logout();
            },
            child: Text('Log Out',
                style: GoogleFonts.inter(
                    color: ColorsManager.error, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: ColorsManager.primary,
      ),
    );
  }
}

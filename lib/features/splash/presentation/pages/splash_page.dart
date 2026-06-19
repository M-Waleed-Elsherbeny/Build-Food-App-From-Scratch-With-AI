import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/theme/colors_manager.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../onboarding/data/repositories/onboarding_repository.dart';
import '../../../auth/data/repositories/auth_repository.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _controller.forward();
    _checkStatus();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _checkStatus() async {
    // Wait for animation and minimal splash duration
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;

    // Check onboarding status first
    final onboardingResult = await getIt<OnboardingRepository>().getCompletionStatus();
    if (!mounted) return;
    
    bool isOnboardingCompleted = false;
    onboardingResult.fold((_) => null, (completed) => isOnboardingCompleted = completed);

    if (!isOnboardingCompleted) {
      context.go(AppRoutes.onboarding);
      return;
    }

    // If onboarding is completed, check authentication status
    final isAuthenticated = await getIt<AuthRepository>().isAuthenticated();
    if (!mounted) return;
    
    if (isAuthenticated) {
      context.go(AppRoutes.home);
    } else {
      context.go(AppRoutes.welcome);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              ColorsManager.primaryGradientStart,
              ColorsManager.primaryGradientEnd,
            ],
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 160.w,
                      height: 160.w,
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    children: [
                      Text(
                        'FoodieGo',
                        style: context.textTheme.displayLarge?.copyWith(
                          color: ColorsManager.white,
                          fontSize: 40.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Delicious food, delivered fast',
                        style: context.textTheme.bodyLarge?.copyWith(
                          color: ColorsManager.white.withOpacity(0.9),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 60.h,
              child: const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(ColorsManager.white),
                strokeWidth: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


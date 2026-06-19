import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/widgets/primary_button.dart';
import 'page_indicator.dart';

class OnboardingBottomSection extends StatelessWidget {
  final int itemCount;
  final int currentIndex;
  final bool isLastPage;
  final VoidCallback onNext;

  const OnboardingBottomSection({
    super.key,
    required this.itemCount,
    required this.currentIndex,
    required this.isLastPage,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(24.w),
      child: Column(
        children: [
          PageIndicator(
            count: itemCount,
            currentIndex: currentIndex,
          ),
          SizedBox(height: 40.h),
          PrimaryButton(
            text: isLastPage ? 'Get Started' : 'Next',
            onPressed: onNext,
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: isLastPage ? 72.h : 0,
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(height: 16.h),
                  TextButton(
                    onPressed: () => context.go(AppRoutes.login),
                    child: RichText(
                      text: TextSpan(
                        style: AppTextStyle.font16Grey900Regular,
                        children: [
                          const TextSpan(text: 'Already have an account? '),
                          TextSpan(
                            text: 'Login',
                            style: AppTextStyle.font16PrimaryBold,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}

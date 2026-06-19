import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/theme/colors_manager.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../data/models/onboarding_model.dart';
import '../cubit/onboarding_cubit.dart';
import '../cubit/onboarding_state.dart';
import '../widgets/onboarding_content.dart';
import '../widgets/onboarding_bottom_section.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  late PageController _pageController;

  final List<OnboardingModel> _items = [
    OnboardingModel(
      title: 'Discover Amazing Food',
      subtitle: 'Browse restaurants and dishes from your favorite places.',
      image: 'assets/images/onboarding_discover.png',
    ),
    OnboardingModel(
      title: 'Fast & Reliable Delivery',
      subtitle: 'Track your order live and receive it fresh.',
      image: 'assets/images/onboarding_delivery.png',
    ),
    OnboardingModel(
      title: 'Simple Ordering Experience',
      subtitle: 'Order in just a few taps with secure checkout.',
      image: 'assets/images/onboarding_ordering.png',
    ),
    OnboardingModel(
      title: 'Your Favorite Meals Await',
      subtitle: 'Join FoodieGo and enjoy premium delivery service.',
      image: 'assets/images/onboarding_started.png',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNext(BuildContext context) {
    if (_pageController.page!.toInt() < _items.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      context.read<OnboardingCubit>().completeOnboarding();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnboardingCubit, OnboardingState>(
      listener: (context, state) {
        if (state.status == OnboardingStatus.completed) {
          context.go(AppRoutes.welcome);
        }
      },
      builder: (context, state) {
        final isLastPage = state.currentPage == _items.length - 1;

        return Scaffold(
          backgroundColor: ColorsManager.surfaceCream,
          body: SafeArea(
            child: Column(
              children: [
                // Top Skip Button
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: AnimatedOpacity(
                      opacity: isLastPage ? 0.0 : 1.0,
                      duration: const Duration(milliseconds: 300),
                      child: TextButton(
                        onPressed: isLastPage
                            ? null
                            : () => context.read<OnboardingCubit>().completeOnboarding(),
                        child: Text(
                          'Skip',
                          style: AppTextStyle.font16Grey500SemiBold,
                        ),
                      ),
                    ),
                  ),
                ),
                // PageView
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _items.length,
                    onPageChanged: (index) =>
                        context.read<OnboardingCubit>().changePage(index),
                    itemBuilder: (context, index) {
                      return OnboardingContent(model: _items[index]);
                    },
                  ),
                ),
                // Bottom Section
                OnboardingBottomSection(
                  itemCount: _items.length,
                  currentIndex: state.currentPage,
                  isLastPage: isLastPage,
                  onNext: () => _onNext(context),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

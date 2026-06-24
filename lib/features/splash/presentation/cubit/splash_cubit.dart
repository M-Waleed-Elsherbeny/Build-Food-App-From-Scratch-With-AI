import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/routes/app_router.dart';
import '../../../onboarding/data/repositories/onboarding_repository.dart';
import '../../../auth/data/repositories/auth_repository.dart';
import 'splash_state.dart';

/// Cubit that determines the initial navigation flow for the splash screen.
class SplashCubit extends Cubit<SplashState> {
  final OnboardingRepository _onboardingRepository;
  final AuthRepository _authRepository;

  SplashCubit(this._onboardingRepository, this._authRepository)
      : super(const SplashState());

  /// Checks onboarding and authentication state and selects the next route.
  Future<void> loadInitialRoute() async {
    emit(state.copyWith(status: SplashStatus.loading));

    final onboardingResult = await _onboardingRepository.getCompletionStatus();
    final isOnboardingCompleted = onboardingResult.fold(
      (_) => false,
      (completed) => completed,
    );

    if (!isOnboardingCompleted) {
      emit(state.copyWith(
        status: SplashStatus.completed,
        route: AppRoutes.onboarding,
      ));
      return;
    }

    final isAuthenticated = await _authRepository.isAuthenticated();
    emit(state.copyWith(
      status: SplashStatus.completed,
      route: isAuthenticated ? AppRoutes.main : AppRoutes.welcome,
    ));
  }
}

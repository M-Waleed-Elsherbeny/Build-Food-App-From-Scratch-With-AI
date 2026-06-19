import '../../features/auth/presentation/cubit/auth_state.dart';
import '../../features/onboarding/presentation/cubit/onboarding_state.dart';

/// Extension on AuthStatus for display logic.
extension AuthStatusX on AuthStatus {
  bool get isInitial => this == AuthStatus.initial;
  bool get isLoading => this == AuthStatus.loading;
  bool get isSuccess => this == AuthStatus.success;
  bool get isFailure => this == AuthStatus.failure;
}

/// Extension on OnboardingStatus for display logic.
extension OnboardingStatusX on OnboardingStatus {
  bool get isInitial => this == OnboardingStatus.initial;
  bool get isPageChanged => this == OnboardingStatus.pageChanged;
  bool get isCompleted => this == OnboardingStatus.completed;
}


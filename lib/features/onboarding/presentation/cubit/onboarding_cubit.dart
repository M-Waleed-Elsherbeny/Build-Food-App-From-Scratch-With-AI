import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/onboarding_repository.dart';
import 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final OnboardingRepository repository;

  OnboardingCubit(this.repository) : super(const OnboardingState());

  /// Updates the current page index.
  void changePage(int index) {
    emit(state.copyWith(
      status: OnboardingStatus.pageChanged,
      currentPage: index,
    ));
  }

  /// Marks onboarding as completed and saves the status locally.
  Future<void> completeOnboarding() async {
    final result = await repository.saveCompletion();
    result.fold(
      (failure) => null, // Handle failure if necessary
      (_) => emit(state.copyWith(status: OnboardingStatus.completed)),
    );
  }
}


import 'package:equatable/equatable.dart';

enum OnboardingStatus { initial, pageChanged, completed }

class OnboardingState extends Equatable {
  final OnboardingStatus status;
  final int currentPage;

  const OnboardingState({
    this.status = OnboardingStatus.initial,
    this.currentPage = 0,
  });

  OnboardingState copyWith({
    OnboardingStatus? status,
    int? currentPage,
  }) {
    return OnboardingState(
      status: status ?? this.status,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  List<Object?> get props => [status, currentPage];
}


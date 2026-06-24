import 'package:equatable/equatable.dart';

enum SplashStatus { initial, loading, completed, failure }

class SplashState extends Equatable {
  final SplashStatus status;
  final String route;
  final String errorMessage;

  const SplashState({
    this.status = SplashStatus.initial,
    this.route = '',
    this.errorMessage = '',
  });

  SplashState copyWith({
    SplashStatus? status,
    String? route,
    String? errorMessage,
  }) {
    return SplashState(
      status: status ?? this.status,
      route: route ?? this.route,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, route, errorMessage];
}

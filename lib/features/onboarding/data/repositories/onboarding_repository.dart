import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../datasources/onboarding_local_datasource.dart';

abstract class OnboardingRepository {
  Future<Either<Failure, void>> saveCompletion();
  Future<Either<Failure, bool>> getCompletionStatus();
}

class OnboardingRepositoryImpl implements OnboardingRepository {
  final OnboardingLocalDataSource localDataSource;

  OnboardingRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, void>> saveCompletion() async {
    try {
      await localDataSource.saveOnboardingCompletion();
      return const Right(null);
    } catch (e) {
      return const Left(CacheFailure('Failed to save onboarding status'));
    }
  }

  @override
  Future<Either<Failure, bool>> getCompletionStatus() async {
    try {
      final isCompleted = await localDataSource.isOnboardingCompleted();
      return Right(isCompleted);
    } catch (e) {
      return const Left(CacheFailure('Failed to read onboarding status'));
    }
  }
}


import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:food_app/core/errors/failures.dart';
import 'package:food_app/features/profile/data/models/address_model.dart';
import 'package:food_app/features/profile/data/models/profile_model.dart';
import 'package:food_app/features/profile/data/repositories/profile_repository.dart';
import 'package:food_app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:food_app/features/profile/presentation/cubit/profile_state.dart';

class MockProfileRepository extends Mock implements ProfileRepository {}

void main() {
  late ProfileRepository mockProfileRepository;
  late ProfileCubit profileCubit;
  late ProfileModel testProfile;

  setUp(() {
    mockProfileRepository = MockProfileRepository();
    profileCubit = ProfileCubit(mockProfileRepository);
    testProfile = ProfileModel.mock();
  });

  tearDown(() {
    profileCubit.close();
  });

  group('ProfileCubit Tests', () {
    test('initial state has initial status', () {
      expect(profileCubit.state, const ProfileState());
    });

    blocTest<ProfileCubit, ProfileState>(
      'emits [loading, success] when loadProfile succeeds',
      build: () {
        when(() => mockProfileRepository.getProfile())
            .thenAnswer((_) async => Right(testProfile));
        return profileCubit;
      },
      act: (cubit) => cubit.loadProfile(),
      expect: () => [
        const ProfileState(status: ProfileStatus.loading),
        ProfileState(status: ProfileStatus.success, profile: testProfile),
      ],
    );

    blocTest<ProfileCubit, ProfileState>(
      'emits [loading, failure] when loadProfile fails',
      build: () {
        when(() => mockProfileRepository.getProfile())
            .thenAnswer((_) async => const Left(ServerFailure('Error message')));
        return profileCubit;
      },
      act: (cubit) => cubit.loadProfile(),
      expect: () => [
        const ProfileState(status: ProfileStatus.loading),
        const ProfileState(status: ProfileStatus.failure, error: 'Error message'),
      ],
    );

    blocTest<ProfileCubit, ProfileState>(
      'emits [loading, success] when editProfile succeeds',
      build: () {
        when(() => mockProfileRepository.updateProfile(
              name: 'Updated Name',
              email: 'updated@email.com',
              phone: '12345678',
            )).thenAnswer((_) async => Right(testProfile.copyWith(
              name: 'Updated Name',
              email: 'updated@email.com',
              phone: '12345678',
            )));
        return profileCubit;
      },
      act: (cubit) => cubit.editProfile(
        name: 'Updated Name',
        email: 'updated@email.com',
        phone: '12345678',
      ),
      expect: () => [
        const ProfileState(status: ProfileStatus.loading),
        ProfileState(
          status: ProfileStatus.success,
          profile: testProfile.copyWith(
            name: 'Updated Name',
            email: 'updated@email.com',
            phone: '12345678',
          ),
        ),
      ],
    );

    blocTest<ProfileCubit, ProfileState>(
      'emits [loading, success] when addAddress succeeds',
      build: () {
        const newAddress = AddressModel(id: '3', title: 'Gym', addressLine: 'Gym Address');
        when(() => mockProfileRepository.addAddress(newAddress))
            .thenAnswer((_) async => Right(testProfile.copyWith(
                  addresses: [...testProfile.addresses, newAddress],
                )));
        return profileCubit;
      },
      act: (cubit) => cubit.addAddress(
        const AddressModel(id: '3', title: 'Gym', addressLine: 'Gym Address'),
      ),
      expect: () => [
        const ProfileState(status: ProfileStatus.loading),
        ProfileState(
          status: ProfileStatus.success,
          profile: testProfile.copyWith(
            addresses: [
              ...testProfile.addresses,
              const AddressModel(id: '3', title: 'Gym', addressLine: 'Gym Address'),
            ],
          ),
        ),
      ],
    );
  });
}

import 'package:cubit_ui_flow/cubit_ui_flow.dart';
import 'package:dart_koinon/dart_koinon.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:achaean_flutter/features/profile/cubit/profile_cubit.dart';
import 'package:achaean_flutter/features/profile/services/i_profile_service.dart';

class MockProfileService extends Mock implements IProfileService {}

void main() {
  late MockProfileService mockService;
  late ProfileCubit cubit;

  const testProfile = ProfileDetails(
    displayName: 'Alice',
    bio: 'Woodworking enthusiast',
  );

  setUpAll(() {
    registerFallbackValue(const ProfileDetails());
  });

  setUp(() {
    mockService = MockProfileService();
    cubit = ProfileCubit(mockService);
  });

  tearDown(() => cubit.close());

  test('initial state is idle with empty profile', () {
    expect(cubit.state.isIdle, isTrue);
    expect(cubit.state.profile.displayName, isNull);
    expect(cubit.state.profile.bio, isNull);
  });

  test('loadOwnProfile emits success with profile data', () async {
    when(() => mockService.getOwnProfile())
        .thenAnswer((_) async => testProfile);

    await cubit.loadOwnProfile();

    expect(cubit.state.isSuccess, isTrue);
    expect(cubit.state.profile.displayName, 'Alice');
    expect(cubit.state.profile.bio, 'Woodworking enthusiast');
  });

  test('updateProfile saves and updates state', () async {
    when(() => mockService.updateProfile(any()))
        .thenAnswer((_) async {});

    await cubit.updateProfile(displayName: 'Bob', bio: 'New bio');

    expect(cubit.state.isSuccess, isTrue);
    expect(cubit.state.profile.displayName, 'Bob');
    expect(cubit.state.profile.bio, 'New bio');
    verify(() => mockService.updateProfile(any())).called(1);
  });
}

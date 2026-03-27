import 'package:cubit_ui_flow/cubit_ui_flow.dart';
import 'package:dart_koinon/dart_koinon.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:achaean_flutter/features/polis/cubit/polis_cubit.dart';
import 'package:achaean_flutter/features/polis/services/i_polis_service.dart';
import 'package:achaean_flutter/core/models/repo_identifier.dart';

class MockPolisService extends Mock implements IPolisService {}

void main() {
  late MockPolisService mockService;
  late PolisCubit cubit;

  final testPoleis = [
    const PolisMembership(
      repo: 'https://forge.example/alice/woodworking',
      name: 'Woodworkers',
      stars: 5,
      role: 'TRUST',
    ),
  ];

  final testRepoId = const RepoIdentifier(
    baseUrl: 'https://forge.example',
    owner: 'alice',
    repo: 'woodworking',
  );

  setUp(() {
    mockService = MockPolisService();
    cubit = PolisCubit(mockService);
  });

  tearDown(() => cubit.close());

  setUpAll(() {
    registerFallbackValue(const RepoIdentifier(
      baseUrl: 'https://forge.example',
      owner: 'test',
      repo: 'test',
    ));
  });

  test('initial state is idle with empty poleis', () {
    expect(cubit.state.isIdle, isTrue);
    expect(cubit.state.poleis, isEmpty);
    expect(cubit.state.createdPolis, isNull);
  });

  test('loadOwnPoleis emits success with poleis list', () async {
    when(() => mockService.getOwnPoleis())
        .thenAnswer((_) async => testPoleis);

    await cubit.loadOwnPoleis();

    expect(cubit.state.isSuccess, isTrue);
    expect(cubit.state.poleis, hasLength(1));
    expect(cubit.state.poleis.first.name, 'Woodworkers');
  });

  test('createPolis stores created polis and reloads list', () async {
    when(() => mockService.createPolis(
          name: any(named: 'name'),
          description: any(named: 'description'),
          norms: any(named: 'norms'),
          threshold: any(named: 'threshold'),
        )).thenAnswer((_) async => testRepoId);
    when(() => mockService.getOwnPoleis())
        .thenAnswer((_) async => testPoleis);

    await cubit.createPolis(name: 'Woodworkers', description: 'For wood people');

    expect(cubit.state.isSuccess, isTrue);
    expect(cubit.state.createdPolis, testRepoId);
    expect(cubit.state.poleis, hasLength(1));
  });

  test('joinPolis reloads poleis list', () async {
    when(() => mockService.joinPolis(any()))
        .thenAnswer((_) async {});
    when(() => mockService.getOwnPoleis())
        .thenAnswer((_) async => testPoleis);

    await cubit.joinPolis(testRepoId);

    expect(cubit.state.isSuccess, isTrue);
    verify(() => mockService.joinPolis(testRepoId)).called(1);
  });
}

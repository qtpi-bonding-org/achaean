import 'package:cubit_ui_flow/cubit_ui_flow.dart';
import 'package:dart_koinon/dart_koinon.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:achaean_flutter/features/trust/cubit/trust_cubit.dart';
import 'package:achaean_flutter/features/trust/services/i_trust_service.dart';
import 'package:achaean_flutter/core/models/repo_identifier.dart';

class MockTrustService extends Mock implements ITrustService {}

void main() {
  late MockTrustService mockService;
  late TrustCubit cubit;

  final testDeclarations = [
    TrustDeclaration(
      subject: 'pubkey-bob',
      repo: 'https://forge.example/bob/koinon',
      level: TrustLevel.trust,
      timestamp: DateTime(2026, 3, 27),
      signature: 'sig1',
    ),
  ];

  setUp(() {
    mockService = MockTrustService();
    cubit = TrustCubit(mockService);
  });

  tearDown(() => cubit.close());

  setUpAll(() {
    registerFallbackValue(const RepoIdentifier(
      baseUrl: 'https://forge.example',
      owner: 'test',
      repo: 'koinon',
    ));
    registerFallbackValue(TrustLevel.trust);
  });

  test('initial state is idle with empty declarations', () {
    expect(cubit.state.isIdle, isTrue);
    expect(cubit.state.declarations, isEmpty);
  });

  test('loadOwnTrust emits success with declarations', () async {
    when(() => mockService.getOwnTrustDeclarations())
        .thenAnswer((_) async => testDeclarations);

    await cubit.loadOwnTrust();

    expect(cubit.state.isSuccess, isTrue);
    expect(cubit.state.declarations, hasLength(1));
    expect(cubit.state.declarations.first.subject, 'pubkey-bob');
  });

  test('declareTrust calls service and reloads declarations', () async {
    when(() => mockService.declareTrust(
          subjectPubkey: any(named: 'subjectPubkey'),
          subjectRepo: any(named: 'subjectRepo'),
          level: any(named: 'level'),
        )).thenAnswer((_) async {});
    when(() => mockService.getOwnTrustDeclarations())
        .thenAnswer((_) async => testDeclarations);

    await cubit.declareTrust(
      subjectPubkey: 'pubkey-bob',
      subjectRepo: 'https://forge.example/bob/koinon',
      level: TrustLevel.trust,
    );

    expect(cubit.state.isSuccess, isTrue);
    expect(cubit.state.declarations, hasLength(1));
    verify(() => mockService.declareTrust(
          subjectPubkey: 'pubkey-bob',
          subjectRepo: 'https://forge.example/bob/koinon',
          level: TrustLevel.trust,
        )).called(1);
  });

  test('revokeTrust calls service and reloads declarations', () async {
    when(() => mockService.revokeTrust(subjectName: any(named: 'subjectName'),))
        .thenAnswer((_) async {});
    when(() => mockService.getOwnTrustDeclarations())
        .thenAnswer((_) async => []);

    await cubit.revokeTrust(subjectName: 'pubkey-bob-pref');

    expect(cubit.state.isSuccess, isTrue);
    expect(cubit.state.declarations, isEmpty);
  });
}

import 'package:cubit_ui_flow/cubit_ui_flow.dart';
import 'package:dart_koinon/dart_koinon.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:achaean_flutter/features/post_creation/cubit/own_posts_cubit.dart';
import 'package:achaean_flutter/features/post_creation/services/i_post_creation_service.dart';

class MockPostCreationService extends Mock implements IPostCreationService {}

void main() {
  late MockPostCreationService mockService;
  late OwnPostsCubit cubit;

  final testPosts = [
    Post(
      content: PostContent(text: 'Hello world'),
      timestamp: DateTime(2026, 3, 27),
      signature: 'sig1',
    ),
    Post(
      content: PostContent(text: 'Second post'),
      timestamp: DateTime(2026, 3, 26),
      signature: 'sig2',
    ),
  ];

  setUp(() {
    mockService = MockPostCreationService();
    cubit = OwnPostsCubit(mockService);
  });

  tearDown(() => cubit.close());

  test('initial state is idle with empty posts', () {
    expect(cubit.state.isIdle, isTrue);
    expect(cubit.state.posts, isEmpty);
  });

  test('loadPosts emits success with posts', () async {
    when(() => mockService.getOwnPosts()).thenAnswer((_) async => testPosts);

    await cubit.loadPosts();

    expect(cubit.state.isSuccess, isTrue);
    expect(cubit.state.posts, hasLength(2));
    expect(cubit.state.posts.first.content.text, 'Hello world');
    verify(() => mockService.getOwnPosts()).called(1);
  });

  test('loadPosts emits success with empty list when no posts', () async {
    when(() => mockService.getOwnPosts()).thenAnswer((_) async => []);

    await cubit.loadPosts();

    expect(cubit.state.isSuccess, isTrue);
    expect(cubit.state.posts, isEmpty);
  });
}

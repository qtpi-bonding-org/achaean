import 'package:flutter_goldgen/src/analyzer/screen_inspector.dart';
import 'package:flutter_goldgen/src/models/discovered_screen.dart';
import 'package:test/test.dart';

void main() {
  group('ScreenInspector', () {
    late ScreenInspector inspector;
    late List<DiscoveredScreen> screens;

    setUpAll(() async {
      inspector = ScreenInspector();
      screens = await inspector.findScreens(
        '/Users/aicoder/Documents/achaean/achaean_flutter/lib',
      );
    });

    test('finds screens with BlocBuilder usage', () {
      expect(screens, isNotEmpty);
    });

    test('finds AccountCreationScreen with cubit bindings', () {
      final found = screens.where(
        (s) => s.cubitBindings.any(
          (b) => b.stateClassName == 'AccountCreationState',
        ),
      );
      expect(found, isNotEmpty);
    });

    test('extracts cubit and state class names from BlocBuilder', () {
      final screen = screens.firstWhere(
        (s) => s.cubitBindings.any(
          (b) => b.stateClassName == 'AccountCreationState',
        ),
      );
      final binding = screen.cubitBindings.firstWhere(
        (b) => b.stateClassName == 'AccountCreationState',
      );
      expect(binding.cubitClassName, 'AccountCreationCubit');
      expect(binding.stateClassName, 'AccountCreationState');
    });

    test('finds OwnPostsScreen with OwnPostsCubit binding', () {
      final found = screens.where(
        (s) => s.cubitBindings.any(
          (b) => b.cubitClassName == 'OwnPostsCubit',
        ),
      );
      expect(found, isNotEmpty);
      final screen = found.first;
      expect(screen.className, 'OwnPostsScreen');
    });

    test('OwnPostsScreen has correct state class name', () {
      final screen = screens.firstWhere(
        (s) => s.className == 'OwnPostsScreen',
      );
      final binding = screen.cubitBindings.firstWhere(
        (b) => b.cubitClassName == 'OwnPostsCubit',
      );
      expect(binding.stateClassName, 'OwnPostsState');
    });

    test('all discovered screens have non-empty className', () {
      for (final screen in screens) {
        expect(screen.className, isNotEmpty);
      }
    });

    test('all discovered screens have filePath set', () {
      for (final screen in screens) {
        expect(screen.filePath, isNotEmpty);
      }
    });

    test('all cubit bindings have both cubit and state names', () {
      for (final screen in screens) {
        for (final binding in screen.cubitBindings) {
          expect(binding.cubitClassName, isNotEmpty);
          expect(binding.stateClassName, isNotEmpty);
        }
      }
    });

    test('does not produce duplicate bindings for same cubit in a screen', () {
      for (final screen in screens) {
        final pairs = screen.cubitBindings
            .map((b) => '${b.cubitClassName}:${b.stateClassName}')
            .toList();
        expect(pairs.length, equals(pairs.toSet().length),
            reason: '${screen.className} has duplicate bindings');
      }
    });
  });
}

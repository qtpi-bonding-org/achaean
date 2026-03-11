import 'package:flutter_goldgen/src/analyzer/state_inspector.dart';
import 'package:flutter_goldgen/src/models/discovered_state.dart';
import 'package:test/test.dart';

void main() {
  group('StateInspector', () {
    late StateInspector inspector;
    late List<DiscoveredState> states;

    setUpAll(() async {
      inspector = StateInspector();
      // Point at the real achaean_flutter lib directory.
      states = await inspector.findStates(
        '/Users/aicoder/Documents/achaean/achaean_flutter/lib',
      );
    });

    test('finds IUiFlowState classes in achaean_flutter', () {
      // We know there are at least 5 states
      expect(states.length, greaterThanOrEqualTo(5));

      final names = states.map((s) => s.className).toList();
      expect(names, contains('AgoraState'));
      expect(names, contains('TrustState'));
      expect(names, contains('FlagState'));
    });

    test('extracts data fields excluding status and error', () {
      final agoraState =
          states.firstWhere((s) => s.className == 'AgoraState');
      final dataFields = agoraState.dataFields;

      // AgoraState has: posts, flagCounts, flagThreshold, hasMore, offset
      expect(dataFields.length, greaterThanOrEqualTo(3));
      expect(dataFields.any((f) => f.name == 'posts'), true);

      // status and error should be excluded
      expect(dataFields.any((f) => f.name == 'status'), false);
      expect(dataFields.any((f) => f.name == 'error'), false);
    });

    test('detects list fields correctly', () {
      final agoraState =
          states.firstWhere((s) => s.className == 'AgoraState');
      final postsField =
          agoraState.fields.firstWhere((f) => f.name == 'posts');

      expect(postsField.isList, true);
      expect(postsField.listElementType, isNotNull);
    });

    test('detects map fields correctly', () {
      final agoraState =
          states.firstWhere((s) => s.className == 'AgoraState');
      final flagCountsField =
          agoraState.fields.firstWhere((f) => f.name == 'flagCounts');

      expect(flagCountsField.isMap, true);
      expect(flagCountsField.mapKeyType, 'String');
      expect(flagCountsField.mapValueType, 'int');
    });

    test('detects nullable fields correctly', () {
      final accountState =
          states.firstWhere((s) => s.className == 'AccountCreationState');
      final resultField =
          accountState.fields.firstWhere((f) => f.name == 'result');

      expect(resultField.isNullable, true);
    });

    test('all discovered states have non-empty className', () {
      for (final state in states) {
        expect(state.className, isNotEmpty);
      }
    });

    test('all discovered states have filePath set', () {
      for (final state in states) {
        expect(state.filePath, isNotEmpty);
      }
    });

    test('DiscoveredField.isUiFlowField identifies status and error', () {
      const statusField = DiscoveredField(name: 'status', typeName: 'UiFlowStatus');
      const errorField = DiscoveredField(name: 'error', typeName: 'Object?', isNullable: true);
      const dataField = DiscoveredField(name: 'posts', typeName: 'List<Post>');

      expect(statusField.isUiFlowField, true);
      expect(errorField.isUiFlowField, true);
      expect(dataField.isUiFlowField, false);
    });
  });
}

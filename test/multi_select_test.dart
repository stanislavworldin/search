import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:multiselector/multiselector.dart';

void main() {
  group('Multi-Select Tests', () {
    final testItems = [
      const SelectableItem(
        id: '1',
        name: 'Apple',
        icon: '🍎',
        subtitle: 'Red fruit',
        searchData: 'apple fruit red',
      ),
      const SelectableItem(
        id: '2',
        name: 'Banana',
        icon: '🍌',
        subtitle: 'Yellow fruit',
        searchData: 'banana fruit yellow',
      ),
      const SelectableItem(
        id: '3',
        name: 'Orange',
        icon: '🍊',
        subtitle: 'Orange fruit',
        searchData: 'orange fruit citrus',
      ),
    ];

    void emptyCallback(SelectableItem item) {}
    void emptyMultiCallback(List<SelectableItem> items) {}

    testWidgets('Multi-select displays correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: UniversalSelector(
              items: testItems,
              selectedItems: const [],
              isMultiSelect: true,
              onItemSelected: emptyCallback,
              onItemsSelected: emptyMultiCallback,
            ),
          ),
        ),
      );
      expect(find.byType(UniversalSelector), findsOneWidget);
    });

    testWidgets('Multi-select shows selected items count',
        (WidgetTester tester) async {
      final selectedItems = [
        const SelectableItem(
          id: '1',
          name: 'Apple',
          icon: '🍎',
          subtitle: 'Red fruit',
        ),
        const SelectableItem(
          id: '2',
          name: 'Banana',
          icon: '🍌',
          subtitle: 'Yellow fruit',
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: UniversalSelector(
              items: testItems,
              selectedItems: selectedItems,
              isMultiSelect: true,
              onItemSelected: emptyCallback,
              onItemsSelected: emptyMultiCallback,
            ),
          ),
        ),
      );
      expect(find.text('2 items selected'), findsOneWidget);
    });

    testWidgets('Multi-select with max selections',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: UniversalSelector(
              items: testItems,
              selectedItems: const [],
              isMultiSelect: true,
              maxSelections: 2,
              onItemSelected: emptyCallback,
              onItemsSelected: emptyMultiCallback,
            ),
          ),
        ),
      );
      expect(find.byType(UniversalSelector), findsOneWidget);
    });

    test('Multi-select parameters validation', () {
      // Test that multi-select requires onItemsSelected callback
      expect(
        () => UniversalSelector(
          items: testItems,
          selectedItems: const [],
          isMultiSelect: true,
          onItemSelected: emptyCallback,
          onItemsSelected: null,
        ),
        throwsAssertionError,
      );
    });
  });
}

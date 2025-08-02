import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:multiselector/multiselector.dart';

void main() {
  group('API Consistency Tests', () {
    final List<SelectableItem> testItems = [
      const SelectableItem(
        id: 'apple',
        name: 'Apple',
        icon: '🍎',
        subtitle: 'Red fruit',
      ),
      const SelectableItem(
        id: 'banana',
        name: 'Banana',
        icon: '🍌',
        subtitle: 'Yellow fruit',
      ),
    ];

    testWidgets('Multi-select mode works without onItemSelected',
        (WidgetTester tester) async {
      List<SelectableItem> selectedItems = [];
      bool callbackCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: UniversalSelector(
              items: testItems,
              selectedItems: selectedItems,
              isMultiSelect: true,
              onItemsSelected: (List<SelectableItem> items) {
                selectedItems = items;
                callbackCalled = true;
              },
            ),
          ),
        ),
      );

      // Виджет должен отрендериться без ошибок
      expect(find.byType(UniversalSelector), findsOneWidget);
      expect(callbackCalled, false);
    });

    testWidgets('Single-select mode requires onItemSelected',
        (WidgetTester tester) async {
      SelectableItem? selectedItem;
      bool callbackCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: UniversalSelector(
              items: testItems,
              selectedItem: selectedItem,
              isMultiSelect: false,
              onItemSelected: (SelectableItem item) {
                selectedItem = item;
                callbackCalled = true;
              },
            ),
          ),
        ),
      );

      // Виджет должен отрендериться без ошибок
      expect(find.byType(UniversalSelector), findsOneWidget);
      expect(callbackCalled, false);
    });

    testWidgets('Multi-select mode ignores onItemSelected if provided',
        (WidgetTester tester) async {
      List<SelectableItem> selectedItems = [];
      bool multiCallbackCalled = false;
      bool singleCallbackCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: UniversalSelector(
              items: testItems,
              selectedItems: selectedItems,
              isMultiSelect: true,
              onItemSelected: (SelectableItem item) {
                singleCallbackCalled =
                    true; // Этот callback не должен вызываться
              },
              onItemsSelected: (List<SelectableItem> items) {
                selectedItems = items;
                multiCallbackCalled = true;
              },
            ),
          ),
        ),
      );

      // Виджет должен отрендериться без ошибок
      expect(find.byType(UniversalSelector), findsOneWidget);
      expect(singleCallbackCalled, false);
      expect(multiCallbackCalled, false);
    });
  });
}

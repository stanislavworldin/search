import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:multiselector/multiselector.dart';

void main() {
  group('UniversalSelector Tests', () {
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

    testWidgets('UniversalSelector displays correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: UniversalSelector(
              items: testItems,
              selectedItem: null,
              onItemSelected: _emptyCallback,
            ),
          ),
        ),
      );
      expect(find.byType(UniversalSelector), findsOneWidget);
    });

    testWidgets('UniversalSelector shows selected item',
        (WidgetTester tester) async {
      const testItem = SelectableItem(
        id: '1',
        name: 'Apple',
        icon: '🍎',
        subtitle: 'Red fruit',
      );
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: UniversalSelector(
              items: testItems,
              selectedItem: testItem,
              onItemSelected: _emptyCallback,
            ),
          ),
        ),
      );
      expect(find.text('🍎'), findsOneWidget);
      expect(find.text('Apple'), findsOneWidget);
    });

    test('ItemData contains items', () {
      expect(testItems, isNotEmpty);
      expect(testItems.length, equals(3));
    });

    test('ItemData can find item by id', () {
      final item = ItemData.getItemById(testItems, '1');
      expect(item, isNotNull);
      expect(item!.id, equals('1'));
      expect(item.name, equals('Apple'));
      expect(item.icon, equals('🍎'));
    });

    test('ItemData returns null for invalid id', () {
      final item = ItemData.getItemById(testItems, 'INVALID');
      expect(item, isNull);
    });

    test('ItemData can sort items', () {
      final sortedItems = ItemData.getSortedItems(testItems);
      expect(sortedItems, isNotEmpty);
      expect(sortedItems.length, equals(3));
      // Should be sorted alphabetically
      expect(sortedItems[0].name, equals('Apple'));
      expect(sortedItems[1].name, equals('Banana'));
      expect(sortedItems[2].name, equals('Orange'));
    });

    test('ItemData search works', () {
      final results = ItemData.searchItems(testItems, 'apple');
      expect(results, isNotEmpty);
      expect(results.any((item) => item.id == '1'), isTrue);
    });

    test('ItemData search is case insensitive', () {
      final results = ItemData.searchItems(testItems, 'APPLE');
      expect(results, isNotEmpty);
      expect(results.any((item) => item.id == '1'), isTrue);
    });

    test('ItemData search by subtitle works', () {
      final results = ItemData.searchItems(testItems, 'yellow');
      expect(results, isNotEmpty);
      expect(results.any((item) => item.id == '2'), isTrue);
    });

    test('ItemData search by search data works', () {
      final results = ItemData.searchItems(testItems, 'citrus');
      expect(results, isNotEmpty);
      expect(results.any((item) => item.id == '3'), isTrue);
    });

    test('ItemData fuzzy search works', () {
      final results = ItemData.searchItemsWithFuzzy(testItems, 'appl');
      expect(results, isNotEmpty);
      expect(results.any((item) => item.id == '1'), isTrue);
    });

    test('ItemData fuzzy search handles typos', () {
      final results = ItemData.searchItemsWithFuzzy(testItems, 'bannana');
      expect(results, isNotEmpty);
      expect(results.any((item) => item.id == '2'), isTrue);
    });

    test('ItemData empty search returns all items', () {
      final results = ItemData.searchItems(testItems, '');
      expect(results.length, equals(testItems.length));
    });

    test('ItemData fuzzy empty search returns all items', () {
      final results = ItemData.searchItemsWithFuzzy(testItems, '');
      expect(results.length, equals(testItems.length));
    });
  });
}

void _emptyCallback(SelectableItem _) {}

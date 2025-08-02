import 'package:search/search.dart';
import 'package:test/test.dart';

void main() {
  group('SearchEngine Tests', () {
    final testItems = [
      const SearchableItem(
        id: '1',
        name: 'Apple',
        icon: '🍎',
        subtitle: 'Red fruit',
        searchData: 'apple fruit red',
      ),
      const SearchableItem(
        id: '2',
        name: 'Banana',
        icon: '🍌',
        subtitle: 'Yellow fruit',
        searchData: 'banana fruit yellow',
      ),
      const SearchableItem(
        id: '3',
        name: 'Orange',
        icon: '🍊',
        subtitle: 'Orange fruit',
        searchData: 'orange fruit citrus',
      ),
      const SearchableItem(
        id: '4',
        name: 'Grape',
        icon: '🍇',
        subtitle: 'Purple fruit',
        searchData: 'grape fruit purple',
      ),
    ];

    group('Basic Search', () {
      test('should return all items for empty query', () {
        final results = SearchEngine.search(testItems, '');
        expect(results.length, equals(4));
      });

      test('should find exact matches', () {
        final results = SearchEngine.search(testItems, 'apple');
        expect(results.length, equals(1));
        expect(results.first.name, equals('Apple'));
      });

      test('should find starts with matches', () {
        final results = SearchEngine.search(testItems, 'app');
        expect(results.length, equals(1));
        expect(results.first.name, equals('Apple'));
      });

      test('should find contains matches', () {
        final results = SearchEngine.search(testItems, 'fruit');
        expect(results.length, equals(4));
      });

      test('should search in subtitle', () {
        final results = SearchEngine.search(testItems, 'red');
        expect(results.length, equals(1));
        expect(results.first.name, equals('Apple'));
      });

      test('should search in searchData', () {
        final results = SearchEngine.search(testItems, 'citrus');
        expect(results.length, equals(1));
        expect(results.first.name, equals('Orange'));
      });
    });

    group('Fuzzy Search', () {
      test('should find items with typos', () {
        final results = SearchEngine.fuzzySearch(testItems, 'aple');
        expect(results.length, equals(1));
        expect(results.first.name, equals('Apple'));
      });

      test('should find items with misspellings', () {
        final results = SearchEngine.fuzzySearch(testItems, 'bananna');
        expect(results.length, equals(1));
        expect(results.first.name, equals('Banana'));
      });

      test('should not use fuzzy search for very short queries', () {
        // Create items that don't contain 'xy' to test fuzzy search only
        final testItemsForFuzzy = [
          const SearchableItem(id: '1', name: 'Apple', subtitle: 'Fruit'),
          const SearchableItem(id: '2', name: 'Banana', subtitle: 'Fruit'),
        ];

        // For 'xy' - should not find anything since no item contains 'xy' and fuzzy is disabled for short queries
        final results = SearchEngine.fuzzySearch(testItemsForFuzzy, 'xy');
        expect(results.length, equals(0));
      });

      test('should find items for short but valid queries', () {
        final results = SearchEngine.fuzzySearch(testItems, 'app');
        expect(results.length, equals(1));
        expect(results.first.name, equals('Apple'));
      });
    });

    group('Search Configuration', () {
      test('should respect case sensitive setting', () {
        const config = SearchConfig(caseSensitive: true);
        final results = SearchEngine.search(testItems, 'APPLE', config: config);
        expect(results.length, equals(0));
      });

      test('should search only specified fields', () {
        const config = SearchConfig(searchFields: ['name']);
        final results = SearchEngine.search(testItems, 'red', config: config);
        expect(results.length, equals(0));
      });

      test('should disable fuzzy search', () {
        const config = SearchConfig(fuzzyEnabled: false);
        final results =
            SearchEngine.fuzzySearch(testItems, 'aple', config: config);
        expect(results.length, equals(0));
      });
    });

    group('Utility Methods', () {
      test('should sort items by name', () {
        final sorted = SearchEngine.getSortedItems(testItems);
        expect(sorted.first.name, equals('Apple'));
        expect(sorted.last.name, equals('Orange'));
      });

      test('should find item by ID', () {
        final item = SearchEngine.getItemById(testItems, '2');
        expect(item?.name, equals('Banana'));
      });

      test('should return null for non-existent ID', () {
        final item = SearchEngine.getItemById(testItems, '999');
        expect(item, isNull);
      });
    });

    group('SearchableItem', () {
      test('should have correct toString', () {
        const item = SearchableItem(id: '1', name: 'Test', icon: '🎯');
        expect(item.toString(), equals('🎯 Test'));
      });

      test('should have correct equality', () {
        const item1 = SearchableItem(id: '1', name: 'Test');
        const item2 = SearchableItem(id: '1', name: 'Test');
        const item3 = SearchableItem(id: '2', name: 'Test');

        expect(item1, equals(item2));
        expect(item1, isNot(equals(item3)));
      });

      test('should have correct hashCode', () {
        const item1 = SearchableItem(id: '1', name: 'Test');
        const item2 = SearchableItem(id: '1', name: 'Test');
        expect(item1.hashCode, equals(item2.hashCode));
      });
    });
  });
}

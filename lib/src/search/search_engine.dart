import 'searchable_item.dart';

/// Configuration for search engine
class SearchConfig {
  /// Fields to search in
  final List<String> searchFields;

  /// Enable fuzzy search for typos
  final bool fuzzyEnabled;

  /// Maximum distance for fuzzy search
  final int maxFuzzyDistance;

  /// Case sensitive search
  final bool caseSensitive;

  const SearchConfig({
    this.searchFields = const ['name', 'subtitle', 'searchData'],
    this.fuzzyEnabled = true,
    this.maxFuzzyDistance = 3,
    this.caseSensitive = false,
  });
}

/// Fast and lightweight search engine with fuzzy search capabilities
class SearchEngine {
  const SearchEngine._();

  /// Get a sorted list of items by name
  static List<SearchableItem> getSortedItems(List<SearchableItem> items) {
    final sortedItems = List<SearchableItem>.from(items);
    sortedItems.sort(
      (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
    );
    return sortedItems;
  }

  /// Get an item by its ID
  static SearchableItem? getItemById(List<SearchableItem> items, String id) {
    try {
      return items.firstWhere((item) => item.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Search items with basic matching
  static List<SearchableItem> search(
    List<SearchableItem> items,
    String query, {
    SearchConfig config = const SearchConfig(),
  }) {
    if (query.isEmpty) return items;

    final searchQuery = config.caseSensitive
        ? query
        : query.toLowerCase().trim();
    final results = <SearchableItem>[];
    final exactMatches = <SearchableItem>[];
    final startsWithMatches = <SearchableItem>[];
    final containsMatches = <SearchableItem>[];

    for (final item in items) {
      for (final field in config.searchFields) {
        final fieldValue = _getFieldValue(item, field);
        if (fieldValue == null) continue;

        final searchValue = config.caseSensitive
            ? fieldValue
            : fieldValue.toLowerCase();

        // Exact match
        if (searchValue == searchQuery) {
          exactMatches.add(item);
          break;
        }
        // Starts with query
        else if (searchValue.startsWith(searchQuery)) {
          startsWithMatches.add(item);
          break;
        }
        // Contains query
        else if (searchValue.contains(searchQuery)) {
          containsMatches.add(item);
          break;
        }
      }
    }

    // Combine results in priority order
    results.addAll(exactMatches);
    results.addAll(startsWithMatches);
    results.addAll(containsMatches);

    return results;
  }

  /// Search items with fuzzy matching for typos and misspellings
  static List<SearchableItem> fuzzySearch(
    List<SearchableItem> items,
    String query, {
    SearchConfig config = const SearchConfig(),
  }) {
    if (query.isEmpty) return items;

    final searchQuery = config.caseSensitive
        ? query
        : query.toLowerCase().trim();
    final results = <SearchableItem>[];
    final exactMatches = <SearchableItem>[];
    final startsWithMatches = <SearchableItem>[];
    final containsMatches = <SearchableItem>[];
    final fuzzyMatches = <SearchableItem>[];

    for (final item in items) {
      bool found = false;

      for (final field in config.searchFields) {
        final fieldValue = _getFieldValue(item, field);
        if (fieldValue == null) continue;

        final searchValue = config.caseSensitive
            ? fieldValue
            : fieldValue.toLowerCase();

        // 1. Exact matches
        if (searchValue == searchQuery) {
          exactMatches.add(item);
          found = true;
          break;
        }

        // 2. Starts with query
        if (!found && searchValue.startsWith(searchQuery)) {
          startsWithMatches.add(item);
          found = true;
          break;
        }

        // 3. Contains query
        if (!found && searchValue.contains(searchQuery)) {
          containsMatches.add(item);
          found = true;
          break;
        }

        // 4. Fuzzy search for typos and misspellings (only for queries >= 3 characters)
        if (!found &&
            config.fuzzyEnabled &&
            searchQuery.length >= 3 &&
            _isFuzzyMatch(searchQuery, searchValue, config.maxFuzzyDistance)) {
          fuzzyMatches.add(item);
          found = true;
          break;
        }
      }
    }

    results.addAll(exactMatches);
    results.addAll(startsWithMatches);
    results.addAll(containsMatches);
    results.addAll(fuzzyMatches);

    return results;
  }

  /// Get field value from item
  static String? _getFieldValue(SearchableItem item, String field) {
    switch (field) {
      case 'name':
        return item.name;
      case 'subtitle':
        return item.subtitle;
      case 'searchData':
        return item.searchData;
      default:
        return null;
    }
  }

  /// Calculate Levenshtein distance for fuzzy search
  static int _levenshteinDistance(String s1, String s2) {
    if (s1.isEmpty) return s2.length;
    if (s2.isEmpty) return s1.length;

    List<List<int>> matrix = List.generate(
      s1.length + 1,
      (i) => List.generate(s2.length + 1, (j) => 0),
    );

    for (int i = 0; i <= s1.length; i++) {
      matrix[i][0] = i;
    }
    for (int j = 0; j <= s2.length; j++) {
      matrix[0][j] = j;
    }

    for (int i = 1; i <= s1.length; i++) {
      for (int j = 1; j <= s2.length; j++) {
        int cost = s1[i - 1] == s2[j - 1] ? 0 : 1;
        matrix[i][j] = [
          matrix[i - 1][j] + 1, // deletion
          matrix[i][j - 1] + 1, // insertion
          matrix[i - 1][j - 1] + cost, // substitution
        ].reduce((a, b) => a < b ? a : b);
      }
    }

    return matrix[s1.length][s2.length];
  }

  /// Check fuzzy match with distance threshold
  static bool _isFuzzyMatch(String query, String text, int maxDistance) {
    if (query.length < 3) {
      return false; // Skip fuzzy search for very short queries
    }

    final distance = _levenshteinDistance(query, text);
    final maxAllowedDistance = (query.length / 3).ceil(); // Adaptive threshold
    final threshold = maxDistance < maxAllowedDistance
        ? maxDistance
        : maxAllowedDistance;

    return distance <= threshold;
  }
}

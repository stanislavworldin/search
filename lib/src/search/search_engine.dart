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

  /// Optional debug logger callback. Use to trace internal decisions.
  /// Example: pass `debugPrint` in Flutter apps.
  final void Function(String message)? debugLogger;

  const SearchConfig({
    this.searchFields = const ['name', 'subtitle', 'searchData'],
    this.fuzzyEnabled = true,
    this.maxFuzzyDistance = 3,
    this.caseSensitive = false,
    this.debugLogger,
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
    for (final item in items) {
      if (item.id == id) {
        return item;
      }
    }
    return null;
  }

  /// Search items with basic matching
  static List<SearchableItem> search(
    List<SearchableItem> items,
    String query, {
    SearchConfig config = const SearchConfig(),
  }) {
    if (query.isEmpty) return items;

    final normalizedQuery = config.caseSensitive ? query : query.toLowerCase();
    final searchQuery = normalizedQuery.trim();
    final results = <SearchableItem>[];
    final exactMatches = <SearchableItem>[];
    final startsWithMatches = <SearchableItem>[];
    final containsMatches = <SearchableItem>[];

    for (final item in items) {
      for (final field in config.searchFields) {
        final fieldValue = _getFieldValue(item, field);
        if (fieldValue == null) continue;

        final searchValue =
            config.caseSensitive ? fieldValue : fieldValue.toLowerCase();

        // Exact match
        if (searchValue == searchQuery) {
          exactMatches.add(item);
          config.debugLogger?.call('Exact match: id=${item.id}, field=$field');
          break;
        }
        // Starts with query
        else if (searchValue.startsWith(searchQuery)) {
          startsWithMatches.add(item);
          config.debugLogger
              ?.call('StartsWith match: id=${item.id}, field=$field');
          break;
        }
        // Contains query
        else if (searchValue.contains(searchQuery)) {
          containsMatches.add(item);
          config.debugLogger
              ?.call('Contains match: id=${item.id}, field=$field');
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

    final normalizedQuery = config.caseSensitive ? query : query.toLowerCase();
    final searchQuery = normalizedQuery.trim();
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

        final searchValue =
            config.caseSensitive ? fieldValue : fieldValue.toLowerCase();

        // 1. Exact matches
        if (searchValue == searchQuery) {
          exactMatches.add(item);
          found = true;
          config.debugLogger?.call('Exact match: id=${item.id}, field=$field');
          break;
        }

        // 2. Starts with query
        if (!found && searchValue.startsWith(searchQuery)) {
          startsWithMatches.add(item);
          found = true;
          config.debugLogger
              ?.call('StartsWith match: id=${item.id}, field=$field');
          break;
        }

        // 3. Contains query
        if (!found && searchValue.contains(searchQuery)) {
          containsMatches.add(item);
          found = true;
          config.debugLogger
              ?.call('Contains match: id=${item.id}, field=$field');
          break;
        }

        // 4. Fuzzy search for typos and misspellings (only for queries >= 3 characters)
        if (!found && config.fuzzyEnabled && searchQuery.length >= 3) {
          // Token-aware fuzzy: split both sides by whitespace for better partial matching
          final tokens = searchValue.split(RegExp(r"\s+"));
          bool fuzzyHit = false;
          for (final token in tokens) {
            if (_isFuzzyMatch(searchQuery, token, config.maxFuzzyDistance)) {
              fuzzyHit = true;
              break;
            }
          }
          // Also check whole field as a fallback
          fuzzyHit = fuzzyHit ||
              _isFuzzyMatch(searchQuery, searchValue, config.maxFuzzyDistance);

          if (fuzzyHit) {
            fuzzyMatches.add(item);
            found = true;
            config.debugLogger
                ?.call('Fuzzy match: id=${item.id}, field=$field');
            break;
          }
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

    // Ensure s1 is the shorter string to reduce memory usage
    if (s1.length > s2.length) {
      final tmp = s1;
      s1 = s2;
      s2 = tmp;
    }

    final int len1 = s1.length;
    final int len2 = s2.length;

    // Use two-row dynamic programming to reduce memory from O(n*m) to O(min(n,m))
    final previous = List<int>.generate(len2 + 1, (j) => j);
    final current = List<int>.filled(len2 + 1, 0);

    for (int i = 1; i <= len1; i++) {
      current[0] = i;
      for (int j = 1; j <= len2; j++) {
        final int cost = s1.codeUnitAt(i - 1) == s2.codeUnitAt(j - 1) ? 0 : 1;
        final deletion = previous[j] + 1;
        final insertion = current[j - 1] + 1;
        final substitution = previous[j - 1] + cost;
        int value = deletion < insertion ? deletion : insertion;
        if (substitution < value) value = substitution;
        current[j] = value;
      }
      // swap rows
      for (int j = 0; j <= len2; j++) {
        final temp = previous[j];
        previous[j] = current[j];
        current[j] = temp;
      }
    }
    return previous[len2];
  }

  /// Check fuzzy match with distance threshold
  static bool _isFuzzyMatch(String query, String text, int maxDistance) {
    if (query.length < 3) {
      return false; // Skip fuzzy search for very short queries
    }

    // Quick length filter: if lengths differ too much, skip
    final int lengthDiff = (query.length - text.length).abs();
    if (lengthDiff > maxDistance && lengthDiff > (query.length / 3).ceil()) {
      return false;
    }

    final distance = _levenshteinDistance(query, text);
    final maxAllowedDistance = (query.length / 3).ceil(); // Adaptive threshold
    final threshold =
        maxDistance < maxAllowedDistance ? maxDistance : maxAllowedDistance;

    return distance <= threshold;
  }
}

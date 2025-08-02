import 'package:flutter/foundation.dart';

/// Represents a generic item with customizable fields
class SelectableItem {
  /// Unique identifier for the item
  final String id;

  /// Display name of the item
  final String name;

  /// Optional icon/emoji for the item
  final String? icon;

  /// Optional subtitle/description
  final String? subtitle;

  /// Optional additional data that can be used for search
  final String? searchData;

  /// Optional custom data object
  final dynamic data;

  /// Creates a new SelectableItem instance.
  ///
  /// [id] - Unique identifier for the item
  /// [name] - Display name of the item
  /// [icon] - Optional icon/emoji for the item
  /// [subtitle] - Optional subtitle/description
  /// [searchData] - Optional additional data for search
  /// [data] - Optional custom data object
  const SelectableItem({
    required this.id,
    required this.name,
    this.icon,
    this.subtitle,
    this.searchData,
    this.data,
  });

  @override
  String toString() => '$icon $name';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SelectableItem &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          icon == other.icon &&
          subtitle == other.subtitle &&
          searchData == other.searchData;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      icon.hashCode ^
      subtitle.hashCode ^
      searchData.hashCode;
}

/// Utility class for managing item data and operations
class ItemData {
  /// Creates a new ItemData instance.
  ///
  /// This class provides static methods for item operations.
  /// It cannot be instantiated directly.
  const ItemData._();

  /// Get an item by its ID
  ///
  /// Returns null if the item is not found
  static SelectableItem? getItemById(List<SelectableItem> items, String id) {
    try {
      return items.firstWhere((item) => item.id == id);
    } catch (e) {
      if (kDebugMode) {
        debugPrint('DEBUG: Item not found for id: $id');
      }
      return null;
    }
  }

  /// Get a sorted list of items by name
  static List<SelectableItem> getSortedItems(List<SelectableItem> items) {
    final sortedItems = List<SelectableItem>.from(items);

    sortedItems.sort((a, b) {
      return a.name.toLowerCase().compareTo(b.name.toLowerCase());
    });

    if (kDebugMode) {
      debugPrint('DEBUG: Sorted ${sortedItems.length} items');
    }
    return sortedItems;
  }

  /// Search items by name, subtitle, or search data
  ///
  /// [items] is the list of items to search in
  /// [query] is the search term
  static List<SelectableItem> searchItems(
      List<SelectableItem> items, String query) {
    if (query.isEmpty) return items;

    final lowercaseQuery = query.toLowerCase().trim();
    final results = <SelectableItem>[];
    final exactMatches = <SelectableItem>[];
    final startsWithMatches = <SelectableItem>[];
    final containsMatches = <SelectableItem>[];

    for (final item in items) {
      final itemName = item.name.toLowerCase();
      final itemSubtitle = item.subtitle?.toLowerCase() ?? '';
      final itemSearchData = item.searchData?.toLowerCase() ?? '';

      // Exact match
      if (itemName == lowercaseQuery ||
          itemSubtitle == lowercaseQuery ||
          itemSearchData == lowercaseQuery) {
        exactMatches.add(item);
      }
      // Starts with query
      else if (itemName.startsWith(lowercaseQuery) ||
          itemSubtitle.startsWith(lowercaseQuery) ||
          itemSearchData.startsWith(lowercaseQuery)) {
        startsWithMatches.add(item);
      }
      // Contains query
      else if (itemName.contains(lowercaseQuery) ||
          itemSubtitle.contains(lowercaseQuery) ||
          itemSearchData.contains(lowercaseQuery)) {
        containsMatches.add(item);
      }
    }

    // Combine results in priority order
    results.addAll(exactMatches);
    results.addAll(startsWithMatches);
    results.addAll(containsMatches);

    if (kDebugMode) {
      debugPrint('DEBUG: Search "$query" - found ${results.length} items');
    }
    return results;
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
  static bool _isFuzzyMatch(String query, String text, {int maxDistance = 3}) {
    if (query.length <= 2) {
      return false; // Skip fuzzy search for very short queries
    }

    final distance = _levenshteinDistance(query, text);
    final maxAllowedDistance = (query.length / 3).ceil(); // Adaptive threshold
    final threshold =
        maxDistance < maxAllowedDistance ? maxDistance : maxAllowedDistance;

    return distance <= threshold;
  }

  /// Search items with fuzzy matching for typos and misspellings
  static List<SelectableItem> searchItemsWithFuzzy(
      List<SelectableItem> items, String query) {
    if (query.isEmpty) return items;

    final lowercaseQuery = query.toLowerCase().trim();
    final results = <SelectableItem>[];
    final exactMatches = <SelectableItem>[];
    final startsWithMatches = <SelectableItem>[];
    final containsMatches = <SelectableItem>[];
    final fuzzyMatches = <SelectableItem>[];

    for (final item in items) {
      final itemName = item.name.toLowerCase();
      final itemSubtitle = item.subtitle?.toLowerCase() ?? '';
      final itemSearchData = item.searchData?.toLowerCase() ?? '';

      bool found = false;

      // 1. Exact matches
      if (itemName == lowercaseQuery ||
          itemSubtitle == lowercaseQuery ||
          itemSearchData == lowercaseQuery) {
        exactMatches.add(item);
        found = true;
      }

      // 2. Starts with query
      if (!found &&
          (itemName.startsWith(lowercaseQuery) ||
              itemSubtitle.startsWith(lowercaseQuery) ||
              itemSearchData.startsWith(lowercaseQuery))) {
        startsWithMatches.add(item);
        found = true;
      }

      // 3. Contains query
      if (!found &&
          (itemName.contains(lowercaseQuery) ||
              itemSubtitle.contains(lowercaseQuery) ||
              itemSearchData.contains(lowercaseQuery))) {
        containsMatches.add(item);
        found = true;
      }

      // 4. Fuzzy search for typos and misspellings
      if (!found &&
          (_isFuzzyMatch(lowercaseQuery, itemName) ||
              _isFuzzyMatch(lowercaseQuery, itemSubtitle) ||
              _isFuzzyMatch(lowercaseQuery, itemSearchData))) {
        fuzzyMatches.add(item);
      }
    }

    results.addAll(exactMatches);
    results.addAll(startsWithMatches);
    results.addAll(containsMatches);
    results.addAll(fuzzyMatches);

    if (kDebugMode) {
      debugPrint(
          'DEBUG: Fuzzy search "$query" - found ${results.length} items');
      debugPrint(
          'DEBUG: Exact: ${exactMatches.length}, StartsWith: ${startsWithMatches.length}, Contains: ${containsMatches.length}, Fuzzy: ${fuzzyMatches.length}');
    }
    return results;
  }
}

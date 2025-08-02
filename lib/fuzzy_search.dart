/// A Dart package for fast and lightweight search with fuzzy search capabilities.
///
/// This package provides a pure Dart search engine with no UI dependencies,
/// making it perfect for integrating search functionality into any application.
///
/// ## Features
/// - 🔍 Fast search by name, subtitle, or custom fields
/// - 🎯 Fuzzy search for typos and misspellings
/// - ⚡ Optimized performance with priority-based results
/// - 🎨 Configurable search behavior
/// - 📦 Zero dependencies - pure Dart implementation
///
/// ## Quick Start
/// ```dart
/// final items = [
///   SearchableItem(id: '1', name: 'Apple', subtitle: 'Red fruit'),
///   SearchableItem(id: '2', name: 'Banana', subtitle: 'Yellow fruit'),
/// ];
///
/// // Basic search
/// final results = SearchEngine.search(items, 'apple');
///
/// // Fuzzy search for typos
/// final fuzzyResults = SearchEngine.fuzzySearch(items, 'aple');
/// ```
library search;

export 'src/search/search_engine.dart';
export 'src/search/searchable_item.dart';

# Search Engine

Fast and lightweight search engine for Dart/Flutter with fuzzy search capabilities — lightweight and flexible.

## How Search Works

The search engine uses a **4-level priority algorithm** to find the most relevant results:

### **1. Search Priorities (in order of importance)**

1. **Exact matches** - `"apple"` = `"apple"`
2. **Starts with** - `"app"` → `"apple"`  
3. **Contains** - `"ple"` → `"apple"`
4. **Fuzzy search** - `"aple"` → `"apple"` (only for queries ≥3 characters)

### **2. Search Fields**

By default, search looks in **3 fields**:
- `name` - item name
- `subtitle` - item subtitle
- `searchData` - additional search data

### **3. Character Types**

Search works with **any characters**:
- ✅ **Letters**: `"apple"`, `"Яблоко"`
- ✅ **Numbers**: `"iPhone 14"`, `"Windows 11"`
- ✅ **Special characters**: `"C++"`, `"React.js"`
- ✅ **Emojis**: `"🍎 Apple"`
- ✅ **Spaces**: `"Red fruit"`

### **4. Why 4 Levels?**

This is **one smart algorithm**, not 4 different searches:

1. **Exact** - for quick exact match finding (100% relevance)
2. **Starts with** - for autocomplete (user types beginning) (90% relevance)
3. **Contains** - for partial word search (70% relevance)
4. **Fuzzy** - for typo correction (50% relevance)

**Results are sorted by priority** - exact matches first, then others.

## Features

- 🔍 **Fast search** by name, subtitle, or custom fields
- 🎯 **Fuzzy search** for typos and misspellings
- ⚡ **Optimized performance** with priority-based results
- 🎨 **Configurable search** behavior
- 📦 **Zero dependencies** - pure Dart implementation

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  search: ^1.0.0
```

## Quick Start

```dart
import 'package:search/search.dart';

void main() {
  final items = [
    SearchableItem(id: '1', name: 'Apple', subtitle: 'Red fruit'),
    SearchableItem(id: '2', name: 'Banana', subtitle: 'Yellow fruit'),
    SearchableItem(id: '3', name: 'Orange', subtitle: 'Orange fruit'),
  ];

  // Basic search
  final results = SearchEngine.search(items, 'apple');
  print(results); // [Apple]

  // Fuzzy search for typos
  final fuzzyResults = SearchEngine.fuzzySearch(items, 'aple');
  print(fuzzyResults); // [Apple]
}
```

## API Reference

### SearchableItem

Represents a searchable item with customizable fields.

```dart
const item = SearchableItem(
  id: '1',
  name: 'Apple',
  icon: '🍎',
  subtitle: 'Red fruit',
  searchData: 'apple fruit red',
  data: {'price': 1.99},
);
```

### SearchEngine

Main search engine class with static methods.

#### Basic Search

```dart
// Search with default configuration
List<SearchableItem> results = SearchEngine.search(items, query);

// Search with custom configuration
List<SearchableItem> results = SearchEngine.search(
  items, 
  query,
  config: SearchConfig(
    searchFields: ['name', 'subtitle'],
    caseSensitive: false,
  ),
);
```

#### Fuzzy Search

```dart
// Fuzzy search for typos and misspellings
List<SearchableItem> results = SearchEngine.fuzzySearch(items, query);

// Fuzzy search with custom configuration
List<SearchableItem> results = SearchEngine.fuzzySearch(
  items, 
  query,
  config: SearchConfig(
    fuzzyEnabled: true,
    maxFuzzyDistance: 3,
  ),
);
```

#### Utility Methods

```dart
// Sort items by name
List<SearchableItem> sorted = SearchEngine.getSortedItems(items);

// Find item by ID
SearchableItem? item = SearchEngine.getItemById(items, 'item_id');
```

### SearchConfig

Configuration for search behavior.

```dart
const config = SearchConfig(
  searchFields: ['name', 'subtitle', 'searchData'], // Fields to search in
  fuzzyEnabled: true,                              // Enable fuzzy search
  maxFuzzyDistance: 3,                            // Max distance for fuzzy search
  caseSensitive: false,                           // Case sensitive search
);
```

## Search Algorithm

The search engine uses a priority-based algorithm:

1. **Exact matches** - Highest priority
2. **Starts with matches** - Second priority  
3. **Contains matches** - Third priority
4. **Fuzzy matches** - Lowest priority (only in fuzzy search)

### Fuzzy Search

Fuzzy search uses the Levenshtein distance algorithm to find items with typos and misspellings. It automatically adjusts the distance threshold based on query length for optimal results.

## Examples

### Basic Usage

```dart
final countries = [
  SearchableItem(id: 'us', name: 'United States', subtitle: 'North America'),
  SearchableItem(id: 'uk', name: 'United Kingdom', subtitle: 'Europe'),
  SearchableItem(id: 'ca', name: 'Canada', subtitle: 'North America'),
];

// Search by name
final results = SearchEngine.search(countries, 'united');
// Returns: [United States, United Kingdom]

// Search by subtitle
final results = SearchEngine.search(countries, 'europe');
// Returns: [United Kingdom]
```

### Advanced Configuration

```dart
final config = SearchConfig(
  searchFields: ['name'], // Only search in name field
  caseSensitive: true,    // Case sensitive search
  fuzzyEnabled: false,    // Disable fuzzy search
);

final results = SearchEngine.search(countries, 'UNITED', config: config);
// Returns: [] (no exact match for 'UNITED')
```

### Fuzzy Search Examples

```dart
final fruits = [
  SearchableItem(id: '1', name: 'Apple'),
  SearchableItem(id: '2', name: 'Banana'),
  SearchableItem(id: '3', name: 'Orange'),
];

// Find items with typos
SearchEngine.fuzzySearch(fruits, 'aple');   // Returns: [Apple]
SearchEngine.fuzzySearch(fruits, 'bananna'); // Returns: [Banana]
SearchEngine.fuzzySearch(fruits, 'oragne');  // Returns: [Orange]
```

## Performance

- **Time Complexity**: O(n * m) where n is number of items, m is average field length
- **Space Complexity**: O(n) for storing results
- **Memory**: Minimal memory footprint with no external dependencies

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License. 
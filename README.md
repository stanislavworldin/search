# multiselector

[![Pub](https://img.shields.io/pub/v/multiselector.svg)](https://pub.dev/packages/multiselector)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/stanislavworldin/multiselector/blob/main/LICENSE)
[![Flutter](https://img.shields.io/badge/flutter-%E2%89%A53.0-blue?logo=flutter)](https://flutter.dev)

Lightweight and blazing fast universal item selector for Flutter apps with fuzzy search and customizable UI — perfect for any list selection needs.

**🌐 Live Demo:** [View on GitHub Pages](https://stanislavworldin.github.io/multiselector/)

![Universal Selector Demo](https://raw.githubusercontent.com/stanislavworldin/multiselector/main/screenshots/1.png)

## Features

- **Universal Selection** - Works with any list of items (countries, fruits, colors, etc.)
- **Multi-Select Support** - Choose single or multiple items with configurable limits
- **Smart Search** - Find items by name, subtitle, or custom search data with fuzzy matching
- **Customizable UI** - Dark/light themes with custom colors and styling
- **High Performance** - Optimized search algorithm with fuzzy search support
- **Responsive Design** - Works perfectly on mobile, tablet, and desktop
- **Easy Integration** - Zero configuration required, works out of the box
- **Flexible Data** - Support for icons, subtitles, and custom search data

## Performance

- **Package Size:** ~50KB (lightweight, no translations)
- **Search Speed:** Fast fuzzy search with typos support
- **Memory Usage:** Optimized for weak devices
- **Multi-Select:** Efficient handling of multiple selections
- **Flexible:** Works with any data structure

## Installation

Add the dependency to your `pubspec.yaml`:

```yaml
dependencies:
  multiselector: ^1.0.0
```

## Usage

### Basic Usage

#### Single Selection

```dart
import 'package:multiselector/multiselector.dart';

// Define your items
final List<SelectableItem> items = [
  const SelectableItem(
    id: 'apple',
    name: 'Apple',
    icon: '🍎',
    subtitle: 'Red fruit',
    searchData: 'apple fruit red sweet',
  ),
  const SelectableItem(
    id: 'banana',
    name: 'Banana',
    icon: '🍌',
    subtitle: 'Yellow fruit',
    searchData: 'banana fruit yellow potassium',
  ),
];

// Single selection
UniversalSelector(
  items: items,
  selectedItem: selectedItem,
  onItemSelected: (SelectableItem item) {
    setState(() {
      selectedItem = item;
    });
    debugPrint('Selected: ${item.icon} ${item.name}');
  },
)
```

#### Multi Selection

```dart
// Multi selection
List<SelectableItem> selectedItems = [];

UniversalSelector(
  items: items,
  selectedItems: selectedItems,
  isMultiSelect: true,
  onItemsSelected: (List<SelectableItem> items) {
    setState(() {
      selectedItems = items;
    });
    debugPrint('Selected ${items.length} items');
  },
  maxSelections: 3, // Optional: limit selections
)
```

## API Reference

### UniversalSelector

The main widget for item selection.

#### Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `items` | `List<SelectableItem>` | Required | List of items to display in the selector |
| `selectedItem` | `SelectableItem?` | `null` | Currently selected item. Pass `null` for no selection |
| `selectedItems` | `List<SelectableItem>` | `[]` | List of currently selected items for multi-select mode |
| `onItemSelected` | `Function(SelectableItem)` | Required | Callback function triggered when user selects an item |
| `onItemsSelected` | `Function(List<SelectableItem>)?` | `null` | Callback function for multi-select mode |
| `isMultiSelect` | `bool` | `false` | Enable multi-select mode |
| `maxSelections` | `int?` | `null` | Maximum number of items that can be selected |
| `labelText` | `String?` | `'Select Item'` | Text displayed in the modal header |
| `hintText` | `String?` | `'Search items...'` | Placeholder text in the search field |
| `showSubtitle` | `bool` | `true` | Whether to display subtitles for items |
| `backgroundColor` | `Color?` | Dark theme | Background color of the modal dialog |
| `headerColor` | `Color?` | Dark theme | Background color of the modal header |
| `textColor` | `Color?` | Dark theme | Primary text color for item names |
| `accentColor` | `Color?` | Green | Color for accent elements (like selected items) |
| `searchFieldColor` | `Color?` | Dark theme | Background color of the search input field |
| `searchFieldBorderColor` | `Color?` | Dark theme | Border color of the search input field |
| `cursorColor` | `Color?` | White | Color of the text cursor in the search field |
| `hintTextColor` | `Color?` | Dark theme | Color of placeholder text in search field |
| `hoverColor` | `Color?` | Dark theme | Background color when hovering over items |
| `borderRadius` | `double?` | `8.0` | Border radius applied to all rounded elements |

### SelectableItem

Represents a selectable item with its properties.

#### Properties

| Property | Type | Description |
|----------|------|-------------|
| `id` | `String` | Unique identifier for the item |
| `name` | `String` | Display name of the item |
| `icon` | `String?` | Optional icon/emoji for the item |
| `subtitle` | `String?` | Optional subtitle/description |
| `searchData` | `String?` | Optional additional data for search |
| `data` | `dynamic` | Optional custom data object |

## Examples

### Countries Selection

```dart
final List<SelectableItem> countries = [
  const SelectableItem(
    id: 'us',
    name: 'United States',
    icon: '🇺🇸',
    subtitle: 'USA',
    searchData: 'united states america us usa',
  ),
  const SelectableItem(
    id: 'ru',
    name: 'Russia',
    icon: '🇷🇺',
    subtitle: 'Russian Federation',
    searchData: 'russia russian federation',
  ),
];

UniversalSelector(
  items: countries,
  selectedItem: selectedCountry,
  onItemSelected: (SelectableItem country) {
    setState(() {
      selectedCountry = country;
    });
  },
  labelText: 'Choose a country',
  hintText: 'Search countries...',
)
```

### Custom Theme

```dart
UniversalSelector(
  items: items,
  selectedItem: selectedItem,
  onItemSelected: (SelectableItem item) {
    setState(() {
      selectedItem = item;
    });
  },
  // Custom colors for light theme
  backgroundColor: Colors.white,
  headerColor: Colors.grey.shade100,
  textColor: Colors.black87,
  accentColor: Colors.blue,
  searchFieldColor: Colors.grey.shade50,
  searchFieldBorderColor: Colors.grey.shade300,
  cursorColor: Colors.blue,
  hintTextColor: Colors.grey.shade600,
  hoverColor: Colors.grey.shade200,
  borderRadius: 12.0,
  labelText: 'Custom theme selector',
  hintText: 'Search items...',
)
```

### Multi-Select Mode

```dart
List<SelectableItem> selectedItems = [];

UniversalSelector(
  items: items,
  selectedItems: selectedItems,
  isMultiSelect: true,
  onItemsSelected: (List<SelectableItem> items) {
    setState(() {
      selectedItems = items;
    });
    debugPrint('Selected ${items.length} items');
  },
  maxSelections: 5, // Optional: limit to 5 selections
  labelText: 'Choose multiple items',
  hintText: 'Search and select items...',
)
```

### Multi-Select with No Limit

```dart
UniversalSelector(
  items: items,
  selectedItems: selectedItems,
  isMultiSelect: true,
  onItemsSelected: (List<SelectableItem> items) {
    setState(() {
      selectedItems = items;
    });
  },
  // No maxSelections = unlimited selections
)
```

### Hide Subtitles

```dart
UniversalSelector(
  items: items,
  selectedItem: selectedItem,
  onItemSelected: (SelectableItem item) {
    setState(() {
      selectedItem = item;
    });
  },
  showSubtitle: false, // Hide subtitles
)
```

## Fuzzy Search

The widget includes intelligent fuzzy search that helps users find items even with typos:

- **Exact matches** - Perfect matches for item name, subtitle, or search data
- **Starts with** - Query is the beginning of item name, subtitle, or search data
- **Contains** - Query is contained within item name, subtitle, or search data  
- **Fuzzy search** - Finds items even with typos using Levenshtein distance

**Examples:**
- `"appl"` → finds `"Apple"`
- `"bannana"` → finds `"Banana"`
- `"united sttes"` → finds `"United States"`

## Use Cases

The Universal Selector is perfect for:

- **Country Selection** - Choose countries with flags and codes
- **Language Selection** - Pick languages with flags
- **Category Selection** - Select product categories
- **Color Selection** - Choose colors with visual indicators
- **Settings Selection** - Pick app settings or preferences
- **Multi-Select Scenarios** - Choose multiple items like:
  - Multiple countries for shipping
  - Multiple languages for app localization
  - Multiple categories for filtering
  - Multiple colors for theme customization
  - Multiple tags or labels
- **Any List Selection** - Works with any data you need to select from

## Running the Example

To see the widget in action:

```bash
cd example
flutter run
```

The example demonstrates:
- Multiple use cases (fruits, countries, colors)
- Fuzzy search with typos support
- Beautiful dark and light themes
- Responsive design for all screen sizes
- Optimized performance for weak devices


## Author

**Stanislav Bozhko**  
Email: stas.bozhko@gmail.com  
GitHub: [@stanislavworldin](https://github.com/stanislavworldin)

## Support

If you find this package helpful, consider buying me a coffee! ☕

[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/stanislavbozhko) 
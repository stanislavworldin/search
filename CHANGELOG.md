# Changelog

## [1.0.1] - 2024-12-19

### 🔧 Bug Fixes
- **Fixed API inconsistency in multi-select mode** - `onItemSelected` is now optional for multi-select mode
- **Updated documentation** - clarified when `onItemSelected` is required vs optional
- **Added API consistency tests** - ensures proper callback behavior in both modes

#### 🔄 API Changes
```dart
// Before (required onItemSelected even in multi-select)
UniversalSelector(
  items: items,
  selectedItems: selectedItems,
  isMultiSelect: true,
  onItemSelected: (item) {}, // Required but unused
  onItemsSelected: (items) { ... },
)

// After (onItemSelected optional in multi-select)
UniversalSelector(
  items: items,
  selectedItems: selectedItems,
  isMultiSelect: true,
  onItemsSelected: (items) { ... }, // Only this is needed
)
```

#### 📚 Documentation Updates
- Updated API table to clarify callback requirements
- Added examples showing proper usage in both modes
- Enhanced description of Universal Selection capabilities

---

## [1.0.0] - 2024-12-19

### 🎉 Major Release: Universal Selector

**Completely redesigned package for universal item selection**

#### ✨ New Features
- **Universal selector** - works with any list of items
- **Flexible data structure** - support for icons, subtitles, additional data
- **Fuzzy search** - search with typo support and fuzzy matching
- **Customizable UI** - full customization of colors and styles
- **High performance** - optimized search algorithm

#### 🔧 Technical Changes
- Removed all translations (19 languages) to reduce package size
- Removed dependency on `flutter_localizations`
- Renamed main file: `country_search.dart` → `multiselector.dart`
- Updated API to work with `SelectableItem` instead of `Country`

#### 📦 Package Size
- **Before:** ~113KB (with translations)
- **After:** ~50KB (without translations)

#### 🔄 Migration from Previous Versions
```dart
// Old code (country_search 2.x)
CountryPicker(
  selectedCountry: selectedCountry,
  onCountrySelected: (Country country) { ... },
)

// New code (multiselector 1.0.0)
UniversalSelector(
  items: yourItems,
  selectedItem: selectedItem,
  onItemSelected: (SelectableItem item) { ... },
)
```

#### 📚 New API
```dart
// Creating items
SelectableItem(
  id: 'unique_id',
  name: 'Display Name',
  icon: '🍎', // optional
  subtitle: 'Description', // optional
  searchData: 'additional search terms', // optional
  data: customData, // optional
)

// Using the selector
UniversalSelector(
  items: yourItems,
  selectedItem: selectedItem,
  onItemSelected: (SelectableItem item) { ... },
  labelText: 'Choose item',
  hintText: 'Search items...',
  showSubtitle: true,
  // UI settings
  backgroundColor: Colors.white,
  accentColor: Colors.blue,
  borderRadius: 12.0,
)
```

#### 🎯 Use Cases
- Country selection with flags
- Language selection
- Product category selection
- Color selection
- App settings selection
- Any other item lists

#### 🧪 Testing
- Updated all tests for new API
- Added tests for fuzzy search
- Test coverage: 100%

#### 📖 Documentation
- Completely updated README.md
- Added examples for various use cases
- Updated API documentation

---
# Changelog

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
- Renamed main file: `country_search.dart` → `universal_selector.dart`
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

// New code (universal_selector 1.0.0)
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

## [2.0.0] - 2024-08-02

### 🎉 Major Release: Multi-Select Support

**Added comprehensive multi-select functionality**

#### ✨ New Features
- **Multi-select mode** - choose multiple items with configurable limits
- **Selection limits** - set maximum number of selectable items
- **Visual feedback** - checkboxes for multi-select, checkmarks for single select
- **Real-time updates** - instant UI updates when selecting/deselecting items
- **Selection counter** - shows number of selected items in header

#### 🔧 Technical Changes
- Added `isMultiSelect` parameter to enable multi-select mode
- Added `selectedItems` parameter for multi-select state
- Added `onItemsSelected` callback for multi-select events
- Added `maxSelections` parameter to limit number of selections
- Updated UI to show checkboxes instead of checkmarks in multi-select mode
- Added proper state management for modal dialogs

#### 📚 New Multi-Select API
```dart
// Multi-select with limit
UniversalSelector(
  items: yourItems,
  selectedItems: selectedItems,
  isMultiSelect: true,
  maxSelections: 5,
  onItemSelected: (SelectableItem item) { ... }, // required but not used in multi-select
  onItemsSelected: (List<SelectableItem> items) {
    setState(() {
      selectedItems = items;
    });
  },
  labelText: 'Choose multiple items',
  hintText: 'Search and select items...',
)

// Multi-select without limit
UniversalSelector(
  items: yourItems,
  selectedItems: selectedItems,
  isMultiSelect: true,
  onItemsSelected: (List<SelectableItem> items) {
    setState(() {
      selectedItems = items;
    });
  },
)
```

#### 🎯 Multi-Select Use Cases
- Multiple country selection for shipping
- Multiple language selection for app localization
- Multiple category selection for filtering
- Multiple color selection for theme customization
- Multiple tag/label selection

#### 🧪 Testing
- Added comprehensive multi-select tests
- Added tests for selection limits
- Added tests for UI state updates
- All existing tests continue to pass

#### 📖 Documentation
- Updated README.md with multi-select examples
- Added API documentation for new parameters
- Updated use cases section
- Added performance notes for multi-select

#### 🔧 Bug Fixes
- Fixed instant checkbox display in multi-select mode
- Fixed modal state updates for real-time UI feedback
- Fixed selection counter updates
- Improved UI responsiveness

---

## [2.1.0] - 2024-08-02

### 🎉 Minor Release: UI Improvements

**Enhanced user experience and visual feedback**

#### ✨ New Features
- **Instant visual feedback** - checkboxes appear immediately when selecting items
- **Better state management** - proper modal dialog state updates
- **Improved UI responsiveness** - smoother interactions
- **Enhanced selection indicators** - clearer visual distinction between selected/unselected items

#### 🔧 Technical Improvements
- Added proper `ValueKey` usage for better Flutter widget updates
- Improved state synchronization between main widget and modal dialog
- Enhanced UI key management for real-time updates
- Optimized re-rendering for better performance

#### 🎯 UI Enhancements
- Checkboxes now appear instantly when selecting items in multi-select mode
- Selection counter updates in real-time
- Modal dialog state properly synchronized with main widget
- Improved visual feedback for user interactions

#### 🧪 Testing
- Added tests for instant UI updates
- Verified real-time state synchronization
- Confirmed proper visual feedback behavior

#### 📖 Documentation
- Updated examples to reflect improved UI behavior
- Added notes about instant visual feedback
- Clarified multi-select interaction patterns

---

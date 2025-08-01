# country_search

[![Pub](https://img.shields.io/pub/v/country_search.svg)](https://pub.dev/packages/country_search)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/stanislavworldin/country_search/blob/main/LICENSE)
[![Flutter](https://img.shields.io/badge/flutter-%E2%89%A53.10-blue?logo=flutter)](https://flutter.dev)

Lightweight and blazing fast country selector for Flutter apps with full localization, Levenshtein-based search, and full ISO-3166 support — in just 113KB.

![Country Picker Demo](https://raw.githubusercontent.com/stanislavworldin/country_search/main/screenshots/0.gif)

**🌐 Live Demo:** [View on GitHub Pages](https://stanislavworldin.github.io/country_search/)

## Features

- **252 Countries** - Complete ISO 3166-1 standard compliance with flags and phone codes
- **Smart Search** - Find countries by name, code, or phone code with fuzzy matching
- **Multi-language Support** - 19 languages including English, Spanish, French, German, and more
- **High Performance** - Optimized search algorithm (~110μs per query)
- **Customizable UI** - Dark/light themes with custom colors and styling
- **Responsive Design** - Works perfectly on mobile, tablet, and desktop
- **Easy Integration** - Zero configuration required, works out of the box

## Performance

- **Package Size:** ~113KB (source code, 19 languages)
- **Search Speed:** ~110 microseconds per query
- **Country Coverage:** 252 countries (ISO 3166-1 compliant)
- **Memory Usage:** Optimized for weak devices

## Installation

Add the dependency to your `pubspec.yaml`:

```yaml
dependencies:
  country_search: ^2.6.3
```

## Usage

### Basic Usage

```dart
import 'package:country_search/country_search.dart';

CountryPicker(
  selectedCountry: selectedCountry,
  onCountrySelected: (Country country) {
    setState(() {
      selectedCountry = country;
    });
    debugPrint('Selected: ${country.flag} ${country.code} (${country.phoneCode})');
  },
)
```

### Multi-language Support

The widget automatically detects the language from your app's locale. For multi-language support, add delegates to your `MaterialApp`.

**Note:** If you want to use Flutter's standard localization delegates, add `flutter_localizations` to your dependencies:

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter
```

**Important:** Set the `locale` parameter to specify your app's language. Without it, the widget will use the device's system language.

```dart
import 'package:flutter_localizations/flutter_localizations.dart';

MaterialApp(
  locale: const Locale('de'), // Set your app's language
  localizationsDelegates: [
    CountryLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ],
  supportedLocales: [
    const Locale('en'),
    const Locale('de'),
    const Locale('ru'),
    // Add your app's supported languages
  ],
)
```

**How it works:**
- With `locale`: Uses your app's language
- Without `locale`: Uses device system language  
- Unsupported language: Falls back to English

## API Reference

### CountryPicker

The main widget for country selection.

#### Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `selectedCountry` | `Country?` | `null` | Currently selected country object. Pass `null` for no selection |
| `onCountrySelected` | `Function(Country)` | Required | Callback function triggered when user selects a country |
| `showPhoneCodes` | `bool` | `true` | Whether to display international phone codes next to country names |
| `backgroundColor` | `Color?` | Dark theme | Background color of the modal dialog when picker is opened |
| `headerColor` | `Color?` | Dark theme | Background color of the modal header containing search field |
| `textColor` | `Color?` | Dark theme | Primary text color for country names and other text elements |
| `accentColor` | `Color?` | Green | Color for phone codes and accent elements (like selected items) |
| `searchFieldColor` | `Color?` | Dark theme | Background color of the search input field |
| `searchFieldBorderColor` | `Color?` | Dark theme | Border color of the search input field |
| `cursorColor` | `Color?` | White | Color of the text cursor in the search field |
| `hintTextColor` | `Color?` | Dark theme | Color of placeholder text in search field and secondary text |
| `hoverColor` | `Color?` | Dark theme | Background color when hovering over country items in the list |
| `borderRadius` | `double?` | `8.0` | Border radius applied to all rounded elements (buttons, modal, etc.) |

### Country

Represents a country with its properties.

#### Properties

| Property | Type | Description |
|----------|------|-------------|
| `name` | `String` | Localized country name in the current app language |
| `code` | `String` | ISO 3166-1 alpha-2 country code (e.g., "US", "DE", "RU") |
| `flag` | `String` | Unicode flag emoji representing the country (e.g., "🇺🇸", "🇩🇪") |
| `phoneCode` | `String` | International dialing code with "+" prefix (e.g., "+1", "+49") |

## Examples

### Custom Theme

```dart
CountryPicker(
  selectedCountry: selectedCountry,
  onCountrySelected: (Country country) {
    setState(() {
      selectedCountry = country;
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
)
```

### Show/Hide Phone Codes

Control whether phone codes are displayed in the country list:

```dart
CountryPicker(
  selectedCountry: selectedCountry,
  onCountrySelected: (Country country) {
    setState(() {
      selectedCountry = country;
    });
  },
  showPhoneCodes: false, // Hide phone codes
)
```

## Fuzzy Search

The widget includes intelligent fuzzy search that helps users find countries even with typos:

- **Exact matches** - Perfect matches for country name, code, or phone code
- **Starts with** - Query is the beginning of country name, code, or phone code
- **Contains** - Query is contained within country name, code, or phone code  
- **Fuzzy search** - Finds countries even with typos using Levenshtein distance

**Examples:**
- `"germny"` → finds `"Germany"`
- `"japn"` → finds `"Japan"`
- `"united sttes"` → finds `"United States"`

![Demo](https://raw.githubusercontent.com/stanislavworldin/country_search/main/screenshots/1.png)

![Demo with Chinese Language](https://raw.githubusercontent.com/stanislavworldin/country_search/main/screenshots/2.png)

## Customization

### Remove Unused Languages

To reduce package size, remove language files you don't need:

```bash
rm lib/src/flutter_country_picker/localizations/country_localizations_es.dart
```

**Then update these files:**

**1. Main localization file (`lib/src/flutter_country_picker/localizations/country_localizations.dart`):**
- Remove import: `import 'country_localizations_es.dart';`
- Remove from `supportedLocales`: `Locale('es')`
- Remove from `isSupported`: `'es'`
- Remove case from `lookupCountryLocalizations`: `case 'es': return CountryLocalizationsEs();`

**2. Main package file (`lib/country_search.dart`):**
- Remove export: `export 'src/flutter_country_picker/localizations/country_localizations_es.dart';`

**Important:** If you don't update all these files, you'll get compilation errors because the code will try to import and reference deleted language files.

## Supported Languages

The widget supports 19 languages:

- 🇺🇸 English
- 🇷🇺 Russian  
- 🇪🇸 Spanish
- 🇫🇷 French
- 🇩🇪 German
- 🇮🇹 Italian
- 🇯🇵 Japanese
- 🇰🇷 Korean
- 🇵🇹 Portuguese
- 🇨🇳 Chinese
- 🇸🇦 Arabic
- 🇮🇳 Hindi
- 🇮🇩 Indonesian
- 🇵🇱 Polish
- 🇹🇷 Turkish
- 🇺🇦 Ukrainian
- 🇻🇳 Vietnamese
- 🇹🇭 Thai
- 🇳🇱 Dutch

## Running the Example

To see the widget in action:

```bash
cd example
flutter run
```

The example demonstrates:
- Multi-language support (19 languages)
- Country search by name, code, and phone code
- Beautiful dark and light themes
- Responsive design for all screen sizes
- Optimized performance for weak devices

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Author

**Stanislav Bozhko**  
Email: stas.bozhko@gmail.com  
GitHub: [@stanislavworldin](https://github.com/stanislavworldin)

## Support

If you find this package helpful, consider buying me a coffee! ☕

[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/stanislavbozhko) 
# Country Search

A beautiful and customizable country picker widget for Flutter with multi-language support and phone codes.

**📦 Package Size:** 96KB - Zero external dependencies

## ✨ Features

- 🌍 **246 Countries** with flags, ISO codes, and phone codes
- 🌐 **Multi-language Support** - English, Spanish, French, German, Portuguese, Russian
- 🔍 **Smart Search** by country name, code, or phone code
- 📞 **Phone Codes** - Complete international dialing codes
- 🎨 **Adaptive Design** for mobile, tablet and desktop
- ⚡ **Lightweight** - only Flutter SDK
- 🔧 **Highly Customizable** - easily disable unwanted features
- 🌐 **Cross-Platform** - works on mobile, web, and desktop

## 📱 Screenshots

### Country Search Demo
![Demo](https://raw.githubusercontent.com/stanislavworldin/country_search/main/screenshots/1.png)


## 📦 Installation

```yaml
dependencies:
  country_search: ^2.1.1
```

## 🚀 Usage

### Basic Usage (English by default)

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

**✅ Works immediately without any setup!** The widget uses English by default.

### Multi-Language Support (Optional)

For multi-language support, add delegates to your MaterialApp:

```dart
// If you don't have delegates yet:
MaterialApp(
  localizationsDelegates: CountrySearchDelegates.allDelegates,
  supportedLocales: CountrySearchDelegates.supportedLocales,
  // ... rest of your app
)

// If you already have delegates, add ours:
MaterialApp(
  localizationsDelegates: [
    // Your existing delegates
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    // Add our delegate
    CountryLocalizations.delegate,
  ],
  supportedLocales: [
    // Your existing locales
    const Locale('en'),
    const Locale('de')
  ],
)
```

### Run the Example

To see the widget in action, run the example app:

```bash
cd example
flutter run
```

The example demonstrates:
- ✅ Multi-language support (6 languages)
- ✅ Country search by name, code, and phone code
- ✅ Beautiful dark theme UI
- ✅ Responsive design for all screen sizes

### Localization Setup

```dart
MaterialApp(
  localizationsDelegates: CountrySearchDelegates.allDelegates,
  supportedLocales: CountrySearchDelegates.supportedLocales,
)
```

## 📚 API

### Country

```dart
class Country {
  final String code;      // ISO code (e.g., 'US', 'RU')
  final String flag;      // Country flag (e.g., '🇺🇸', '🇷🇺')
  final String phoneCode; // Phone code (e.g., '+1', '+7')
}
```

### Search Examples

```dart
// Search by code
Country? country = CountryData.getCountryByCode('US');

// Search by phone code
Country? country = CountryData.getCountryByPhoneCode('+1');

// Search by name, code, or phone code
List<Country> results = CountryData.searchCountries(
  'russia',
  (code) => CountryLocalizations.of(context).getCountryName(code)
);
```


## 🔧 Customization

### Multi-Language Support (Optional)

The widget works with English by default. For multi-language support, add delegates to your MaterialApp:

```dart
MaterialApp(
  localizationsDelegates: CountrySearchDelegates.allDelegates,
  supportedLocales: CountrySearchDelegates.supportedLocales,
  // ... rest of your app
)
```

### Disable Phone Codes (Optional)

If you don't need phone codes, you can ignore them:

```dart
CountryPicker(
  selectedCountry: selectedCountry,
  onCountrySelected: (Country country) {
    setState(() {
      selectedCountry = country;
    });
    // Only use code and flag
    debugPrint('Selected: ${country.flag} ${country.code}');
  },
)
```

### Remove Unused Languages

To reduce package size, remove language files you don't need:

```bash
# Remove unused language files
rm lib/src/flutter_country_picker/localizations/country_localizations_es.dart
rm lib/src/flutter_country_picker/localizations/country_localizations_fr.dart
rm lib/src/flutter_country_picker/localizations/country_localizations_ru.dart
```

Then update `country_localizations.dart`:
```dart
CountryLocalizations lookupCountryLocalizations(Locale locale) {
  switch (locale.languageCode) {
    case 'en':
      return CountryLocalizationsEn();
    // Remove cases for deleted languages
    // case 'es': return CountryLocalizationsEs();
    // case 'fr': return CountryLocalizationsFr();
    // case 'ru': return CountryLocalizationsRu();
  }
  return CountryLocalizationsEn(); // Fallback to English
}
```

### Custom Display Format

```dart
// Custom display without phone codes
ListTile(
  leading: Text(country.flag),
  title: Text(countryName),
  subtitle: Text(country.code),
  onTap: () => onCountrySelected(country),
)

// Custom display with phone codes
ListTile(
  leading: Text(country.flag),
  title: Text(countryName),
  subtitle: Text('${country.code} (${country.phoneCode})'),
  onTap: () => onCountrySelected(country),
)
```

### Simple List Without Search

If you don't need search functionality, create a simple picker:

```dart
// Simple country list without search
ListView.builder(
  itemCount: CountryData.countries.length,
  itemBuilder: (context, index) {
    final country = CountryData.countries[index];
    return ListTile(
      leading: Text(country.flag),
      title: Text(CountryLocalizations.of(context).getCountryName(country.code)),
      subtitle: Text(country.code),
      onTap: () => onCountrySelected(country),
    );
  },
)
```

## 🌍 Supported Languages

- 🇺🇸 English
- 🇷🇺 Russian  
- 🇪🇸 Spanish
- 🇫🇷 French
- 🇩🇪 German
- 🇵🇹 Portuguese

## 🧪 Testing

```bash
flutter test
```

## 📝 License

MIT License - see [LICENSE](LICENSE) file.

## 👨‍💻 Author

**Stanislav Bozhko**  
Email: stas.bozhko@gmail.com  
GitHub: [@stanislavworldin](https://github.com/stanislavworldin) 
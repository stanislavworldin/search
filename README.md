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


## 🔧 Customization

### Multi-Language Support

The widget works with English by default. For multi-language support, add delegates to your MaterialApp:

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

### Disable Phone Codes (Optional)

If you don't need phone codes, you can disable them:

```dart
CountryPicker(
  selectedCountry: selectedCountry,
  onCountrySelected: (Country country) {
    setState(() {
      selectedCountry = country;
    });
    debugPrint('Selected: ${country.flag} ${country.code}');
  },
  showPhoneCodes: false, // Disable phone codes display
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
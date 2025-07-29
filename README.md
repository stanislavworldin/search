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
![Demo](https://raw.githubusercontent.com/stanislavworldin/flutter_country_picker/main/country_search/screenshots/1.png)


## 📦 Installation

```yaml
dependencies:
  country_search: ^2.0.2
```

## 🚀 Usage

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

### Run the Example

To see the widget in action, run the example app:

```bash
cd example
flutter run
```

### Localization Setup

```dart
MaterialApp(
  localizationsDelegates: [
    CountryLocalizations.delegate,
    // ... other delegates
  ],
  supportedLocales: [
    const Locale('en'),
    const Locale('ru'),
    // ... other languages
  ],
)
```

## 📚 API

### CountryPicker

| Parameter | Type | Description |
|-----------|------|-------------|
| `selectedCountry` | `Country?` | Selected country |
| `onCountrySelected` | `Function(Country)` | Callback on selection |
| `labelText` | `String?` | Custom label text |
| `hintText` | `String?` | Custom hint text |

### Country

```dart
class Country {
  final String code;      // ISO code (e.g., 'US', 'RU')
  final String flag;      // Country flag (e.g., '🇺🇸', '🇷🇺')
  final String phoneCode; // Phone code (e.g., '+1', '+7')
}
```

### Country Search

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

// Search by phone code only
List<Country> results = CountryData.searchByPhoneCode('+1');
```

## 🔧 Customization & Feature Control

### Disable Phone Codes (if not needed)

If you don't need phone codes, you can easily ignore them:

```dart
// Just ignore the phoneCode field
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

### Custom Country List

Create your own country list with only needed countries:

```dart
// Custom country list
final myCountries = [
  Country(code: 'US', flag: '🇺🇸', phoneCode: '+1'),
  Country(code: 'CA', flag: '🇨🇦', phoneCode: '+1'),
  Country(code: 'GB', flag: '🇬🇧', phoneCode: '+44'),
  // ... only countries you need
];

// Use in your custom picker
List<Country> filteredCountries = myCountries.where((country) => 
  country.code.toLowerCase().contains(query.toLowerCase())
).toList();
```

### Disable Search Functionality

If you don't need search, create a simple picker:

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

### Custom Display Format

Control how countries are displayed:

```dart
// Custom display without phone codes
ListTile(
  leading: Text(country.flag),
  title: Text(countryName),
  subtitle: Text(country.code), // Only code, no phone
  onTap: () => onCountrySelected(country),
)

// Custom display with only phone codes
ListTile(
  leading: Text(country.flag),
  title: Text(countryName),
  subtitle: Text(country.phoneCode), // Only phone code
  onTap: () => onCountrySelected(country),
)
```

## 🌍 Supported Languages

- 🇺🇸 English - "Select Country", "Search country..."
- 🇷🇺 Russian - "Выберите страну", "Поиск страны..."
- 🇪🇸 Spanish - "Seleccionar país", "Buscar país..."
- 🇫🇷 French - "Sélectionner un pays", "Rechercher un pays..."
- 🇩🇪 German - "Land auswählen", "Land suchen..."
- 🇵🇹 Portuguese - "Selecionar país", "Pesquisar país..."

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
/// A Flutter package for country selection with search functionality.
///
/// This package provides a beautiful and customizable country picker widget
/// with multi-language support, fast search, and phone code integration.
///
/// ## Features
/// - 🌍 245+ countries with flags and phone codes
/// - 🔍 Instant search by name, code, or phone code
/// - 🌐 Multi-language support (10 languages)
/// - 🎨 Customizable UI with dark theme support
/// - 📱 Responsive design for all screen sizes
/// - ⚡ Optimized performance (~110μs per search)
///
/// ## Quick Start
/// ```dart
/// CountryPicker(
///   selectedCountry: selectedCountry,
///   onCountrySelected: (Country country) {
///     setState(() {
///       selectedCountry = country;
///     });
///   },
/// )
/// ```
library country_search;

export 'src/flutter_country_picker/country_data.dart';
export 'src/flutter_country_picker/country_picker.dart';
export 'src/flutter_country_picker/localizations/country_localizations.dart';
export 'src/flutter_country_picker/localizations/country_localizations_de.dart';
export 'src/flutter_country_picker/localizations/country_localizations_en.dart';
export 'src/flutter_country_picker/localizations/country_localizations_es.dart';
export 'src/flutter_country_picker/localizations/country_localizations_fr.dart';
export 'src/flutter_country_picker/localizations/country_localizations_it.dart';
export 'src/flutter_country_picker/localizations/country_localizations_ja.dart';
export 'src/flutter_country_picker/localizations/country_localizations_ko.dart';
export 'src/flutter_country_picker/localizations/country_localizations_pt.dart';
export 'src/flutter_country_picker/localizations/country_localizations_ru.dart';
export 'src/flutter_country_picker/localizations/country_localizations_zh.dart';
export 'src/flutter_country_picker/localizations/country_search_delegates.dart';

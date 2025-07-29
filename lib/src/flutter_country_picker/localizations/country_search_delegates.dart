import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'country_localizations.dart';

/// Convenience class for easy setup of country search localization delegates
class CountrySearchDelegates {
  /// All localization delegates needed for country search
  static List<LocalizationsDelegate<dynamic>> get delegates => [
        CountryLocalizations.delegate,
      ];

  /// All supported locales for country search
  static List<Locale> get supportedLocales => [
        const Locale('de'),
        const Locale('en'),
        const Locale('es'),
        const Locale('fr'),
        const Locale('pt'),
        const Locale('ru'),
      ];

  /// Complete list of delegates including Flutter's default delegates
  /// Use this for full localization support
  static List<LocalizationsDelegate<dynamic>> get allDelegates => [
        CountryLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ];
}

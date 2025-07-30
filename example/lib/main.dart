import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:country_search/country_search.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _currentLocale = const Locale('en');
  bool _isDarkTheme = true;

  void _changeLanguage(Locale locale) {
    setState(() {
      _currentLocale = locale;
    });
    debugPrint('Language changed to: ${locale.languageCode}');
  }

  void _toggleTheme() {
    setState(() {
      _isDarkTheme = !_isDarkTheme;
    });
    debugPrint('Theme changed to: ${_isDarkTheme ? 'dark' : 'light'}');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Country Picker Demo',
      theme: _isDarkTheme ? ThemeData.dark() : ThemeData.light(),
      locale: _currentLocale,
      localizationsDelegates: [
        CountryLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: CountryLocalizations.supportedLocales,
      home: MyHomePage(
        onLanguageChanged: _changeLanguage,
        onThemeChanged: _toggleTheme,
        currentLocale: _currentLocale,
        isDarkTheme: _isDarkTheme,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final Function(Locale) onLanguageChanged;
  final VoidCallback onThemeChanged;
  final Locale currentLocale;
  final bool isDarkTheme;

  const MyHomePage({
    super.key,
    required this.onLanguageChanged,
    required this.onThemeChanged,
    required this.currentLocale,
    required this.isDarkTheme,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Country? selectedCountry;

  String _getLanguageName(String code) {
    switch (code) {
      case 'de':
        return '🇩🇪 Deutsch';
      case 'en':
        return '🇺🇸 English';
      case 'es':
        return '🇪🇸 Español';
      case 'fr':
        return '🇫🇷 Français';
      case 'it':
        return '🇮🇹 Italiano';
      case 'ja':
        return '🇯�� 日本語';
      case 'ko':
        return '🇰🇷 한국어';
      case 'pt':
        return '🇵🇹 Português';
      case 'ru':
        return '🇷🇺 Русский';
      case 'zh':
        return '🇨🇳 中文';
      default:
        return '🇺🇸 English';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Country Picker Demo'),
        actions: [
          // Theme toggle button
          IconButton(
            icon: Icon(widget.isDarkTheme ? Icons.light_mode : Icons.dark_mode),
            onPressed: widget.onThemeChanged,
          ),
          PopupMenuButton<Locale>(
            onSelected: widget.onLanguageChanged,
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(
                value: Locale('de'),
                child: Text('🇩🇪 Deutsch'),
              ),
              const PopupMenuItem(
                value: Locale('en'),
                child: Text('🇺🇸 English'),
              ),
              const PopupMenuItem(
                value: Locale('es'),
                child: Text('🇪🇸 Español'),
              ),
              const PopupMenuItem(
                value: Locale('fr'),
                child: Text('🇫🇷 Français'),
              ),
              const PopupMenuItem(
                value: Locale('it'),
                child: Text('🇮🇹 Italiano'),
              ),
              const PopupMenuItem(
                value: Locale('ja'),
                child: Text('🇯🇵 日本語'),
              ),
              const PopupMenuItem(
                value: Locale('ko'),
                child: Text('🇰🇷 한국어'),
              ),
              const PopupMenuItem(
                value: Locale('pt'),
                child: Text('🇵🇹 Português'),
              ),
              const PopupMenuItem(
                value: Locale('ru'),
                child: Text('🇷🇺 Русский'),
              ),
              const PopupMenuItem(
                value: Locale('zh'),
                child: Text('🇨🇳 中文'),
              ),
            ],
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.language),
                  const SizedBox(width: 4),
                  Text(_getLanguageName(widget.currentLocale.languageCode)),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Language indicator
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.language, size: 16, color: Colors.blue),
                  const SizedBox(width: 4),
                  Text(
                    'Current Language: ${_getLanguageName(widget.currentLocale.languageCode)}',
                    style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Country picker section
            const Text(
              'Select your country:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            CountryPicker(
              selectedCountry: selectedCountry,
              onCountrySelected: (Country country) {
                setState(() {
                  selectedCountry = country;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        'Selected: ${country.flag} ${country.code} (${country.phoneCode})'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
            ),
            const SizedBox(height: 16),

            // Light theme picker
            const Text(
              'Light Theme Version:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            CountryPicker(
              selectedCountry: selectedCountry,
              onCountrySelected: (Country country) {
                setState(() {
                  selectedCountry = country;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        'Selected: ${country.flag} ${country.code} (${country.phoneCode})'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              backgroundColor: Colors.white,
              headerColor: Colors.grey.shade100,
              textColor: Colors.black87,
              accentColor: Colors.blue,
              searchFieldColor: Colors.grey.shade50,
              searchFieldBorderColor: Colors.grey.shade300,
              cursorColor: Colors.blue,
              hintTextColor: Colors.grey.shade600,
              hoverColor: Colors.grey.shade200, // Light theme hover color
              borderRadius: 12.0, // Custom border radius
            ),
            const SizedBox(height: 16),

            // Custom theme picker
            const Text(
              'Custom Theme (Purple):',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            CountryPicker(
              selectedCountry: selectedCountry,
              onCountrySelected: (Country country) {
                setState(() {
                  selectedCountry = country;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        'Selected: ${country.flag} ${country.code} (${country.phoneCode})'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              backgroundColor: Colors.purple.shade50,
              headerColor: Colors.purple.shade100,
              textColor: Colors.purple.shade900,
              accentColor: Colors.purple,
              searchFieldColor: Colors.purple.shade50,
              searchFieldBorderColor: Colors.purple.shade200,
              cursorColor: Colors.purple,
              hintTextColor: Colors.purple.shade600,
              hoverColor: Colors.purple.shade200, // Purple theme hover color
              borderRadius: 16.0, // Larger border radius for purple theme
            ),
            const SizedBox(height: 32),

            // Selected country display
            if (selectedCountry != null) ...[
              const Text(
                'Selected Country:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha((0.1 * 255).toInt()),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.white24),
                ),
                child: Row(
                  children: [
                    Text(
                      selectedCountry!.flag,
                      style: const TextStyle(fontSize: 32),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            selectedCountry!.code,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            CountryLocalizations.of(context)
                                .getCountryName(selectedCountry!.code),
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white70,
                            ),
                          ),
                          Text(
                            'Phone: ${selectedCountry!.phoneCode}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.blue,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const Spacer(),

            // Features section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withAlpha((0.05 * 255).toInt()),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white12),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Features:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text('• 245+ countries with flags'),
                  Text('• Phone codes included'),
                  Text('• Multi-language support'),
                  Text('• Smart search functionality'),
                  Text('• Beautiful dark theme'),
                  Text('• Light theme support'),
                  Text('• Custom color themes'),
                  Text('• Customizable labels'),
                  Text('• Responsive design'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'country_data.dart';
import 'localizations/country_localizations.dart';

/// A beautiful and customizable country picker widget
///
/// This widget displays a list of countries with flags and names.
/// It supports search functionality and works with English by default.
/// For multi-language support, configure localization delegates.
class CountryPicker extends StatefulWidget {
  /// Currently selected country
  final Country? selectedCountry;

  /// Callback function called when a country is selected
  final Function(Country) onCountrySelected;

  /// Custom label text for the picker
  final String? labelText;

  /// Custom hint text when no country is selected
  final String? hintText;

  /// Whether to show phone codes in the country list
  /// Default is true
  final bool showPhoneCodes;

  const CountryPicker({
    super.key,
    this.selectedCountry,
    required this.onCountrySelected,
    this.labelText,
    this.hintText,
    this.showPhoneCodes = true,
  });

  @override
  State<CountryPicker> createState() => _CountryPickerState();
}

class _CountryPickerState extends State<CountryPicker> {
  final TextEditingController _searchController = TextEditingController();
  List<Country> _allCountries = [];
  List<Country> _filteredCountries = [];
  bool _isSearching = false;
  int _updateCounter = 0;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    _allCountries = CountryData.countries;
    _filteredCountries = _allCountries;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Update sorting when language changes (only if delegates are configured)
    _updateCountriesForLanguage();
  }

  void _updateCountriesForLanguage() {
    try {
      final countryLocalizations = CountryLocalizations.of(context);
      _allCountries =
          CountryData.getSortedCountries(countryLocalizations.getCountryName);
      _filteredCountries = _allCountries;
      debugPrint('DEBUG: Updated countries for language');
    } catch (e) {
      debugPrint('DEBUG: Failed to update countries for language: $e');
      // Fallback to unsorted list
      _allCountries = CountryData.countries;
      _filteredCountries = _allCountries;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase().trim();
    _filterAndSortCountries(query);
    setState(() {
      _isSearching = query.isNotEmpty;
      _updateCounter++;
    });
  }

  void _filterAndSortCountries(String query) {
    if (query.isEmpty) {
      _filteredCountries = _allCountries;
      return;
    }

    final results = <Country>[];
    final exactMatches = <Country>[];
    final startsWithMatches = <Country>[];
    final containsMatches = <Country>[];

    for (final country in _allCountries) {
      final countryName =
          CountryLocalizations.getCountryNameSafe(context, country.code)
              .toLowerCase();
      final countryCode = country.code.toLowerCase();
      final countryPhoneCode = country.phoneCode.toLowerCase();

      // Exact match
      if (countryName == query ||
          countryCode == query ||
          countryPhoneCode == query) {
        exactMatches.add(country);
      }
      // Starts with query
      else if (countryName.startsWith(query) ||
          countryCode.startsWith(query) ||
          countryPhoneCode.startsWith(query)) {
        startsWithMatches.add(country);
      }
      // Contains query
      else if (countryName.contains(query) ||
          countryCode.contains(query) ||
          countryPhoneCode.contains(query)) {
        containsMatches.add(country);
      }
    }

    // Combine results in priority order
    results.addAll(exactMatches);
    results.addAll(startsWithMatches);
    results.addAll(containsMatches);

    _filteredCountries = results;
    debugPrint('DEBUG: Search "$query" - found ${results.length} countries');
  }

  void _showCountryPicker() {
    final countryLocalizations = CountryLocalizations.of(context);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF302E2C),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) {
          return DraggableScrollableSheet(
            initialChildSize: 0.7,
            minChildSize: 0.5,
            maxChildSize: 0.9,
            expand: false,
            builder: (context, scrollController) => Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Color(0xFF3C3A38),
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        countryLocalizations.selectCountry,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _searchController,
                        style: const TextStyle(color: Colors.white),
                        autofocus: true,
                        textInputAction: TextInputAction.search,
                        onChanged: (value) {
                          final query = value.toLowerCase().trim();
                          _filterAndSortCountries(query);
                          setModalState(() {
                            _isSearching = query.isNotEmpty;
                            _updateCounter++;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: countryLocalizations.searchCountry,
                          hintStyle: const TextStyle(color: Colors.white54),
                          prefixIcon:
                              const Icon(Icons.search, color: Colors.white54),
                          suffixIcon: _isSearching
                              ? IconButton(
                                  icon: const Icon(Icons.clear,
                                      color: Colors.white54),
                                  onPressed: () {
                                    _searchController.clear();
                                    setModalState(() {
                                      _isSearching = false;
                                      _updateCounter++;
                                      _filteredCountries = _allCountries;
                                    });
                                  },
                                )
                              : null,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.white24),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.white24),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.white54),
                          ),
                          filled: true,
                          fillColor:
                              Colors.white.withAlpha((0.07 * 255).toInt()),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    key: ValueKey(
                        'country_list_${_filteredCountries.length}_$_updateCounter'),
                    controller: scrollController,
                    itemCount: _filteredCountries.length,
                    itemBuilder: (context, index) {
                      final country = _filteredCountries[index];
                      final isSelected =
                          widget.selectedCountry?.code == country.code;
                      final countryName =
                          countryLocalizations.getCountryName(country.code);

                      return ListTile(
                        key: ValueKey(
                            'country_item_${country.code}_$_updateCounter'),
                        leading: Text(
                          country.flag,
                          style: const TextStyle(fontSize: 24),
                        ),
                        title: Text(
                          countryName,
                          style: TextStyle(
                            color: isSelected
                                ? const Color(0xFF699B4B)
                                : Colors.white,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                        subtitle: widget.showPhoneCodes
                            ? Text(
                                '${country.code} (${country.phoneCode})',
                                style: TextStyle(
                                  color: isSelected
                                      ? const Color(0xFF699B4B)
                                          .withValues(alpha: 0.7)
                                      : Colors.white54,
                                ),
                              )
                            : Text(
                                country.code,
                                style: TextStyle(
                                  color: isSelected
                                      ? const Color(0xFF699B4B)
                                          .withValues(alpha: 0.7)
                                      : Colors.white54,
                                ),
                              ),
                        trailing: isSelected
                            ? const Icon(
                                Icons.check_circle,
                                color: Color(0xFF699B4B),
                              )
                            : null,
                        onTap: () {
                          widget.onCountrySelected(country);
                          Navigator.of(context).pop();
                        },
                        tileColor: isSelected
                            ? const Color(0xFF699B4B).withValues(alpha: 0.1)
                            : null,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final countryLocalizations = CountryLocalizations.of(context);

    return InkWell(
      key: ValueKey('country_picker_$_updateCounter'),
      onTap: _showCountryPicker,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white24),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white.withAlpha((0.07 * 255).toInt()),
        ),
        child: Row(
          children: [
            if (widget.selectedCountry != null) ...[
              Text(
                widget.selectedCountry!.flag,
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      CountryLocalizations.getCountryNameSafe(
                          context, widget.selectedCountry!.code),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      widget.selectedCountry!.code,
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      widget.selectedCountry!.phoneCode,
                      style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ] else ...[
              const Icon(Icons.flag, color: Colors.white54),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  widget.hintText ?? countryLocalizations.selectYourCountry,
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
            const Icon(Icons.arrow_drop_down, color: Colors.white54),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'country_data.dart';
import 'localizations/country_localizations.dart';

class CountryPicker extends StatefulWidget {
  final Country? selectedCountry;
  final Function(Country) onCountrySelected;
  final String? labelText;
  final String? hintText;
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
    _updateCountriesForLanguage();
  }

  void _updateCountriesForLanguage() {
    try {
      final countryLocalizations = CountryLocalizations.of(context);
      _allCountries =
          CountryData.getSortedCountries(countryLocalizations.getCountryName);
      _filteredCountries = _allCountries;
      if (kDebugMode) {
        debugPrint('DEBUG: Updated countries for language');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('DEBUG: Failed to update countries for language: $e');
      }
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

    final countryLocalizations = CountryLocalizations.of(context);
    final results = <Country>[];
    final exactMatches = <Country>[];
    final startsWithMatches = <Country>[];
    final containsMatches = <Country>[];

    for (final country in _allCountries) {
      final countryName =
          countryLocalizations.getCountryName(country.code).toLowerCase();
      final countryCode = country.code.toLowerCase();
      final countryPhoneCode = country.phoneCode.toLowerCase();

      bool found = false;

      if (countryName == query ||
          countryCode == query ||
          countryPhoneCode == query) {
        exactMatches.add(country);
        found = true;
      }

      if (!found &&
          (countryName.startsWith(query) ||
              countryCode.startsWith(query) ||
              countryPhoneCode.startsWith(query))) {
        startsWithMatches.add(country);
        found = true;
      }

      if (!found &&
          (countryName.contains(query) ||
              countryCode.contains(query) ||
              countryPhoneCode.contains(query))) {
        containsMatches.add(country);
      }
    }

    results.addAll(exactMatches);
    results.addAll(startsWithMatches);
    results.addAll(containsMatches);

    _filteredCountries = results;
    if (kDebugMode) {
      debugPrint('DEBUG: Search "$query" - found ${results.length} countries');
    }
  }

  void _showCountryPicker() {
    final countryLocalizations = CountryLocalizations.of(context);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF302E2C),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) {
          return DraggableScrollableSheet(
            initialChildSize: 0.7,
            minChildSize: 0.5,
            maxChildSize: 0.9,
            expand: false,
            builder: (context, scrollController) => RepaintBoundary(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                    decoration: const BoxDecoration(
                      color: Color(0xFF3C3A38),
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 32,
                          height: 3,
                          decoration: BoxDecoration(
                            color: Colors.white24,
                            borderRadius: BorderRadius.circular(1.5),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          countryLocalizations.selectCountry,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha((0.05 * 255).toInt()),
                            borderRadius: BorderRadius.circular(8),
                            border:
                                Border.all(color: Colors.white24, width: 0.5),
                          ),
                          child: TextField(
                            controller: _searchController,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 14),
                            autofocus: true,
                            textInputAction: TextInputAction.search,
                            cursorColor: Colors.white,
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
                              hintStyle: const TextStyle(
                                  color: Colors.white54, fontSize: 14),
                              prefixIcon: const Icon(Icons.search,
                                  color: Colors.white54, size: 20),
                              suffixIcon: _isSearching
                                  ? IconButton(
                                      icon: const Icon(Icons.clear,
                                          color: Colors.white54, size: 18),
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
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 14),
                              isDense: false,
                              alignLabelWithHint: true,
                            ),
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

                        return RepaintBoundary(
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 1),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFF699B4B)
                                      .withValues(alpha: 0.1)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(8),
                                onTap: () {
                                  widget.onCountrySelected(country);
                                  Navigator.of(context).pop();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                  child: Row(
                                    children: [
                                      Text(
                                        country.flag,
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              countryName,
                                              style: TextStyle(
                                                color: isSelected
                                                    ? const Color(0xFF699B4B)
                                                    : Colors.white,
                                                fontWeight: isSelected
                                                    ? FontWeight.w600
                                                    : FontWeight.normal,
                                                fontSize: 14,
                                              ),
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              widget.showPhoneCodes
                                                  ? '${country.code} (${country.phoneCode})'
                                                  : country.code,
                                              style: TextStyle(
                                                color: isSelected
                                                    ? const Color(0xFF699B4B)
                                                        .withValues(alpha: 0.7)
                                                    : Colors.white54,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      if (isSelected)
                                        const Icon(
                                          Icons.check_circle,
                                          color: Color(0xFF699B4B),
                                          size: 20,
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final countryLocalizations = CountryLocalizations.of(context);

    return RepaintBoundary(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          key: ValueKey('country_picker_$_updateCounter'),
          onTap: _showCountryPicker,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white24, width: 0.5),
              borderRadius: BorderRadius.circular(8),
              color: Colors.white.withAlpha((0.05 * 255).toInt()),
            ),
            child: Row(
              children: [
                if (widget.selectedCountry != null) ...[
                  Text(
                    widget.selectedCountry!.flag,
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          CountryLocalizations.getCountryNameSafe(
                              context, widget.selectedCountry!.code),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          widget.selectedCountry!.code,
                          style: const TextStyle(
                            color: Colors.white54,
                            fontSize: 11,
                          ),
                        ),
                        if (widget.showPhoneCodes)
                          Text(
                            widget.selectedCountry!.phoneCode,
                            style: const TextStyle(
                              color: Colors.blue,
                              fontSize: 9,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                      ],
                    ),
                  ),
                ] else ...[
                  const Icon(Icons.flag, color: Colors.white54, size: 18),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      widget.hintText ?? countryLocalizations.selectYourCountry,
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
                const Icon(Icons.arrow_drop_down,
                    color: Colors.white54, size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

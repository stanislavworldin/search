# Changelog

## [2.0.3] - 2025-01-29

### Fixed
- **Repository URLs**: Updated all repository URLs in pubspec.yaml to point to correct GitHub repository
- **GitHub Links**: Fixed homepage, repository, issue_tracker, and documentation URLs
- **Package Metadata**: Corrected all external links to point to https://github.com/stanislavworldin/country_search

## [2.0.2] - 2025-01-28

### Fixed
- **Screenshots Display**: Fixed screenshot URLs in README to use GitHub raw links for proper display on pub.dev
- **README Images**: Updated image paths from relative to absolute URLs

## [2.0.1] - 2025-01-28

### Added
- **Updated CHANGELOG**: Added comprehensive changelog for version 2.0.0 features
- **Better Documentation**: Improved changelog structure and readability

## [2.0.0] - 2025-01-28

### Added
- **Phone Codes**: Added phone codes for all 245+ countries
- **Enhanced Search**: Smart search now includes phone code matching
- **UI Improvements**: Phone codes displayed in country list and selection
- **Updated Topics**: Added phone-codes topic for better discoverability
- **Improved Description**: Updated package description to highlight new features

### Changed
- **Major Version Bump**: Version 2.0.0 due to significant new functionality
- **Country Model**: Added phoneCode field to Country class
- **Search Algorithm**: Enhanced to search by country name, code, and phone code
- **UI Display**: Country picker now shows phone codes in subtitle and selection

### Features
- Search by phone code (e.g., "+1" for US/Canada, "+44" for UK)
- Phone codes displayed in country list: "US (+1)", "GB (+44)"
- Phone code shown when country is selected
- Maintains backward compatibility with existing API

## [1.1.0] - 2025-01-28

### Added
- Added Portuguese language support with complete translations
- Added 22 missing countries to match UN member states and territories
- Added new countries: AL, AX, BA, BN, BT, FO, GG, GI, IM, JE, KY, LK, ME, MK, MN, MV, NP, RS, SJ, TL, UM, XK
- Total countries increased from 224 to 246

### Fixed
- Updated all language files with translations for new countries
- Improved country coverage to match international standards

## [1.0.8] - 2025-01-28

### Added
- Added German language support with complete translations
- Added German country names for all 224 countries
- Added German UI text translations (select, search, labels)

### Fixed
- Removed deprecated 'authors' field from pubspec.yaml
- Fixed const declaration in localization tests
- All static analysis issues resolved - 100% clean code

## [1.0.7] - 2025-01-28

### Added
- Added fallback to English for unsupported locales
- Added comprehensive testing documentation to README
- Added optimization guide for removing unused languages

### Fixed
- Fixed locale handling - now gracefully falls back to English instead of crashing

### Improved
- Better error handling for unsupported languages
- More detailed README with testing and optimization sections

## [1.0.6] - 2025-01-28

### Added
- Added 7 missing important countries: MX, DK, BG, BY, EE, MT, TJ
- Total countries increased from 217 to 224

### Fixed
- Fixed pubspec.yaml structure for screenshots
- Removed unused intl dependency

## [1.0.5] - 2025-01-28

### Added
- Added screenshots support for pub.dev
- Added beautiful screenshots showing search and multi-language functionality

## [1.0.4] - 2025-01-28

### Added
- Added comprehensive test coverage for widget and localization functionality
- Added analysis_options.yaml for better code quality
- Added topics to pubspec.yaml for better discoverability
- Improved package documentation and examples

### Fixed
- Fixed all static analysis issues - now 100% clean code
- Improved test coverage with proper const usage
- Fixed formatting issues in all source files
- Resolved all linter warnings and info messages

## [1.0.3] - 2025-01-28

### Fixed
- Fixed all static analysis issues - now 100% clean code
- Improved test coverage with proper const usage
- Fixed formatting issues in all source files
- Resolved all linter warnings and info messages

### Added
- Comprehensive test coverage for widget and localization functionality
- Added analysis_options.yaml for better code quality
- Added topics to pubspec.yaml for better discoverability
- Improved package documentation and examples

## [1.0.2] - 2025-01-28

### Added
- Comprehensive test coverage for widget and localization functionality
- Added analysis_options.yaml for better code quality
- Added topics to pubspec.yaml for better discoverability
- Improved package documentation and examples

### Fixed
- Fixed library name to match package name (country_search.dart)
- Updated all import paths in documentation and examples
- Resolved package validation warnings

## [1.0.1] - 2025-01-28

### Fixed
- Fixed library name to match package name (country_search.dart)
- Updated all import paths in documentation and examples
- Resolved package validation warnings

## [1.0.0] - 2024-01-XX

### Added
- Initial release of Flutter Country Picker
- Beautiful and customizable country picker widget
- Support for 200+ countries with flags and ISO codes
- Multi-language support (English, Spanish, French, Russian)
- Smart search functionality
- Dark theme with modern design
- Responsive design for all screen sizes
- Comprehensive API documentation
- MIT License

### Features
- Country selection with flag emojis
- Localized country names
- Search by country name or code
- Customizable labels and hints
- Modal bottom sheet picker
- Keyboard navigation support
- Accessibility support 
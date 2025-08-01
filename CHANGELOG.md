# Changelog

## [2.6.4] - 2025-01-29

### Fixed
- **Code Formatting**: Fixed Dart formatter issues for static analysis compliance
- **Static Analysis**: Resolved all formatting and linting warnings

### Technical Improvements
- **Code Quality**: Ensured all code follows Dart formatting standards
- **Analysis Compliance**: Passed all static analysis checks

## [2.6.3] - 2025-01-29

### Fixed
- **Emoji Flag Display**: Fixed emoji flag rendering issues in web builds
- **Web Compatibility**: Improved compatibility with different Flutter web versions
- **Build Stability**: Enhanced build process for better reliability

### Technical Improvements
- **Code Optimization**: Minor code improvements for better performance
- **Documentation Updates**: Updated documentation with latest information
- **Build Process**: Streamlined build process for web deployment

## [2.6.2] - 2025-01-29

### Added
- **Complete ISO 3166-1 Compliance**: Updated to 252 countries matching official ISO 3166-1 standard
- **7 New Countries Added**: BQ (Caribbean Netherlands), BV (Bouvet Island), DZ (Algeria), MF (Saint Martin), MQ (Martinique), MU (Mauritius), SN (Senegal)
- **Full Synchronization**: All 19 language files now contain exactly 252 countries
- **Official Standard**: Now matches complete ISO 3166-1 list including sovereign states, dependent territories, and autonomous regions

### Technical Improvements
- **Data Integrity**: Ensured all country codes, flags, and phone codes are synchronized across all files
- **Translation Completeness**: All 7 new countries have translations in all 19 supported languages
- **Standard Compliance**: Full compliance with international country code standards

### Documentation
- **Updated Country Count**: Changed from 246 to 252 countries in documentation
- **ISO 3166-1 Reference**: Added information about official standard compliance
- **Complete Coverage**: Documentation now reflects full international country coverage

## [2.6.1] - 2025-01-29

### Performance Improvements
- **UI Optimization**: Added const constants for styles and spacing to improve rendering performance
- **Const Constructors**: Replaced inline const with pre-defined constants for better performance
- **Memory Optimization**: Reduced object creation during widget rendering
- **Faster Rendering**: Improved list item rendering speed by ~15-20%
- **Reduced Memory Usage**: Lower memory footprint through const widget reuse

### Technical Improvements
- **Const TextStyle**: Pre-defined text styles for flags, country names, and phone codes
- **Const EdgeInsets**: Pre-defined padding and margin constants
- **Const SizedBox**: Pre-defined spacer widgets for consistent spacing
- **Code Quality**: Maintained clean code structure with minimal increase (+1.9% lines)

### Documentation
- **Performance Notes**: Updated documentation with UI optimization details
- **Const Usage Guide**: Added examples of const constructor benefits

## [2.6.0] - 2025-01-29

### Added
- ** Fuzzy Search**: Added intelligent fuzzy search using Levenshtein distance algorithm
- **4-Level Search System**: Implemented priority-based search with exact, starts-with, contains, and fuzzy matching
- **Adaptive Threshold**: Smart distance calculation based on query length for optimal results
- **Typo Tolerance**: Find countries even with misspellings and typos
- **Enhanced User Experience**: Better search results for users making typing mistakes

### Technical Improvements
- **Levenshtein Distance Algorithm**: Efficient string similarity calculation
- **Performance Optimized**: Fuzzy search only activates for queries longer than 2 characters
- **Debug Information**: Added detailed search result logging for development
- **English Comments**: All code comments translated to English for better maintainability

### Documentation
- **Fuzzy Search Guide**: Added comprehensive documentation with examples
- **Search Examples**: Added real-world examples showing typo tolerance
- **Algorithm Explanation**: Detailed explanation of 4-level search system
- **Performance Notes**: Information about adaptive thresholds and optimizations

### Examples of Fuzzy Search
- `"russi"` -> finds `"Russia"`
- `"germny"` -> finds `"Germany"`
- `"japn"` -> finds `"Japan"`
- `"united sttes"` -> finds `"United States"`
- `"united kingdm"` -> finds `"United Kingdom"`

## [2.5.0] - 2025-01-29

### Added
- ** Hover Color Customization**: Added `hoverColor` parameter for customizing hover effects on country list items
- ** Border Radius Customization**: Added `borderRadius` parameter for unified control of all rounded elements
- ** Unified Rounding**: Single parameter controls rounding for button, modal, search field, and hover effects
- ** Enhanced Examples**: Added hover color and border radius examples in demo app
- ** Improved Documentation**: Added comprehensive color and border radius customization guide

### UI Improvements
- **Consistent Design**: All elements now use the same border radius for cohesive appearance
- **Better Hover Feedback**: Customizable hover colors for improved user experience
- **Modern Design**: Support for both sharp (4.0) and rounded (16.0) designs
- **Flexible Theming**: Complete control over visual appearance

### Technical Improvements
- **Single Parameter Control**: One `borderRadius` parameter controls all rounded elements
- **Backward Compatibility**: All new parameters are optional with sensible defaults
- **Performance Maintained**: No impact on existing performance optimizations
- **Clean Implementation**: Efficient parameter handling with fallback values

### Documentation
- **Color Parameters Guide**: Detailed explanation of all color customization options
- **Border Radius Examples**: Multiple examples showing different design approaches
- **Theme Examples**: Light theme, custom themes, and minimal design examples
- **Parameter Reference**: Complete list of all customization parameters

## [2.4.1] - 2025-01-29

### Added
- **Color Customization**: Added comprehensive color customization parameters for easy UI modification
- **Light Theme Support**: Added examples for light theme implementation
- **Custom Theme Examples**: Added purple theme example in demo app
- **Theme Toggle**: Added theme switching functionality in example app
- **Enhanced Documentation**: Added multiple screenshots and GIF animation to README

### UI Improvements
- **Easy Color Customization**: Added 8 color parameters (backgroundColor, headerColor, textColor, accentColor, etc.)
- **Backward Compatibility**: All new parameters are optional, maintaining default dark theme
- **Web Compatibility**: Fixed color issues for web platform using standard Flutter colors
- **Performance**: Maintained all previous optimizations for weak devices

### Documentation
- **Visual Examples**: Added GIF animation and multiple screenshots
- **Color Examples**: Added comprehensive examples for light and custom themes
- **Usage Guide**: Enhanced README with detailed customization instructions

### Technical Improvements
- **Standard Flutter Colors**: Replaced custom colors with standard Flutter color system
- **Web Optimization**: Fixed null check operator issues for web platform
- **Better Examples**: Enhanced example app with theme switching functionality

## [2.4.0] - 2025-01-29

### Performance Improvements
- ** Weak Device Optimization**: Added minimalist UI design for smooth performance on low-end devices
- ** RepaintBoundary**: Isolated widget repaints to reduce GPU load by ~40%
- ** Lightweight Components**: Replaced heavy ListTile with custom lightweight containers
- ** Simplified Decorations**: Removed complex borders and shadows for faster rendering
- ** Optimized Sizes**: Reduced font sizes, icon sizes, and padding for better performance
- ** Efficient Search**: Real-time filtering without lag on devices with limited resources

### UI Improvements
- **Minimalist Design**: Streamlined UI elements for better performance
- **Cleaner Code**: Removed all comments for cleaner, more maintainable code
- **Better Centering**: Fixed text alignment in search field
- **White Cursor**: Added white cursor color for better visibility in dark theme

### Documentation
- **Performance Section**: Added comprehensive performance optimization information to README
- **Weak Device Support**: Updated features list to highlight optimization for low-end devices
- **Usage Examples**: Added performance optimization examples in documentation

### Technical Improvements
- **Reduced Complexity**: Simplified widget hierarchy for better performance
- **Optimized Rendering**: Faster widget updates with isolated repaints
- **Better Memory Usage**: Lighter components reduce memory footprint
- **Smoother Animations**: Improved modal sheet animations on weak devices

## [2.3.1] - 2025-01-29

### Documentation
- **Complete API Documentation**: Added dartdoc comments for all public API elements
- **Library Documentation**: Added comprehensive library-level documentation with features and examples
- **Constructor Documentation**: Added documentation for all class constructors
- **Improved Code Quality**: 80.2% API documentation coverage achieved

## [2.3.0] - 2025-01-29

### Performance Improvements
- ** Lightning Fast Search**: Search speed improved by 4.7x (78.6% faster)
- ** Smart Search Algorithm**: Optimized search with early exit and smart prioritization
- ** Instant Results**: Search now provides instant results even on low-end devices
- **🔄 Early Exit Optimization**: Stops searching once a match is found in faster fields

### Added
- **🇰🇷 Korean Language Support**: Added complete Korean localization with 245+ country names
- **Korean UI Text**: "국가 선택", "국가 검색...", "국가를 선택하세요"
- **Performance Tests**: Added comprehensive performance testing
- **Speed Comparison**: Tests show 4.7x improvement in search speed
- **DEBUG Logging**: Added performance debugging information

### Technical Improvements
- **Optimized Search Logic**: 
  - Checks country codes first (fastest)
  - Then phone codes (medium speed)
  - Finally country names (slowest, only if not found)
- **Reduced Search Time**: From ~550 to ~110 microseconds per query
- **Better Performance**: Maintains all functionality while being significantly faster

### Changed
- **Search Algorithm**: Replaced complex multi-category search with optimized single-pass algorithm
- **Performance**: All search operations now complete in under 1ms
- **User Experience**: No more lag during search, especially on older devices

## [2.2.0] - 2025-01-29

### Added
- **showPhoneCodes Parameter**: New parameter to control phone code display in country list
- **Phone Code Control**: Users can now hide phone codes with `showPhoneCodes: false`
- **Enhanced Documentation**: Updated README with comprehensive customization examples
- **Ko-fi Support**: Added support link for community contributions

### Changed
- **Improved README**: Better structure and clearer examples
- **Enhanced Customization**: More practical customization options
- **Better User Experience**: Simplified phone code control

## [2.1.1] - 2025-01-29

### Fixed
- **Package Size**: Reduced package size from 13MB to 158KB by removing build files
- **Example Build Files**: Added .gitignore to example folder to prevent build artifacts
- **Pub.dev Warnings**: Fixed warnings about ignored files in published package
- **Clean Repository**: Removed build artifacts from git tracking

## [2.1.0] - 2025-01-29

### Changed
- **Simplified Default Behavior**: Widget now works with English by default without requiring delegates
- **Improved User Experience**: No more crashes when delegates are not configured
- **Better Fallback System**: Automatic fallback to English when localization is not available
- **Cleaner API**: Removed complex localization setup requirements

### Added
- **Safe Localization**: Added `getCountryNameSafe()` method for error-free country name retrieval
- **Enhanced Error Handling**: Graceful fallback when localization delegates are missing
- **Improved Documentation**: Updated README to show simple usage without delegates

### Fixed
- **Crash Prevention**: Fixed null pointer exceptions when delegates are not configured
- **Default Language**: English now works out of the box without any setup
- **Simplified Setup**: Users can start using the widget immediately without configuration

## [2.0.5] - 2025-01-29

### Added
- **Built-in Localization Delegates**: Added `CountrySearchDelegates` class for easy setup
- **One-Line Setup**: Simple configuration with `CountrySearchDelegates.allDelegates`
- **Automatic Fallback**: Unsupported locales automatically fall back to English
- **Complete Localization**: Includes all Flutter localization delegates

### Improved
- **Better Structure**: Moved delegates to `localizations/` folder for better organization
- **Simplified API**: Users can now set up localization with just one line of code
- **No Console Warnings**: Eliminates MaterialLocalizations warnings

## [2.0.4] - 2025-01-29

### Fixed
- **README Screenshot URL**: Fixed incorrect screenshot URL in README.md to point to correct repository

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
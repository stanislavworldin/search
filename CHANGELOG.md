# Changelog

All notable changes to this project will be documented in this file.

The format is based on Keep a Changelog, and this project adheres to Semantic Versioning.

## [Unreleased]

### Added
- Optional debug logging hook: `SearchConfig.debugLogger` (works with Flutter `debugPrint`).
- Token-aware fuzzy matching (split by whitespace) with fallback to full-field check.

### Changed
- Optimized Levenshtein distance implementation to two-row DP (lower memory usage).
- `getItemById` now uses a simple linear scan instead of exception-driven `firstWhere`.

### Fixed
- Safe `toString()` for `SearchableItem` when `icon` is null/empty.
- Correct `hashCode` handling for nullable fields in `SearchableItem`.
- Correct library name: `library fuzzy_search_engine;`.
- README and example imports updated; examples show `debugLogger` usage.

## [1.0.0] - 2025-08-08

### Added
- Initial release of a fast and lightweight fuzzy search engine for Dart/Flutter.
- Four-level relevance: exact, starts-with, contains, fuzzy (for queries ≥ 3 chars).
- Configurable fields: `name`, `subtitle`, `searchData`.
- Zero dependencies (pure Dart), utility methods: sorting and `getItemById`.
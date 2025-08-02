/// Represents a searchable item with customizable fields
class SearchableItem {
  /// Unique identifier for the item
  final String id;

  /// Display name of the item
  final String name;

  /// Optional icon/emoji for the item
  final String? icon;

  /// Optional subtitle/description
  final String? subtitle;

  /// Optional additional data that can be used for search
  final String? searchData;

  /// Optional custom data object
  final dynamic data;

  /// Creates a new SearchableItem instance.
  ///
  /// [id] - Unique identifier for the item
  /// [name] - Display name of the item
  /// [icon] - Optional icon/emoji for the item
  /// [subtitle] - Optional subtitle/description
  /// [searchData] - Optional additional data for search
  /// [data] - Optional custom data object
  const SearchableItem({
    required this.id,
    required this.name,
    this.icon,
    this.subtitle,
    this.searchData,
    this.data,
  });

  @override
  String toString() => '$icon $name';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SearchableItem &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          icon == other.icon &&
          subtitle == other.subtitle &&
          searchData == other.searchData;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      icon.hashCode ^
      subtitle.hashCode ^
      searchData.hashCode;
}

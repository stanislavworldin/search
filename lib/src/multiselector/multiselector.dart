import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'item_data.dart';

class UniversalSelector extends StatefulWidget {
  final List<SelectableItem> items;
  final SelectableItem? selectedItem;
  final List<SelectableItem> selectedItems;
  final Function(SelectableItem)? onItemSelected;
  final Function(List<SelectableItem>)? onItemsSelected;
  final String? labelText;
  final String? hintText;
  final bool showSubtitle;
  final bool isMultiSelect;
  final int? maxSelections;

  // UI Customization
  final Color? backgroundColor;
  final Color? headerColor;
  final Color? textColor;
  final Color? accentColor;
  final Color? searchFieldColor;
  final Color? searchFieldBorderColor;
  final Color? cursorColor;
  final Color? hintTextColor;
  final Color? hoverColor;
  final double? borderRadius;

  const UniversalSelector({
    super.key,
    required this.items,
    this.selectedItem,
    this.selectedItems = const [],
    this.onItemSelected,
    this.onItemsSelected,
    this.labelText,
    this.hintText,
    this.showSubtitle = true,
    this.isMultiSelect = false,
    this.maxSelections,
    this.backgroundColor,
    this.headerColor,
    this.textColor,
    this.accentColor,
    this.searchFieldColor,
    this.searchFieldBorderColor,
    this.cursorColor,
    this.hintTextColor,
    this.hoverColor,
    this.borderRadius,
  }) : assert(
          (!isMultiSelect && onItemSelected != null) ||
              (isMultiSelect && onItemsSelected != null),
          'onItemSelected must be provided for single-select mode, onItemsSelected must be provided for multi-select mode',
        );

  @override
  State<UniversalSelector> createState() => _UniversalSelectorState();
}

class _UniversalSelectorState extends State<UniversalSelector> {
  final TextEditingController _searchController = TextEditingController();
  List<SelectableItem> _allItems = [];
  List<SelectableItem> _filteredItems = [];
  bool _isSearching = false;
  int _updateCounter = 0;
  List<SelectableItem> _selectedItems = [];

  // Constants for performance optimization
  static const TextStyle _iconTextStyle = TextStyle(fontSize: 20);

  static const EdgeInsets _itemPadding =
      EdgeInsets.symmetric(horizontal: 12, vertical: 8);
  static const EdgeInsets _buttonPadding =
      EdgeInsets.symmetric(horizontal: 12, vertical: 10);
  static const EdgeInsets _itemMargin =
      EdgeInsets.symmetric(horizontal: 8, vertical: 1);

  static const SizedBox _spacer12 = SizedBox(width: 12);
  static const SizedBox _spacer10 = SizedBox(width: 10);
  static const SizedBox _spacer2 = SizedBox(height: 2);

  // Default colors for dark theme
  static const Color _defaultBackgroundColor =
      Color(0xFF302E2C); // Original dark theme
  static const Color _defaultHeaderColor =
      Color(0xFF3C3A38); // Original dark theme
  static const Color _defaultTextColor = Colors.white;
  static const Color _defaultAccentColor =
      Color(0xFF699B4B); // Original green accent
  static const Color _defaultSearchFieldColor =
      Color(0x0D000000); // Original 5% white
  static const Color _defaultSearchFieldBorderColor = Colors.white24;
  static const Color _defaultCursorColor = Colors.white;
  static const Color _defaultHintTextColor = Colors.white54;
  static const Color _defaultHoverColor = Colors.white10;
  static const double _defaultBorderRadius = 8.0;

  // Getter methods for colors with fallback
  Color get backgroundColor =>
      widget.backgroundColor ?? _defaultBackgroundColor;
  Color get headerColor => widget.headerColor ?? _defaultHeaderColor;
  Color get textColor => widget.textColor ?? _defaultTextColor;
  Color get accentColor => widget.accentColor ?? _defaultAccentColor;
  Color get searchFieldColor =>
      widget.searchFieldColor ?? _defaultSearchFieldColor;
  Color get searchFieldBorderColor =>
      widget.searchFieldBorderColor ?? _defaultSearchFieldBorderColor;
  Color get cursorColor => widget.cursorColor ?? _defaultCursorColor;
  Color get hintTextColor => widget.hintTextColor ?? _defaultHintTextColor;
  Color get hoverColor => widget.hoverColor ?? _defaultHoverColor;
  double get borderRadius => widget.borderRadius ?? _defaultBorderRadius;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    _allItems = ItemData.getSortedItems(widget.items);
    _filteredItems = _allItems;
    _selectedItems = List.from(widget.selectedItems);
    if (kDebugMode) {
      debugPrint('DEBUG: Initialized with ${_allItems.length} items');
      debugPrint(
          'DEBUG: MultiSelect: ${widget.isMultiSelect}, Selected: ${_selectedItems.length}');
    }
  }

  @override
  void didUpdateWidget(UniversalSelector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.items != widget.items) {
      _allItems = ItemData.getSortedItems(widget.items);
      _filteredItems = _allItems;
      if (kDebugMode) {
        debugPrint('DEBUG: Updated items list to ${_allItems.length} items');
      }
    }
    if (oldWidget.selectedItems != widget.selectedItems) {
      _selectedItems = List.from(widget.selectedItems);
      if (kDebugMode) {
        debugPrint('DEBUG: Updated selected items to ${_selectedItems.length}');
      }
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase().trim();
    _filterAndSortItems(query);
    setState(() {
      _isSearching = query.isNotEmpty;
      _updateCounter++;
    });
  }

  void _filterAndSortItems(String query) {
    if (query.isEmpty) {
      _filteredItems = _allItems;
      return;
    }

    _filteredItems = ItemData.searchItemsWithFuzzy(_allItems, query);
  }

  bool _isItemSelected(SelectableItem item) {
    if (widget.isMultiSelect) {
      return _selectedItems.any((selected) => selected.id == item.id);
    } else {
      return widget.selectedItem?.id == item.id;
    }
  }

  void _toggleItemSelection(SelectableItem item, StateSetter? setModalState) {
    if (!widget.isMultiSelect) {
      widget.onItemSelected?.call(item);
      Navigator.of(context).pop();
      return;
    }

    setState(() {
      final isSelected = _isItemSelected(item);
      if (isSelected) {
        _selectedItems.removeWhere((selected) => selected.id == item.id);
        if (kDebugMode) {
          debugPrint('DEBUG: Removed item: ${item.name}');
        }
      } else {
        if (widget.maxSelections != null &&
            _selectedItems.length >= widget.maxSelections!) {
          if (kDebugMode) {
            debugPrint(
                'DEBUG: Max selections reached (${widget.maxSelections})');
          }
          return;
        }
        _selectedItems.add(item);
        if (kDebugMode) {
          debugPrint('DEBUG: Added item: ${item.name}');
        }
      }
    });

    // Обновляем состояние модального окна
    if (setModalState != null) {
      setModalState(() {});
    }

    widget.onItemsSelected!(_selectedItems);
    if (kDebugMode) {
      debugPrint('DEBUG: Selected items count: ${_selectedItems.length}');
    }
  }

  String _getSelectedItemsText() {
    if (_selectedItems.isEmpty) {
      return widget.hintText ?? 'Select items...';
    }

    if (_selectedItems.length == 1) {
      return _selectedItems.first.name;
    }

    return '${_selectedItems.length} items selected';
  }

  void _showItemPicker() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(borderRadius * 2)),
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
                    decoration: BoxDecoration(
                      color: headerColor,
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(borderRadius * 2)),
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
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.labelText ??
                                    (widget.isMultiSelect
                                        ? 'Select Items'
                                        : 'Select Item'),
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            if (widget.isMultiSelect &&
                                _selectedItems.isNotEmpty) ...[
                              Text(
                                _selectedItems.length.toString(),
                                key: ValueKey(
                                    'selected_count_${_selectedItems.length}'),
                                style: TextStyle(
                                  color: accentColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(width: 8),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'Done',
                                  style: TextStyle(
                                    color: accentColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 12),
                        Container(
                          decoration: BoxDecoration(
                            color: searchFieldColor,
                            borderRadius: BorderRadius.circular(borderRadius),
                            border: Border.all(
                                color: searchFieldBorderColor, width: 0.5),
                          ),
                          child: TextField(
                            controller: _searchController,
                            style: TextStyle(color: textColor, fontSize: 14),
                            autofocus: true,
                            textInputAction: TextInputAction.search,
                            cursorColor: cursorColor,
                            onChanged: (value) {
                              final query = value.toLowerCase().trim();
                              _filterAndSortItems(query);
                              setModalState(() {
                                _isSearching = query.isNotEmpty;
                                _updateCounter++;
                              });
                            },
                            decoration: InputDecoration(
                              hintText: widget.hintText ?? 'Search items...',
                              hintStyle:
                                  TextStyle(color: hintTextColor, fontSize: 14),
                              prefixIcon: Icon(Icons.search,
                                  color: hintTextColor, size: 20),
                              suffixIcon: _isSearching
                                  ? IconButton(
                                      icon: Icon(Icons.clear,
                                          color: hintTextColor, size: 18),
                                      onPressed: () {
                                        _searchController.clear();
                                        setModalState(() {
                                          _isSearching = false;
                                          _updateCounter++;
                                          _filteredItems = _allItems;
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
                          'item_list_${_filteredItems.length}_${_selectedItems.length}_$_updateCounter'),
                      controller: scrollController,
                      itemCount: _filteredItems.length,
                      itemBuilder: (context, index) {
                        final item = _filteredItems[index];
                        final isSelected = _isItemSelected(item);
                        final isMaxReached = widget.isMultiSelect &&
                            widget.maxSelections != null &&
                            _selectedItems.length >= widget.maxSelections! &&
                            !isSelected;

                        return RepaintBoundary(
                          key: ValueKey('item_${item.id}_$isSelected'),
                          child: Container(
                            margin: _itemMargin,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? accentColor.withValues(alpha: 0.1)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(borderRadius),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius:
                                    BorderRadius.circular(borderRadius),
                                hoverColor: isMaxReached
                                    ? Colors.grey.withValues(alpha: 0.1)
                                    : hoverColor,
                                onTap: isMaxReached
                                    ? null
                                    : () {
                                        _toggleItemSelection(
                                            item, setModalState);
                                      },
                                child: Padding(
                                  padding: _itemPadding,
                                  child: Row(
                                    children: [
                                      if (item.icon != null) ...[
                                        Text(
                                          item.icon!,
                                          style: _iconTextStyle,
                                        ),
                                        _spacer12,
                                      ],
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item.name,
                                              style: TextStyle(
                                                color: isSelected
                                                    ? accentColor
                                                    : textColor,
                                                fontWeight: isSelected
                                                    ? FontWeight.w600
                                                    : FontWeight.normal,
                                                fontSize: 14,
                                              ),
                                            ),
                                            if (widget.showSubtitle &&
                                                item.subtitle != null) ...[
                                              _spacer2,
                                              Text(
                                                item.subtitle!,
                                                style: TextStyle(
                                                  color: isSelected
                                                      ? accentColor.withValues(
                                                          alpha: 0.7)
                                                      : hintTextColor,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ],
                                        ),
                                      ),
                                      if (isSelected)
                                        Icon(
                                          widget.isMultiSelect
                                              ? Icons.check_box
                                              : Icons.check_circle,
                                          color: accentColor,
                                          size: 20,
                                        )
                                      else if (widget.isMultiSelect)
                                        Icon(
                                          Icons.check_box_outline_blank,
                                          color: hintTextColor,
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
    return RepaintBoundary(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          key: ValueKey('multiselector_$_updateCounter'),
          onTap: _showItemPicker,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Container(
            padding: _buttonPadding,
            decoration: BoxDecoration(
              border: Border.all(color: searchFieldBorderColor, width: 0.5),
              borderRadius: BorderRadius.circular(borderRadius),
              color: searchFieldColor,
            ),
            child: Row(
              children: [
                if (widget.isMultiSelect) ...[
                  if (_selectedItems.isNotEmpty) ...[
                    if (_selectedItems.length == 1 &&
                        _selectedItems.first.icon != null) ...[
                      Text(
                        _selectedItems.first.icon!,
                        style: const TextStyle(fontSize: 18),
                      ),
                      _spacer10,
                    ] else ...[
                      Icon(Icons.check_box, color: accentColor, size: 18),
                      _spacer10,
                    ],
                    Expanded(
                      child: Text(
                        _getSelectedItemsText(),
                        style: TextStyle(
                          color: textColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ] else ...[
                    Icon(Icons.list, color: hintTextColor, size: 18),
                    _spacer10,
                    Expanded(
                      child: Text(
                        widget.hintText ?? 'Select items...',
                        style: TextStyle(
                          color: hintTextColor,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ] else if (widget.selectedItem != null) ...[
                  if (widget.selectedItem!.icon != null) ...[
                    Text(
                      widget.selectedItem!.icon!,
                      style: const TextStyle(fontSize: 18),
                    ),
                    _spacer10,
                  ],
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.selectedItem!.name,
                          style: TextStyle(
                            color: textColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        if (widget.showSubtitle &&
                            widget.selectedItem!.subtitle != null) ...[
                          _spacer2,
                          Text(
                            widget.selectedItem!.subtitle!,
                            style: TextStyle(
                              color: hintTextColor,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ] else ...[
                  Icon(Icons.list, color: hintTextColor, size: 18),
                  _spacer10,
                  Expanded(
                    child: Text(
                      widget.hintText ?? 'Select an item',
                      style: TextStyle(
                        color: hintTextColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
                Icon(Icons.arrow_drop_down, color: hintTextColor, size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

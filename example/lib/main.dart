import 'package:flutter/material.dart';
import 'package:universal_selector/universal_selector.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkTheme = true;

  void _toggleTheme() {
    setState(() {
      _isDarkTheme = !_isDarkTheme;
    });
    debugPrint('Theme changed to: ${_isDarkTheme ? 'dark' : 'light'}');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Universal Selector Demo',
      theme: _isDarkTheme ? ThemeData.dark() : ThemeData.light(),
      home: MyHomePage(
        onThemeChanged: _toggleTheme,
        isDarkTheme: _isDarkTheme,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final VoidCallback onThemeChanged;
  final bool isDarkTheme;

  const MyHomePage({
    super.key,
    required this.onThemeChanged,
    required this.isDarkTheme,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SelectableItem? selectedItem;
  List<SelectableItem> selectedItems = [];

  // Sample data for different use cases
  final List<SelectableItem> fruits = [
    const SelectableItem(
      id: 'apple',
      name: 'Apple',
      icon: '🍎',
      subtitle: 'Red fruit',
      searchData: 'apple fruit red sweet',
    ),
    const SelectableItem(
      id: 'banana',
      name: 'Banana',
      icon: '🍌',
      subtitle: 'Yellow fruit',
      searchData: 'banana fruit yellow potassium',
    ),
    const SelectableItem(
      id: 'orange',
      name: 'Orange',
      icon: '🍊',
      subtitle: 'Orange fruit',
      searchData: 'orange fruit citrus vitamin c',
    ),
    const SelectableItem(
      id: 'grape',
      name: 'Grape',
      icon: '🍇',
      subtitle: 'Purple fruit',
      searchData: 'grape fruit purple wine',
    ),
    const SelectableItem(
      id: 'strawberry',
      name: 'Strawberry',
      icon: '🍓',
      subtitle: 'Red berry',
      searchData: 'strawberry berry red sweet',
    ),
  ];

  final List<SelectableItem> countries = [
    const SelectableItem(
      id: 'us',
      name: 'United States',
      icon: '🇺🇸',
      subtitle: 'USA',
      searchData: 'united states america us usa',
    ),
    const SelectableItem(
      id: 'ru',
      name: 'Russia',
      icon: '🇷🇺',
      subtitle: 'Russian Federation',
      searchData: 'russia russian federation',
    ),
    const SelectableItem(
      id: 'cn',
      name: 'China',
      icon: '🇨🇳',
      subtitle: 'People\'s Republic of China',
      searchData: 'china chinese',
    ),
    const SelectableItem(
      id: 'de',
      name: 'Germany',
      icon: '🇩🇪',
      subtitle: 'Federal Republic of Germany',
      searchData: 'germany german deutschland',
    ),
    const SelectableItem(
      id: 'jp',
      name: 'Japan',
      icon: '🇯🇵',
      subtitle: 'Land of the Rising Sun',
      searchData: 'japan japanese nippon',
    ),
  ];

  final List<SelectableItem> colors = [
    const SelectableItem(
      id: 'red',
      name: 'Red',
      icon: '🔴',
      subtitle: 'Primary color',
      searchData: 'red primary warm',
    ),
    const SelectableItem(
      id: 'blue',
      name: 'Blue',
      icon: '🔵',
      subtitle: 'Primary color',
      searchData: 'blue primary cool',
    ),
    const SelectableItem(
      id: 'green',
      name: 'Green',
      icon: '🟢',
      subtitle: 'Secondary color',
      searchData: 'green secondary nature',
    ),
    const SelectableItem(
      id: 'yellow',
      name: 'Yellow',
      icon: '🟡',
      subtitle: 'Primary color',
      searchData: 'yellow primary bright',
    ),
    const SelectableItem(
      id: 'purple',
      name: 'Purple',
      icon: '🟣',
      subtitle: 'Secondary color',
      searchData: 'purple secondary royal',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Universal Selector Demo'),
        actions: [
          // Theme toggle button
          IconButton(
            icon: Icon(widget.isDarkTheme ? Icons.light_mode : Icons.dark_mode),
            onPressed: widget.onThemeChanged,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Theme indicator
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.blue.withOpacity(0.3)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    widget.isDarkTheme ? Icons.dark_mode : Icons.light_mode,
                    size: 16,
                    color: Colors.blue,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Theme: ${widget.isDarkTheme ? 'Dark' : 'Light'}',
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

            // Fruits selector
            const Text(
              'Select a fruit:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            UniversalSelector(
              items: fruits,
              selectedItem: selectedItem,
              onItemSelected: (SelectableItem item) {
                setState(() {
                  selectedItem = item;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Selected: ${item.icon} ${item.name}'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              labelText: 'Choose a fruit',
              hintText: 'Search fruits...',
            ),
            const SizedBox(height: 24),

            // Countries selector
            const Text(
              'Select a country:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            UniversalSelector(
              items: countries,
              selectedItem: selectedItem,
              onItemSelected: (SelectableItem item) {
                setState(() {
                  selectedItem = item;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Selected: ${item.icon} ${item.name}'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              labelText: 'Choose a country',
              hintText: 'Search countries...',
            ),
            const SizedBox(height: 24),

            // Colors selector
            const Text(
              'Select a color:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            UniversalSelector(
              items: colors,
              selectedItem: selectedItem,
              onItemSelected: (SelectableItem item) {
                setState(() {
                  selectedItem = item;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Selected: ${item.icon} ${item.name}'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              labelText: 'Choose a color',
              hintText: 'Search colors...',
            ),
            const SizedBox(height: 24),

            // Light theme selector example
            const Text(
              'Light Theme Version:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            UniversalSelector(
              items: fruits,
              selectedItem: selectedItem,
              onItemSelected: (SelectableItem item) {
                setState(() {
                  selectedItem = item;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Selected: ${item.icon} ${item.name}'),
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
              hoverColor: Colors.grey.shade200,
              borderRadius: 12.0,
              labelText: 'Light theme selector',
              hintText: 'Search items...',
            ),
            const SizedBox(height: 24),

            // Custom theme selector example
            const Text(
              'Custom Theme (Purple):',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            UniversalSelector(
              items: colors,
              selectedItem: selectedItem,
              onItemSelected: (SelectableItem item) {
                setState(() {
                  selectedItem = item;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Selected: ${item.icon} ${item.name}'),
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
              hoverColor: Colors.purple.shade200,
              borderRadius: 16.0,
              labelText: 'Purple theme selector',
              hintText: 'Search items...',
            ),
            const SizedBox(height: 32),

            // Multi-select example
            const Text(
              'Multi-select (max 3):',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            UniversalSelector(
              items: fruits,
              selectedItems: selectedItems,
              isMultiSelect: true,
              maxSelections: 3,
              onItemSelected: (SelectableItem item) {
                // This callback is required but not used in multi-select mode
              },
              onItemsSelected: (List<SelectableItem> items) {
                setState(() {
                  selectedItems = items;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Selected ${items.length} items'),
                    backgroundColor: Colors.blue,
                  ),
                );
              },
              labelText: 'Choose multiple fruits',
              hintText: 'Search and select fruits...',
            ),
            const SizedBox(height: 24),

            // Selected items display
            if (selectedItems.isNotEmpty) ...[
              const Text(
                'Selected Items:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.withAlpha((0.1 * 255).toInt()),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: Colors.blue.withAlpha((0.3 * 255).toInt())),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${selectedItems.length} items selected:',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...selectedItems.map((item) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Row(
                            children: [
                              if (item.icon != null) ...[
                                Text(item.icon!,
                                    style: const TextStyle(fontSize: 16)),
                                const SizedBox(width: 8),
                              ],
                              Expanded(
                                child: Text(
                                  item.name,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],

            // Selected item display
            if (selectedItem != null) ...[
              const Text(
                'Selected Item:',
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
                    if (selectedItem!.icon != null) ...[
                      Text(
                        selectedItem!.icon!,
                        style: const TextStyle(fontSize: 32),
                      ),
                      const SizedBox(width: 16),
                    ],
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            selectedItem!.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (selectedItem!.subtitle != null) ...[
                            const SizedBox(height: 4),
                            Text(
                              selectedItem!.subtitle!,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                          const SizedBox(height: 4),
                          Text(
                            'ID: ${selectedItem!.id}',
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
                  Text('• Universal item selection'),
                  Text('• Multi-select support'),
                  Text('• Fuzzy search with typos support'),
                  Text('• Customizable icons and subtitles'),
                  Text('• Beautiful dark theme'),
                  Text('• Light theme support'),
                  Text('• Custom color themes'),
                  Text('• Customizable labels'),
                  Text('• Responsive design'),
                  Text('• Fast and lightweight'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

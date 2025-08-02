import 'package:flutter/material.dart';
import 'package:multiselector/multiselector.dart';

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
      title: 'Multiselector Demo',
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

  // Fruits data
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
    const SelectableItem(
      id: 'pineapple',
      name: 'Pineapple',
      icon: '🍍',
      subtitle: 'Tropical fruit',
      searchData: 'pineapple tropical sweet',
    ),
    const SelectableItem(
      id: 'watermelon',
      name: 'Watermelon',
      icon: '🍉',
      subtitle: 'Summer fruit',
      searchData: 'watermelon summer refreshing',
    ),
    const SelectableItem(
      id: 'mango',
      name: 'Mango',
      icon: '🥭',
      subtitle: 'Tropical fruit',
      searchData: 'mango tropical sweet',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Multiselector Demo'),
        backgroundColor: widget.isDarkTheme ? Colors.grey[900] : Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(
              widget.isDarkTheme ? Icons.light_mode : Icons.dark_mode,
            ),
            onPressed: widget.onThemeChanged,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Theme indicator
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

          // Single fruit selector
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

          // Multi-select example
          const Text(
            'Multi-select fruits:',
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
            onItemSelected: (SelectableItem item) {
              // This callback is required but not used in multi-select mode
            },
            onItemsSelected: (List<SelectableItem> items) {
              setState(() {
                selectedItems = items;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Selected ${items.length} fruits'),
                  backgroundColor: Colors.blue,
                ),
              );
            },
            labelText: 'Choose multiple fruits',
            hintText: 'Search and select fruits...',
            maxSelections: 5,
          ),
          const SizedBox(height: 24),

          // Selected item display
          if (selectedItem != null) ...[
            const Text(
              'Selected Fruit:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],

          // Selected items display (multi-select)
          if (selectedItems.isNotEmpty) ...[
            const SizedBox(height: 16),
            const Text(
              'Selected Fruits:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: selectedItems.map((item) {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.blue.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                    border:
                        Border.all(color: Colors.blue.withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (item.icon != null) ...[
                        Text(item.icon!, style: const TextStyle(fontSize: 16)),
                        const SizedBox(width: 4),
                      ],
                      Text(
                        item.name,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],

          const SizedBox(height: 24),

          // Features section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
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
                Text('• Single item selection'),
                Text('• Multi-select support'),
                Text('• Fuzzy search with typos support'),
                Text('• Customizable icons and subtitles'),
                Text('• Beautiful dark/light themes'),
                Text('• Responsive design'),
                Text('• Fast and lightweight'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

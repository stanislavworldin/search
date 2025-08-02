import 'package:flutter/material.dart';
import 'package:fuzzy_search_engine/fuzzy_search.dart';

void main() {
  runApp(const SearchExampleApp());
}

class SearchExampleApp extends StatelessWidget {
  const SearchExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Search Engine Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const SearchExamplePage(),
    );
  }
}

class SearchExamplePage extends StatefulWidget {
  const SearchExamplePage({super.key});

  @override
  State<SearchExamplePage> createState() => _SearchExamplePageState();
}

class _SearchExamplePageState extends State<SearchExamplePage> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _fuzzySearchController = TextEditingController();

  List<SearchableItem> _allItems = [];
  List<SearchableItem> _searchResults = [];
  List<SearchableItem> _fuzzyResults = [];

  @override
  void initState() {
    super.initState();
    _initializeItems();
    _searchController.addListener(_onSearchChanged);
    _fuzzySearchController.addListener(_onFuzzySearchChanged);
  }

  void _initializeItems() {
    _allItems = [
      const SearchableItem(
        id: '1',
        name: 'Apple',
        icon: '🍎',
        subtitle: 'Red fruit',
        searchData: 'apple fruit red sweet',
      ),
      const SearchableItem(
        id: '2',
        name: 'Banana',
        icon: '🍌',
        subtitle: 'Yellow fruit',
        searchData: 'banana fruit yellow potassium',
      ),
      const SearchableItem(
        id: '3',
        name: 'Orange',
        icon: '🍊',
        subtitle: 'Orange fruit',
        searchData: 'orange fruit citrus vitamin c',
      ),
      const SearchableItem(
        id: '4',
        name: 'Grape',
        icon: '🍇',
        subtitle: 'Purple fruit',
        searchData: 'grape fruit purple wine',
      ),
      const SearchableItem(
        id: '5',
        name: 'Strawberry',
        icon: '🍓',
        subtitle: 'Red berry',
        searchData: 'strawberry berry red sweet',
      ),
      const SearchableItem(
        id: '6',
        name: 'Pineapple',
        icon: '🍍',
        subtitle: 'Tropical fruit',
        searchData: 'pineapple tropical sweet',
      ),
    ];
  }

  void _onSearchChanged() {
    final query = _searchController.text;
    setState(() {
      _searchResults = SearchEngine.search(_allItems, query);
    });
  }

  void _onFuzzySearchChanged() {
    final query = _fuzzySearchController.text;
    setState(() {
      _fuzzyResults = SearchEngine.fuzzySearch(_allItems, query);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _fuzzySearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Engine Example'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Basic Search Section
            const Text(
              'Basic Search',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Search fruits...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 16),
            Text('Results (${_searchResults.length}):'),
            const SizedBox(height: 8),
            Expanded(
              flex: 1,
              child: ListView.builder(
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  final item = _searchResults[index];
                  return Card(
                    child: ListTile(
                      leading: Text(item.icon ?? '🍎',
                          style: const TextStyle(fontSize: 24)),
                      title: Text(item.name),
                      subtitle: Text(item.subtitle ?? ''),
                    ),
                  );
                },
              ),
            ),

            const Divider(height: 32),

            // Fuzzy Search Section
            const Text(
              'Fuzzy Search (try typos like "aple", "bananna")',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _fuzzySearchController,
              decoration: const InputDecoration(
                labelText: 'Fuzzy search...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.psychology),
              ),
            ),
            const SizedBox(height: 16),
            Text('Fuzzy Results (${_fuzzyResults.length}):'),
            const SizedBox(height: 8),
            Expanded(
              flex: 1,
              child: ListView.builder(
                itemCount: _fuzzyResults.length,
                itemBuilder: (context, index) {
                  final item = _fuzzyResults[index];
                  return Card(
                    color: Colors.orange.shade50,
                    child: ListTile(
                      leading: Text(item.icon ?? '🍎',
                          style: const TextStyle(fontSize: 24)),
                      title: Text(item.name),
                      subtitle: Text(item.subtitle ?? ''),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

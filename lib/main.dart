import 'package:flutter/material.dart';
import 'joke_service.dart'; // Import the service file

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Joke App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Jokes Hub'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final JokeService _jokeService = JokeService();
  List<String> _jokes = [];
  bool _isLoading = false;
  String _selectedCategory = 'Programming'; // Default category

  Future<void> _fetchJokes() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final jokes = await _jokeService.fetchJokesRaw(category: _selectedCategory);
      setState(() {
        _jokes = jokes;
      });
    } catch (e) {
      setState(() {
        _jokes = ['Failed to load jokes!'];
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Category Dropdown and Get Jokes Button in a Row
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // Expanded DropdownButton to take most of the width
                Expanded(
                  flex: 3,
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: _selectedCategory,
                    hint: const Text('Select Joke Category'),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),dropdownColor: Colors.lightGreen.shade50, // Background color of dropdown items
                    icon: Icon(
                      Icons.arrow_drop_down_circle,
                      color: Colors.lightGreen,
                    ),
                    underline: Container(
                      height: 2,
                      color: Colors.lightGreen,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedCategory = newValue!;
                      });
                    },
                    items: _jokeService.categories
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),

                // Small space between dropdown and button
                const SizedBox(width: 50),

                // Get Jokes Button
                Expanded(
                  flex: 2,
                  child: ElevatedButton.icon(
                    onPressed: _fetchJokes,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Get Jokes'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                      minimumSize: const Size(double.infinity, 48),
                    )
                    ,
                  ),
                ),
              ],
            ),
          ),

          // Jokes List or Placeholder
          Expanded(
            child: Center(
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : _jokes.isNotEmpty
                  ? ListView.builder(
                itemCount: _jokes.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        _jokes[index],
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  );
                },
              )
                  : const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'No Jokes!',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      // Removed the floating action button since we now have an inline button
    );
  }
}
import 'package:flutter/material.dart';
import 'package:demo_music_app/presentation/widgets/searchBar.dart' as SearchBar;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var query = '';
  var type = '';

  void updateSearchTerm(String term) {
    query = term;
    notifyListeners();
  }

  void updateSearchType(String selectedType) {
    type = selectedType;
    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SearchBar.SearchBar(myAppState: MyAppState());
  }
}



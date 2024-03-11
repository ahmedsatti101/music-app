import 'package:flutter/material.dart';
import 'package:demo_music_app/presentation/pages/home.dart' as HomePage;

void main() {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
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
      home: const HomePage.HomePage(),
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

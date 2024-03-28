import 'package:demo_music_app/presentation/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';

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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const NavigationBarWidget(),
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

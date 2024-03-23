import 'package:flutter/material.dart';
import 'package:demo_music_app/main.dart' as app;
import 'package:demo_music_app/presentation/widgets/searchBar.dart' as SearchBar;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SearchBar.SearchBar(myAppState: app.MyAppState()),
    );
  }
}

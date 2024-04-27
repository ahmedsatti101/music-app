import 'package:demo_music_app/presentation/pages/add_to_playlist.dart';
import 'package:demo_music_app/presentation/pages/home.dart';
import 'package:demo_music_app/presentation/pages/library.dart';
import 'package:flutter/material.dart';

class NavigationBarWidget extends StatefulWidget {
  const NavigationBarWidget({super.key});
  @override
  State<NavigationBarWidget> createState() => _NavigationBarWidgetState();
}

class _NavigationBarWidgetState extends State<NavigationBarWidget> {
  var currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.blue,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
              selectedIcon: Icon(Icons.home)),
          NavigationDestination(
              icon: Icon(Icons.add_circle_outline),
              label: 'Add',
              selectedIcon: Icon(Icons.add_circle)),
          NavigationDestination(
              icon: Icon(Icons.library_music_outlined),
              label: 'Library',
              selectedIcon: Icon(Icons.library_music))
        ],
      ),
      body: <Widget>[
        const HomePage(),
        const AddToPlaylist(),
        const Library()
      ][currentPageIndex],
    );
  }
}

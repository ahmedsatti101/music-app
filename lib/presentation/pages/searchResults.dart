import 'package:flutter/material.dart';
import 'package:demo_music_app/main.dart' as app;
import 'package:demo_music_app/utils/api.dart' as api;
import 'package:demo_music_app/utils/factory_utils/utils.dart';

class SearchResults extends StatefulWidget {
  const SearchResults({super.key, required this.myAppState});
  final app.MyAppState myAppState;

  @override
  _SearchResultsState createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  late Future<List<Artists>> futureArtists;

  @override
  void initState() {
    super.didChangeDependencies();
    futureArtists = ArtistService().getArtists(widget.myAppState.query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: FutureBuilder<List<Artists>>(
        future: futureArtists,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text('Data is here!');
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          return const CircularProgressIndicator();
        },
      )),
    );
  }
}

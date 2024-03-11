import 'package:flutter/material.dart';
import 'package:demo_music_app/main.dart' as app;
import 'package:demo_music_app/utils/api.dart' as api;

var artistSearchData = api.artistSearchData;
var albumSearchData = api.albumSearchData;
var trackSearchData = api.trackSearchData;
var playlistSearchData = api.playlistSearchData;

class SearchResults extends StatefulWidget {
  const SearchResults({super.key, required this.myAppState});
  final app.MyAppState myAppState;

  @override
  _SearchResultsState createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  // late String typeQuery;

  // @override
  // void initState() {
  //   super.initState();
  //   typeQuery = widget.myAppState.type;
  // }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      
    );
  }
}

    /*return ListView.builder(
      itemCount: typeQuery == 'artist'
          ? artistSearchData.length
          : typeQuery == 'album'
              ? albumSearchData.length
              : typeQuery == 'track'
                  ? trackSearchData.length
                  : typeQuery == 'playlist'
                      ? playlistSearchData.length
                      : 0,
      itemBuilder: (context, index) {
        var result = typeQuery == 'artist'
            ? artistSearchData[index]
            : typeQuery == 'album'
                ? albumSearchData[index]
                : typeQuery == 'track'
                    ? trackSearchData[index]
                    : typeQuery == 'playlist'
                        ? playlistSearchData[index]
                        : 0;
        return Card(
          child: ListTile(
            leading: Image.network(result.artCoverUrl),
            title: Text(result.name),
            // subtitle: Text(result.owner),
          ),
        );
      },
    );*/
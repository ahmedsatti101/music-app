import 'dart:convert';
import 'package:demo_music_app/utils/api.dart';
import 'package:http/http.dart' as http;

class Artists {
  final String name;
  final List images;
  final String type;

  const Artists({required this.name, required this.images, required this.type});

  factory Artists.fromJson(Map<String, dynamic> json) {
    return Artists(
        name: json['name'], images: json['images'], type: json['type']);
  }
}

class Albums {
  final List images;
  final String name;
  final String type;
  final String artistName;

  const Albums(
      {required this.images,
      required this.name,
      required this.type,
      required this.artistName});

  factory Albums.fromJson(Map<String, dynamic> json) {
    return Albums(
        images: json['images'],
        name: json['name'],
        type: json['type'],
        artistName: json['name']);
  }
}

class Tracks {
  final String name;
  final String type;
  // final String artistName;
  // final List images;

  const Tracks({
    // required this.images,
    required this.name,
    required this.type,
    /*required this.artistName*/
  });

  factory Tracks.fromJson(Map<String, dynamic> json) {
    return Tracks(
      // images: json['images'],
      name: json['name'],
      type: json['type'], /*artistName: json['name']*/
    );
  }
}

class Playlists {
  final String name;
  final String type;
  // final List images;
  // final String displayName;

  const Playlists({
      // required this.images,
      required this.name,
      required this.type,
      // required this.displayName
      });

  factory Playlists.fromJson(Map<String, dynamic> json) {
    return Playlists(
        // images: json['images'],
        name: json['name'],
        type: json['type'],
        // displayName: json['display_name']
        );
  }
}

class SearchService {
  Future<List> getResults(query, type) async {
    var accessToken = await getAccessToken();
    final response = await http.get(
        Uri.parse('https://api.spotify.com/v1/search?query=$query&type=$type'),
        headers: {'Authorization': 'Bearer $accessToken'});

    final data = jsonDecode(response.body);
    if (response.statusCode == 200 && type == 'artist') {
      final List<Artists> list = [];

      for (var i = 0; i < data['artists']['items'].length; i++) {
        final entry = data['artists']['items'][i];
        list.add(Artists.fromJson(entry));
      }
      return list;
    } else if (response.statusCode == 200 && type == 'album') {
      final List<Albums> list = [];

      for (var i = 0; i < data['albums']['items'].length; i++) {
        final entry = data['albums']['items'][i];
        list.add(Albums.fromJson(entry));
      }
      return list;
    } else if (response.statusCode == 200 && type == 'track') {
      final List<Tracks> list = [];

      for (var i = 0; i < data['tracks']['items'].length; i++) {
        final entry = data['tracks']['items'][i];
        list.add(Tracks.fromJson(entry));
      }
      return list;
    } else if (response.statusCode == 200 && type == 'playlist') {
      final List<Playlists> list = [];

      for (var i = 0; i < data['playlists']['items'].length; i++) {
        final entry = data['playlists']['items'][i];
        list.add(Playlists.fromJson(entry));
      }
      return list;
    } else {
      throw Exception('HTTP failed :(');
    }
  }
}

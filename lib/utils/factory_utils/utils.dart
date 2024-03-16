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
  final String artist;

  const Albums(
      {required this.images,
      required this.name,
      required this.type,
      required this.artist});

  factory Albums.fromJson(Map<String, dynamic> json) {
    return Albums(
        images: json['images'],
        name: json['name'],
        type: json['type'],
        artist: json['artist']);
  }
}

class Tracks {
  final String name;
  final String type;
  final String artist;
  // final List images;

  const Tracks(
      {
      // required this.images,
      required this.name,
      required this.type,
      required this.artist});

  factory Tracks.fromJson(Map<String, dynamic> json) {
    return Tracks(
        // images: json['images'],
        name: json['name'],
        type: json['type'],
        artist: json['artist']);
  }
}

class Playlists {
  final String name;
  final String type;
  // final List images;
  final String creator;

  const Playlists(
      {
      // required this.images,
      required this.name,
      required this.type,
      required this.creator});

  factory Playlists.fromJson(Map<String, dynamic> json) {
    return Playlists(
        // images: json['images'],
        name: json['name'],
        type: json['type'],
        creator: json['creator']);
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
        entry['type'] = 'Artist';
        list.add(Artists.fromJson(entry));
      }
      return list;
    } else if (response.statusCode == 200 && type == 'album') {
      final List<Albums> list = [];

      for (var i = 0; i < data['albums']['items'].length; i++) {
        final entry = data['albums']['items'][i];
        final artistInfo = entry['artists'];
        var artist;

        for (var j = 0; j < artistInfo.length; j++) {
          artist = artistInfo[j]['name'];
        }
        entry['artist'] = artist;
        entry['type'] = 'Album';
        list.add(Albums.fromJson(entry));
      }
      return list;
    } else if (response.statusCode == 200 && type == 'track') {
      final List<Tracks> list = [];

      for (var i = 0; i < data['tracks']['items'].length; i++) {
        final entry = data['tracks']['items'][i];
        final artistInfo = entry['artists'];
        var artist;

        for (var j = 0; j < artistInfo.length; j++) {
          artist = artistInfo[j]['name'];
        }

        entry['artist'] = artist;
        entry['type'] = 'Song';
        list.add(Tracks.fromJson(entry));
      }
      return list;
    } else if (response.statusCode == 200 && type == 'playlist') {
      final List<Playlists> list = [];

      for (var i = 0; i < data['playlists']['items'].length; i++) {
        final entry = data['playlists']['items'][i];
        entry['creator'] = entry['owner']['display_name'];
        entry['type'] = 'Playlist';
        list.add(Playlists.fromJson(entry));
      }
      return list;
    } else {
      throw Exception('HTTP failed :(');
    }
  }
}

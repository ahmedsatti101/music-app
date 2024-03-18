import 'dart:convert';
import 'package:demo_music_app/utils/api.dart';
import 'package:http/http.dart' as http;

class Artists {
  final String name;
  final String? image;
  final String type;
  final String id;

  const Artists(
      {required this.name,
      required this.image,
      required this.type,
      required this.id});

  factory Artists.fromJson(Map<String, dynamic> json) {
    return Artists(
        name: json['name'],
        image: json['image'],
        type: json['type'],
        id: json['artistId']);
  }
}

class Albums {
  final String image;
  final String name;
  final String type;
  final String artist;
  final String id;

  const Albums(
      {required this.image,
      required this.name,
      required this.type,
      required this.artist,
      required this.id});

  factory Albums.fromJson(Map<String, dynamic> json) {
    return Albums(
        image: json['image'],
        name: json['name'],
        type: json['type'],
        artist: json['artist'],
        id: json['albumId']);
  }
}

class Tracks {
  final String name;
  final String type;
  final String artist;
  final String image;
  final String id;

  const Tracks(
      {required this.image,
      required this.name,
      required this.type,
      required this.artist,
      required this.id});

  factory Tracks.fromJson(Map<String, dynamic> json) {
    return Tracks(
        image: json['image'],
        name: json['name'],
        type: json['type'],
        artist: json['artist'],
        id: json['trackId']);
  }
}

class Playlists {
  final String name;
  final String type;
  final String image;
  final String creator;
  final String id;

  const Playlists(
      {required this.image,
      required this.name,
      required this.type,
      required this.creator,
      required this.id});

  factory Playlists.fromJson(Map<String, dynamic> json) {
    return Playlists(
        image: json['image'],
        name: json['name'],
        type: json['type'],
        creator: json['creator'],
        id: json['playlistId']);
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
        var image;

        if (entry['images'].length == 0) {
          entry['image'] =
              'https://cdn.iconscout.com/icon/premium/png-256-thumb/music-tune-85-893035.png';
        } else {
          for (var j = 0; j < entry['images'].length; j++) {
            image = entry['images'][j]['url'];
          }
        }

        entry['artistId'] = entry['id'];
        entry['image'] = image;
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
        var image;

        for (var j = 0; j < artistInfo.length; j++) {
          artist = artistInfo[j]['name'];
        }

        image = entry['images'][0]['url'];

        entry['image'] = image;
        entry['albumId'] = entry['id'];
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
        final trackCover = entry['album']['images'];
        var artist;
        var cover;

        for (var j = 0; j < artistInfo.length; j++) {
          artist = artistInfo[j]['name'];
        }

        cover = trackCover[0]['url'];

        entry['artist'] = artist;
        entry['type'] = 'Song';
        entry['image'] = cover;
        entry['trackId'] = entry['id'];
        list.add(Tracks.fromJson(entry));
      }
      return list;
    } else if (response.statusCode == 200 && type == 'playlist') {
      final List<Playlists> list = [];

      for (var i = 0; i < data['playlists']['items'].length; i++) {
        final entry = data['playlists']['items'][i];
        var image;

        image = entry['images'][0]['url'];

        entry['image'] = image;
        entry['playlistId'] = entry['id'];
        entry['creator'] = entry['owner']['display_name'];
        entry['type'] = 'Playlist';
        list.add(Playlists.fromJson(entry));
      }
      return list;
    } else {
      throw Exception('Something went wrong!');
    }
  }
}

import 'dart:convert';
import 'package:demo_music_app/utils/api.dart';
import 'package:http/http.dart' as http;

class Artists {
  final String name;
  final List images;

  const Artists({required this.name, required this.images});

  factory Artists.fromJson(Map<String, dynamic> json) {
    return Artists(name: json['name'], images: json['images']);
  }
}

class ArtistService {
  Future<List<Artists>> getArtists(query) async {
    var accessToken = await getAccessToken();
    final response = await http.get(
        Uri.parse('https://api.spotify.com/v1/search?query=$query&type=artist'),
        headers: {'Authorization': 'Bearer $accessToken'});

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<Artists> list = [];

      for (var i = 0; i < data['artists']['items'].length; i++) {
        final entry = data['artists']['items'][i];
        list.add(Artists.fromJson(entry));
      }
      return list;
    } else {
      throw Exception('HTTP failed :(');
    }
  }
}

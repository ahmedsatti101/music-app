import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:demo_music_app/utils/factory_utils/utils.dart' as util;
import 'package:flutter_dotenv/flutter_dotenv.dart';

var artistSearchData = [];
var albumSearchData = [];
var trackSearchData = [];
var playlistSearchData = [];

Future<String?> getAccessToken() async {
  await dotenv.load();
  var token = '';
  var authStr = '${dotenv.env['client_id']}:${dotenv.env['client_secret']}';
  var authBytes = utf8.encode(authStr);
  var authBase64 = base64Encode(authBytes);

  final response = await http.post(
    Uri.parse('https://accounts.spotify.com/api/token'),
    headers: {
      'Authorization': 'Basic $authBase64',
      'Content-Type': 'application/x-www-form-urlencoded',
    },
    body: {'grant_type': 'client_credentials'},
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = jsonDecode(response.body);
    token = data['access_token'];
    return token;
  } else {
    print('Failed to get access token. Status code: ${response.statusCode}');
    return null;
  }
}

Future<util.SearchResults> searchApi(query, type) async {
  final accessToken = await getAccessToken();
  final response = await http.get(
      Uri.parse(
          'https://api.spotify.com/v1/search?query=$query&type=$type'),
      headers: {'Authorization': 'Bearer $accessToken'});
  final searchResults = util.SearchResults.fromJson(
      jsonDecode(response.body) as Map<String, dynamic>);

  if (response.statusCode == 200 && type == 'artist') {
    var result = jsonDecode(response.body)['artists']['items'];
    for (var element in result) {
      artistSearchData.addAll([
        element['name'],
        element['images'], //list
        element['followers']['total'],
        element['href']
      ]);
    }
    return searchResults;
  } else if (response.statusCode == 200 && type == 'album') {
    var result = jsonDecode(response.body)['albums']['items'];
    for (var element in result) {
      albumSearchData.addAll([
        element['id'],
        element['artists'], //list
        element['href'],
        element['images'], //list
        element['name'],
        element['release_date'],
        element['total_tracks'],
        element['type']
      ]);
    }
    return searchResults;
  } else if (response.statusCode == 200 && type == 'track') {
    var result = jsonDecode(response.body)['tracks']['items'];
    for (var element in result) {
      trackSearchData.addAll([
        element['album']['artists'], //list
        element['href'],
        element['id'],
        element['name']
      ]);
    }
    return searchResults;
  } else if (response.statusCode == 200 && type == 'playlist') {
    var result = jsonDecode(response.body)['playlists']['items'];
    for (var element in result) {
      playlistSearchData.addAll([
        element['description'],
        element['href'],
        element['type'],
        element['id'],
        element['images'], //list
        element['name'],
        element['owner']['display_name'],
        element['tracks']
      ]);
    }
    return searchResults;
  } else {
    throw Exception('Error: ${response.statusCode}');
  }
}

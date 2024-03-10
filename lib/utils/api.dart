import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:demo_music_app/utils/factory_utils/utils.dart' as util;
import 'dart:convert' show utf8;

const clientId = '9f080e9d211848d09176ea3ce1f58d93';
const clientSecret = '9615898eb16e4868aced50515d772344';

Future<String?> getAccessToken() async {
  var token = '';
  var authStr = '$clientId:$clientSecret';
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
      Uri.parse('https://api.spotify.com/v1/search?query=$query&type=$type&limit=10'),
      headers: {'Authorization': 'Bearer $accessToken'});
  final searchResults = util.SearchResults.fromJson(
      jsonDecode(response.body) as Map<String, dynamic>);

  if (response.statusCode == 200 && type == 'artist') {
    print('${jsonDecode(response.body)['artists']}');
    return searchResults;
  } else if (response.statusCode == 200 && type == 'album') {
    var result = jsonDecode(response.body)['albums']['items'];
    for (var element in result) {
      print(element['id']);
    }
    return searchResults;
  } else if (response.statusCode == 200 && type == 'track') {
    print('${jsonDecode(response.body)['tracks']}');
    return searchResults;
  } else if (response.statusCode == 200 && type == 'playlist') {
    print('${jsonDecode(response.body)['playlists']}');
    return searchResults;
  } else {
    throw Exception('Query or type was not provided.');
  }
}

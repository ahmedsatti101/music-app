import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:demo_music_app/utils/factory_utils/utils.dart' as util;
import 'package:demo_music_app/utils/server.dart' as server;

const clientId = '9f080e9d211848d09176ea3ce1f58d93';
const clientSecret = '9615898eb16e4868aced50515d772344';
const redirectUri = 'http://10.0.2.2:3000';

Future<String> requestAuth() async {
  var code = '';

  final url = 
      'https://accounts.spotify.com/authorize?client_id=$clientId&response_type=code&redirect_uri=$redirectUri';
  http.Response response = await http.get(url);

  if (response.statusCode == 200) {
    code = response.body;
    print(code);
    return code;
  } else {
    throw Exception('Error getting code. Result: $code');
  }
}

Future<String?> getAccessToken() async {
  final authCode = await requestAuth();
  var token = '';

  final response = await http.post(
    Uri.parse('https://accounts.spotify.com/api/token'),
    headers: {
      'Authorization': 'Basic <base64 encoded $clientId:$clientSecret>',
      'Content-Type': 'application/x-www-form-urlencoded',
    },
    body: {
      'grant_type': 'authorization_code',
      'code': authCode,
      'redirect_uri': redirectUri,
    },
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = jsonDecode(response.body);
    // print(data);
    token = data['access_token'];
    return token;
  } else {
    print('Failed to get access token. Status code: ${response.statusCode}');
    return null;
  }
}

Future<http.Response> searchApi(query, type) async {
  final accessToken = await getAccessToken();
  final response = await http.get(
      Uri.parse('https://api.spotify.com/v1/search?query=$query&type=$type'),
      headers: {'Authorization': 'Bearer $accessToken'});
  final searchResults = util.SearchResults.fromJson(
      jsonDecode(response.body) as Map<String, dynamic>);

  if (response.statusCode == 200) {
    return http.Response(jsonEncode(searchResults), 200);
  } else {
    throw Exception('Failed :(');
  }
}

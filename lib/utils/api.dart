import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:demo_music_app/utils/factory_utils/utils.dart' as util;
import 'package:flutter_dotenv/flutter_dotenv.dart';

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

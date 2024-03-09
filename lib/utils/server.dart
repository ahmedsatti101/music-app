import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:demo_music_app/utils/api.dart' as api;

class AuthWebView extends StatefulWidget {
  @override
  _AuthWebViewState createState() => _AuthWebViewState();
}

class _AuthWebViewState extends State<AuthWebView> {
  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl:
          'https://accounts.spotify.com/authorize?client_id=${api.clientId}&response_type=code&redirect_uri=${api.redirectUri}',
      navigationDelegate: (NavigationRequest request) async {
        if (request.url.startsWith(api.redirectUri)) {
          // Handle the URL, extract the code, and pass it back to the calling widget.
          Navigator.pop(context, request.url);
          return NavigationDecision.prevent;
        }
        return NavigationDecision.navigate;
      },
    );
  }
}
import 'dart:io';

void main() async {
  final requests = await HttpServer.bind('192.168.0.1', 3000);
  print('Listening on ${requests.address.host}:${requests.port}');
}
import 'package:demo_music_app/utils/factory_utils/utils.dart';
import 'package:flutter/material.dart';

class AlbumTracks extends StatelessWidget {
  AlbumTracks({super.key, required this.id});
  final String id;
  Future<List> futureTracks = Future.value([]);

  void initState() {
    futureTracks = AlbumTracksService().getAlbumTracks(id);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder(
          future: futureTracks,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const Text('data is here in AlbumTracks');
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            return const CircularProgressIndicator();
          },
        )
      ],
    );
  }
}

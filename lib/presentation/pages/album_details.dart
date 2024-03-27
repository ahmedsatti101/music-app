import 'package:demo_music_app/presentation/widgets/image_section.dart';
import 'package:flutter/material.dart';
import 'package:demo_music_app/presentation/widgets/album_tracks.dart';

class AlbumDetailsPage extends StatelessWidget {
  final dynamic selectedAlbum;

  const AlbumDetailsPage({super.key, required this.selectedAlbum});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedAlbum.name),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          ImageSection(image: selectedAlbum.cover),
          AlbumTracks(id: selectedAlbum.id),
        ],
      )),
    );
  }
}

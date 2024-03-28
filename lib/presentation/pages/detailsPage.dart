import 'package:demo_music_app/presentation/widgets/artist_albums.dart';
import 'package:demo_music_app/presentation/widgets/image_section.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final dynamic selectedItem;

  const DetailsPage({super.key, required this.selectedItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedItem.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ImageSection(image: selectedItem.image),
            const Padding(
                padding: EdgeInsets.all(8),
                child: Text('Discography')),
            Padding(
                padding: const EdgeInsets.all(8),
                child: ArtistAlbums(id: selectedItem.id)),
          ],
        ),
      ),
    );
  }
}

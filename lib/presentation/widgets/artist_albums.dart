import 'package:demo_music_app/presentation/pages/album_details.dart';
import 'package:demo_music_app/utils/factory_utils/utils.dart';
import 'package:flutter/material.dart';

class ArtistAlbums extends StatefulWidget {
  const ArtistAlbums({super.key, required this.id});
  final String id;
  @override
  _ArtistAlbumsState createState() => _ArtistAlbumsState();
}

class _ArtistAlbumsState extends State<ArtistAlbums> {
  Future<List> futureAlbums = Future.value([]);

  @override
  void initState() {
    super.initState();
    futureAlbums = AlbumsService().getAlbums(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder<List>(
          future: futureAlbums,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Wrap(
                spacing: 8,
                children: snapshot.data!.map((album) {
                  return Card(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) =>
                            AlbumDetailsPage(selectedAlbum: album)
                        ));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.network(album.cover),
                            Text(album.name),
                            Text(album.artist),
                            Text('Release date: ${album.releaseDate}')
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
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

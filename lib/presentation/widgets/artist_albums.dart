import 'package:flutter/material.dart';

class ArtistAlbums extends StatefulWidget {
  const ArtistAlbums({super.key, required this.id});
  final String id;
  @override
  _ArtistAlbumsState createState() => _ArtistAlbumsState();
}

class _ArtistAlbumsState extends State<ArtistAlbums> {
  bool expandWidget = false;
  Future<List> futureAlbums = Future.value([]);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        expandWidget
            ? SizedBox(
                height: 200,
                child: FutureBuilder<List>(
                  future: futureAlbums,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.separated(
                          itemBuilder: (context, index) {
                            var albums = snapshot.data![index];
                            return ListTile(
                              title: Text(albums.name),
                              trailing:
                                  const Icon(Icons.chevron_right_outlined),
                              subtitle: Text(albums.type),
                              onTap: () {},
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const Divider(color: Colors.black26);
                          },
                          itemCount: snapshot.data!.length);
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }

                    return const CircularProgressIndicator();
                  },
                ),
              )
            : Container(),
        ElevatedButton(
            onPressed: () {
              setState(() {
                expandWidget = !expandWidget;
              });
            },
            child: const Icon(Icons.close))
      ],
    );
  }
}

import 'package:demo_music_app/utils/factory_utils/utils.dart';
import 'package:flutter/material.dart';

class AlbumTracks extends StatefulWidget {
  AlbumTracks({super.key, required this.id});
  final String id;
  @override
  _AlbumTracksState createState() => _AlbumTracksState();
}

class _AlbumTracksState extends State<AlbumTracks> {
  Future<List> futureTracks = Future.value([]);

  @override
  void initState() {
    super.initState();
    futureTracks = AlbumTracksService().getAlbumTracks(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder<List>(
          future: futureTracks,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var content = snapshot.data![index];
                    return ListTile(
                      isThreeLine: true,
                      leading: Text('${content.trackNum}'),
                      title: Text(content.name),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(content.artist),
                          if (content.explicit) const Icon(Icons.explicit, size: 20)
                        ],
                      ),
                      trailing: Text(
                          formatDuration(content.trackLength)),
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
        )
      ],
    );
  }
}

String formatDuration(int milliseconds) {
  var duration = Duration(milliseconds: milliseconds);
  var minutes = duration.inMinutes;
  var seconds = duration.inSeconds.remainder(60);
  return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
}

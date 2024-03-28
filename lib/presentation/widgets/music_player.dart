import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

// class MusicPlayer extends StatefulWidget {
//   const MusicPlayer({super.key});
//   // final String url;

//   @override
//   _MusicPlayerState createState() => _MusicPlayerState();
// }

// class _MusicPlayerState extends State<MusicPlayer> {
//   bool isMaximised = false;

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//     child: Scaffold(
//       body: Stack(
//         children: [
//           // This is the container that will always be at the bottom.
//           Positioned(
//             left: 0,
//             right: 0,
//             bottom: 0,
//             child: Container(
//               height: 50, // Set the height of the container as needed.
//               color: Colors.blue, // Set the color of the container as needed.
//               child: Center(
//                 child: MyBottomSheet(),
//               ),
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
//   }
// }

class Expandables extends StatelessWidget {
  const Expandables({super.key, required this.name, required this.artist});
  final String name;
  final String artist;
  @override
  Widget build(BuildContext context) {
    return ExpandablePanel(
      collapsed: Text(
        artist,
        softWrap: true,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      expanded: const Text(
        'Text',
        softWrap: true,
      ),
      header: Text(name),
    );
  }
}

class MyBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Colors.amber,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text('Bottom sheet'),
            ElevatedButton(
              child: const Text('Close BottomSheet'),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}

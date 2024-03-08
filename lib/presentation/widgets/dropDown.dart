import 'package:flutter/material.dart';

class DropdownButtonExample extends StatefulWidget {
  final void Function(String selectedType)? onTypeSelected;
  const DropdownButtonExample({Key? key, this.onTypeSelected}) : super(key: key);

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  String? _dropDownValue;
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      items: const [
        DropdownMenuItem(value: 'artist', child: Text('Artist')),
        DropdownMenuItem(value: 'album', child: Text('Album')),
        DropdownMenuItem(value: 'track', child: Text('Track')),
        DropdownMenuItem(value: 'playlist', child: Text('Playlist')),
      ],
      value: _dropDownValue,
      onChanged: (String? value) {
        setState(() {
          _dropDownValue = value!;
          // Invoke the callback if provided
          widget.onTypeSelected?.call(value);
        });
      });
  }
}
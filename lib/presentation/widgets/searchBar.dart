import 'package:flutter/material.dart';
import 'package:demo_music_app/main.dart' as app;
import 'package:demo_music_app/utils/api.dart' as api;
import 'package:demo_music_app/presentation/widgets/dropDown.dart'
    as dropDownButton;

class SearchBar extends StatefulWidget {
  final app.MyAppState myAppState;

  const SearchBar({Key? key, required this.myAppState}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  late final TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('How are we feelin\' today?'),
      ),
      body: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _textEditingController,
                onChanged: (value) {
                  widget.myAppState.updateSearchTerm(value);
                },
                decoration: const InputDecoration(labelText: 'Search'),
              )),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              dropDownButton.DropdownButtonExample(
                  onTypeSelected: (selectedType) {
                widget.myAppState.updateSearchType(selectedType);
              }),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () async {
                  try {
                    await api.getAccessToken();
                    await api.searchApi(
                        widget.myAppState.query, widget.myAppState.type);
                  } catch (error) {
                    print('Error: $error');
                  }
                },
                child: const Text('Done'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

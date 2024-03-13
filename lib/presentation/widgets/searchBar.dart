import 'package:demo_music_app/utils/factory_utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:demo_music_app/main.dart' as app;
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
  late final Future<List> futureResults;
  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    futureResults = SearchService().getResults('tool', 'artist');
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
                decoration: const InputDecoration(
                    labelText: 'Search', prefixIcon: Icon(Icons.search)),
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
                onPressed: () {
                  SearchService().getResults(
                      widget.myAppState.query, widget.myAppState.type);
                },
                child: const Text('Done'),
              ),
            ],
          ),
          FutureBuilder<List>(
              future: futureResults,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text('Data is here!');
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                return const CircularProgressIndicator();
              })
        ],
      ),
    );
  }
}

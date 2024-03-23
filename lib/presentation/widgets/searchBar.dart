import 'dart:async';
import 'package:demo_music_app/utils/factory_utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:demo_music_app/main.dart' as app;
import 'package:demo_music_app/presentation/widgets/dropDown.dart'
    as dropDownButton;
import 'package:demo_music_app/presentation/pages/detailsPage.dart';

class SearchBar extends StatefulWidget {
  final app.MyAppState myAppState;

  const SearchBar({super.key, required this.myAppState});

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  late final TextEditingController _textEditingController;
  Future<List> futureResults = Future.value([]);
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
                onFieldSubmitted: (value) async {
                  setState(() {
                    futureResults = SearchService()
                        .getResults(value, widget.myAppState.type);
                  });
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
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    futureResults = SearchService().getResults(
                        _textEditingController.text, widget.myAppState.type);
                  });
                },
                child: const Text('Done'),
              ),
            ],
          ),
          Expanded(
            child: FutureBuilder<List>(
              future: futureResults,
              builder: (context, AsyncSnapshot<List> snapshot) {
                if (snapshot.hasData) {
                  return ListView.separated(
                    itemBuilder: (context, index) {
                      var content = snapshot.data![index];
                      return ListTile(
                        leading: Image.network(content.image),
                        title: Text(content.name),
                        trailing: const Icon(Icons.chevron_right_outlined),
                        subtitle: Text(content.type),
                        // subtitle: Text(content.artist != null ? '${content.type} * ${content.artist}' : content.creator != null ? '${content.type} * Owner: ${content.creator}': content.type),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailsPage(selectedItem: content),
                            ),
                          );
                        },
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(color: Colors.black26);
                    },
                    itemCount: snapshot.data!.length,
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                return const CircularProgressIndicator();
              },
            ),
          ),
        ],
      ),
    );
  }
}

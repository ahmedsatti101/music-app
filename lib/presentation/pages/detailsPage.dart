import 'package:flutter/material.dart';

class ImageSection extends StatelessWidget {
  const ImageSection({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      image,
      width: 600,
      height: 240,
      fit: BoxFit.cover,
    );
  }
}

class DetailsPage extends StatelessWidget {
  Future<List> futureResults = Future.value([]);

  DetailsPage({super.key, required this.futureResults});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Details')),
      body: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FutureBuilder<List>(
                future: futureResults,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return const Text('We have data');
                  } else if (snapshot.hasError) {
                    return const Text('failed');
                  }

                  return const CircularProgressIndicator();
                },
              )
            ],
          )
        ],
      ),
    );
  }
}

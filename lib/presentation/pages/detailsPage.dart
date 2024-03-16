import 'package:demo_music_app/presentation/widgets/title_section.dart';
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
  final dynamic selectedItem;

  DetailsPage({super.key, required this.selectedItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TitleSection(title: selectedItem.name),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Back'))
          ],
        ),
      ),
    );
  }
}

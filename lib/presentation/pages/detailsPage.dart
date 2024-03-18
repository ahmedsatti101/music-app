import 'package:demo_music_app/presentation/widgets/image_section.dart';
import 'package:demo_music_app/presentation/widgets/title_section.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final dynamic selectedItem;

  const DetailsPage({super.key, required this.selectedItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ImageSection(image: selectedItem.image),
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

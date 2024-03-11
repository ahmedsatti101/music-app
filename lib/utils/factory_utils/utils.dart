class SearchResults {
  Null query;
  Null type;

  SearchResults({required this.query, required this.type});

  factory SearchResults.fromJson(Map<String, dynamic> json) {
    return SearchResults(
      query: json['query'],
      type: json['type'],
    );
  }
}

class Artist {
  final int followers;
  final String name;
  final String href;
  final List images;

  const Artist({
    required this.followers,
    required this.name,
    required this.href,
    required this.images
  });

  factory Artist.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'followers': int followers,
        'name': String name,
        'href': String href,
        'images': List images,
      } =>
        Artist(
          followers: followers,
          name: name,
          href: href,
          images: images
        ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}

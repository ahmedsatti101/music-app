class SearchResults {
  Null query;
  Null type;

  SearchResults({
    required this.query,
    required this.type
  });

  factory SearchResults.fromJson(Map<String, dynamic> json) {
    return SearchResults(
      query: json['query'],
      type: json['type'],
    );
  }
}
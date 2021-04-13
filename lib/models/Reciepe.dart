class RecipeModel {
  String label;
  String image;
  String source;
  String url;

  RecipeModel({this.label, this.image, this.source, this.url});

  factory RecipeModel.fromMap(Map<String, dynamic> ParsedJson) {
    return RecipeModel(
      label: ParsedJson["label"],
      image: ParsedJson["image"],
      source: ParsedJson["source"],
      url: ParsedJson["url"],
    );
  }
}

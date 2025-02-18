class Document {
  String type;
  String frontImageUrl;
  String backImageUrl;

  Document({
    required this.type,
    required this.frontImageUrl,
    required this.backImageUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      "type": type,
      "frontImageUrl": frontImageUrl,
      "backImageUrl": backImageUrl,
    };
  }
}

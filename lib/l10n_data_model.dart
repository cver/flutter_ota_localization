class L10nData {
  L10nData(this.data, this.fetchingTime);
  final Map<String, Map<String, Label>> data;
  final DateTime fetchingTime;
}

class Label {
  Label({this.message, this.description, this.placeholders});

  factory Label.fromJson(Map<String, dynamic> json) {
    return Label(
      message: json['message'] as String,
      description: json['description'] as String,
      placeholders: LabelArg.fromJson(json['placeholders']),
    );
  }

  final String message;
  final String description;
  final LabelArg placeholders;
}

class LabelArg {
  LabelArg();
  factory LabelArg.fromJson(Map<String, dynamic> json) {
    return LabelArg();
  }
}

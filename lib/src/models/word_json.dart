import 'package:json_annotation/json_annotation.dart';

part 'word_json.g.dart';

@JsonSerializable()
class WordJson {
  @JsonKey(nullable: false)
  String word;
  Pronunciation pronunciation;
  List<Result> results = [];
  bool isFavor;

  WordJson(this.word, {this.pronunciation, List<Result> results})
      : results = results ?? <Result>[];

  factory WordJson.fromJson(Map<String, dynamic> json) =>
      _$WordJsonFromJson(json);

  Map<String, dynamic> toJson() => _$WordJsonToJson(this);

  static Future<WordJson> withError(String errorValue) {
    return null;
  }

  void setFavor(bool f) {
    isFavor = f;
  }

}

@JsonSerializable()
class Result {
  String definition;
  String partOfSpeech;
  List<String> synonyms;
  List<String> antonyms;
  List<String> typeOf;
  List<String> hasTypes;
  List<String> derivation;
  List<String> examples;

  Result(
      {this.definition,
      this.partOfSpeech,
      this.synonyms,
      this.antonyms,
      this.typeOf,
      this.hasTypes,
      this.derivation,
      this.examples});

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}

@JsonSerializable()
class Pronunciation {
  String all;
  String noun;
  String verb;

  Pronunciation({this.all, this.noun, this.verb});

  factory Pronunciation.fromJson(Map<String, dynamic> json) =>
      _$PronunciationFromJson(json);

  Map<String, dynamic> toJson() => _$PronunciationToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

part 'word_detail.g.dart';

@JsonSerializable()
class WordDetail {
  @JsonKey(nullable: false)
  String word;
  Pronunciation pronunciation;
  List<Result> results = [];

  WordDetail(this.word, {this.pronunciation, List<Result> results})
      : results = results ?? <Result>[];

  factory WordDetail.fromJson(Map<String, dynamic> json) =>
      _$WordDetailFromJson(json);

  Map<String, dynamic> toJson() => _$WordDetailToJson(this);

  static Future<WordDetail> withError(String errorValue) {
    return null;
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

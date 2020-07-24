import 'package:json_annotation/json_annotation.dart';

part 'search_detail.g.dart';

@JsonSerializable()
class SearchJson {
  SearchResult results;

  SearchJson({this.results});

  factory SearchJson.fromJson(Map<String, dynamic> json) =>
      _$SearchJsonFromJson(json);

  Map<String, dynamic> toJson() => _$SearchJsonToJson(this);

  static Future<SearchJson> withError(String errorValue) {
    return null;
  }

  List<String> printList() => results.data.toList();
}

@JsonSerializable()
class SearchResult {
  int total;
  List<String> data;

  SearchResult({this.total, this.data});

  factory SearchResult.fromJson(Map<String, dynamic> json) =>
      _$SearchResultFromJson(json);

  Map<String, dynamic> toJson() => _$SearchResultToJson(this);
}

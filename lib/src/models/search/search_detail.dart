import 'package:json_annotation/json_annotation.dart';

part 'search_detail.g.dart';

@JsonSerializable()
class SearchDetail {
  SearchResult results;

  SearchDetail({this.results});

  factory SearchDetail.fromJson(Map<String, dynamic> json) =>
      _$SearchDetailFromJson(json);

  Map<String, dynamic> toJson() => _$SearchDetailToJson(this);

  static Future<SearchDetail> withError(String errorValue) {
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

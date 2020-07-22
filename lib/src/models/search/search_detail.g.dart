// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchDetail _$SearchDetailFromJson(Map<String, dynamic> json) {
  return SearchDetail(
    results: json['results'] == null
        ? null
        : SearchResult.fromJson(json['results'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SearchDetailToJson(SearchDetail instance) =>
    <String, dynamic>{
      'results': instance.results,
    };

SearchResult _$SearchResultFromJson(Map<String, dynamic> json) {
  return SearchResult(
    total: json['total'] as int,
    data: (json['data'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$SearchResultToJson(SearchResult instance) =>
    <String, dynamic>{
      'total': instance.total,
      'data': instance.data,
    };

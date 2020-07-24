// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word_json.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WordJson _$WordJsonFromJson(Map<String, dynamic> json) {
  return WordJson(
    json['word'] as String,
    pronunciation: json['pronunciation'] == null
        ? null
        : Pronunciation.fromJson(json['pronunciation'] as Map<String, dynamic>),
    results: (json['results'] as List)
        ?.map((e) =>
            e == null ? null : Result.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$WordJsonToJson(WordJson instance) => <String, dynamic>{
      'word': instance.word,
      'pronunciation': instance.pronunciation,
      'results': instance.results,
    };

Result _$ResultFromJson(Map<String, dynamic> json) {
  return Result(
    definition: json['definition'] as String,
    partOfSpeech: json['partOfSpeech'] as String,
    synonyms: (json['synonyms'] as List)?.map((e) => e as String)?.toList(),
    antonyms: (json['antonyms'] as List)?.map((e) => e as String)?.toList(),
    typeOf: (json['typeOf'] as List)?.map((e) => e as String)?.toList(),
    hasTypes: (json['hasTypes'] as List)?.map((e) => e as String)?.toList(),
    derivation: (json['derivation'] as List)?.map((e) => e as String)?.toList(),
    examples: (json['examples'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'definition': instance.definition,
      'partOfSpeech': instance.partOfSpeech,
      'synonyms': instance.synonyms,
      'antonyms': instance.antonyms,
      'typeOf': instance.typeOf,
      'hasTypes': instance.hasTypes,
      'derivation': instance.derivation,
      'examples': instance.examples,
    };

Pronunciation _$PronunciationFromJson(Map<String, dynamic> json) {
  return Pronunciation(
    all: json['all'] as String,
    noun: json['noun'] as String,
    verb: json['verb'] as String,
  );
}

Map<String, dynamic> _$PronunciationToJson(Pronunciation instance) =>
    <String, dynamic>{
      'all': instance.all,
      'noun': instance.noun,
      'verb': instance.verb,
    };

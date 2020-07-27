import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../word_json.dart';

class WordDB {
  int id;
  String _word;
  String _pronunciation;
  String _results;

  WordDB({@required String word, String pronunciation, String results, int id})
      : this.id = id,
        _word = word,
        _pronunciation = pronunciation,
        _results = results;

  WordDB.cast(WordJson jsonItem) {
    this._word = jsonItem.word;
  }

  WordDB.map(dynamic obj) {
    this.id = obj["id"];
    this._word = obj["word"];
    this._pronunciation = obj["pronunciation"];
  }

  WordJson toWordJson() {
    return WordJson(
      this._word,
      pronunciation: Pronunciation.fromJson(json.decode(this._pronunciation)),
      results: (json.decode(this._results) as List)
          ?.map((e) =>
              e == null ? null : Result.fromJson(e as Map<String, dynamic>))
          ?.toList(),
    );
  }

  String get word => _word;

  String get pronunciation => _pronunciation;

  String get results => _results;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["word"] = _word;
    map["pronunciation"] = _pronunciation;
    map["results"] = _results;
    return map;
  }
}

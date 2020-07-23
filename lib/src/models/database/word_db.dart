import 'package:flutter/cupertino.dart';

class HistoryWord {
  String _word;
  String _all;
  String _noun;
  String _verb;

  HistoryWord({@required String word, String all, String noun, String verb})
      : _word = word,
        _all = all,
        _noun = noun,
        _verb = verb;

  HistoryWord.map(dynamic obj) {
    this._word = obj["word"];
    this._all = obj["p_all"];
    this._noun = obj["noun"];
    this._verb = obj["verb"];
  }

  String get verb => _verb;

  String get noun => _noun;

  String get all => _all;

  String get word => _word;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["word"] = _word;
    map["p_all"] = _all;
    map["noun"] = _noun;
    map["verb"] = _verb;
    return map;
  }
}

class HistoryDetail {
  String _definition;
  String _partOfSpeech;
  String _synonyms;
  String _antonyms;
  String _typeOf;
  String _hasTypes;
  String _derivation;
  String _examples;
  String FK_word;

  HistoryDetail({String definition,
    String partOfSpeech,
    String synonyms,
    String antonyms,
    String typeOf,
    String hasTypes,
    String derivation,
    String examples})
      : _definition = definition,
        _partOfSpeech = partOfSpeech,
        _synonyms = synonyms,
        _antonyms = antonyms,
        _typeOf = typeOf,
        _hasTypes = hasTypes,
        _derivation = derivation,
        _examples = examples;

  HistoryDetail.map(dynamic obj) {
    _definition = obj["definition"];
    _partOfSpeech = obj["partOfSpeech"];
    _synonyms = obj["synonyms"];
    _antonyms = obj["antonyms"];
    _typeOf = obj["typeOf"];
    _hasTypes = obj["hasTypes"];
    _derivation = obj["derivation"];
    _examples = obj["examples"];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["definition"] = _definition;
    map["partOfSpeech"] = _partOfSpeech;
    map["synonyms"] = _synonyms;
    map["antonyms"] = _antonyms;
    map["typeOf"] = _typeOf;
    map["hasTypes"] = _hasTypes;
    map["derivation"] = _derivation;
    map["examples"] = _examples;
    return map;
  }

  String get examples => _examples;

  String get derivation => _derivation;

  String get hasTypes => _hasTypes;

  String get typeOf => _typeOf;

  String get antonyms => _antonyms;

  String get synonyms => _synonyms;

  String get partOfSpeech => _partOfSpeech;

  String get definition => _definition;
}

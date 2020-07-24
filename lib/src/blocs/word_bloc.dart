import 'dart:async';

import 'package:rxdart/rxdart.dart' show PublishSubject;

import '../models/word_json.dart' show WordJson;
import '../resources/repository.dart';

class WordBloc {
  final _wordFetcher = PublishSubject<WordJson>();

  Stream<WordJson> get getWord => _wordFetcher.stream;

  fetchWordBloc(String word) async {
    WordJson data;
    if (repository.dbHelper.contains(word)) {
      data = await repository.dbHelper.getWord(word).toWordJson();
      data.setFavor(true);
    } else {
      data = await repository.fetchWordAPI(word);
      data.setFavor(false);
    }
    _wordFetcher.sink.add(data);
  }

  dispose() {
    _wordFetcher.close();
  }
}

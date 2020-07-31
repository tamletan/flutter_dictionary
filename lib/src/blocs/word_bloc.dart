import 'dart:async';

import 'package:rxdart/rxdart.dart' show PublishSubject;

import '../models/word_json.dart' show WordJson;
import '../resources/repository.dart';
import '../resources/service_locator.dart';

class WordBloc {
  final _wordFetcher = PublishSubject<WordJson>();

  Stream<WordJson> get getWord => _wordFetcher.stream;

  fetchWordBloc(String word) async {
    WordJson data = await getIt<Repository>().fetchWord(word);
    _wordFetcher.sink.add(data);
  }

  dispose() {
    _wordFetcher.close();
  }
}

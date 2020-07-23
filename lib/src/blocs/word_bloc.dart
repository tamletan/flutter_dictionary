import 'dart:async';

import 'package:rxdart/rxdart.dart' show PublishSubject;

import '../models/word_detail.dart' show WordDetail;
import '../resources/repository.dart';

class WordBloc {
  final _wordFetcher = PublishSubject<WordDetail>();

  Stream<WordDetail> get getWord => _wordFetcher.stream;

  fetchWordBloc(String word) async {
    WordDetail data = await repository.fetchWordAPI(word);
    _wordFetcher.sink.add(data);
  }

  dispose() {
    _wordFetcher.close();
  }
}

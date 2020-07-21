import 'dart:async';

import 'package:flutter_dictionary/src/models/search_cache.dart';
import 'package:flutter_dictionary/src/resources/word_api_provider.dart';
import 'package:rxdart/rxdart.dart';

import '../models/word_detail.dart';
import '../resources/repository.dart';

class WordBloc {
  final _repository = Repository(
    WordApiProvider(),
    SearchCache(),
  );
  final _wordFetcher = PublishSubject<WordDetail>();

  Stream<WordDetail> get getWord => _wordFetcher.stream;

  fetchWordBloc(String word) async {
    WordDetail data = await _repository.fetchWordAPI(word);
    _wordFetcher.sink.add(data);
  }

  dispose() {
    _wordFetcher.close();
  }
}

final bloc = WordBloc();

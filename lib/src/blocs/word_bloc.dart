import 'dart:async';

import 'package:rxdart/rxdart.dart' show PublishSubject;

import '../models/search/search_cache.dart';
import '../models/word_detail.dart' show WordDetail;
import '../resources/repository.dart';
import '../resources/word_api_provider.dart';

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

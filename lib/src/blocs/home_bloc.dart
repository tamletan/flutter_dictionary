import 'package:flutter_dictionary/src/models/database/word_db.dart';
import 'package:rxdart/rxdart.dart';

import '../resources/repository.dart';

class HomeBloc {
  final _wordFetcher = PublishSubject<List<HistoryWord>>();

  Stream<List<HistoryWord>> get getWord => _wordFetcher.stream;

  fetchWordBloc() async {
    List<HistoryWord> data = await repository.getWordDB();
    _wordFetcher.sink.add(data);
  }

  dispose() {
    _wordFetcher.close();
  }
}

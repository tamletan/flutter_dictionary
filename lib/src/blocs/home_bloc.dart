import 'package:flutter_dictionary/src/models/database/word_db.dart';
import 'package:rxdart/rxdart.dart';

import '../resources/repository.dart';

class HomeBloc {
  final _wordFetcher = PublishSubject<List<WordDB>>();

  Stream<List<WordDB>> get getWord => _wordFetcher.stream;

  fetchWordBloc() async {
    List<WordDB> data = await repository.getWordDB();
    _wordFetcher.sink.add(data);
  }

  dispose() {
    _wordFetcher.close();
  }
}

final homeBloc = HomeBloc();
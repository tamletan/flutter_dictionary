import 'package:rxdart/rxdart.dart';

import '../models/database/word_db.dart';
import '../resources/repository.dart';
import '../resources/service_locator.dart';

class HomeBloc {
  final _wordFetcher = PublishSubject<List<WordDB>>();

  Stream<List<WordDB>> get getWord => _wordFetcher.stream;

  fetchWordBloc() async {
    List<WordDB> data = await getIt<Repository>().getWordDB();
    _wordFetcher.sink.add(data);
  }

  dispose() {
    _wordFetcher.close();
  }
}

//final homeBloc = HomeBloc();

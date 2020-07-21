import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dictionary/src/models/search_detail.dart';
import 'package:rxdart/rxdart.dart';

import '../models/word_detail.dart';
import '../models/word_search_state.dart';
import '../resources/repository.dart';

class WordSearchBloc extends Bloc<WordSearchEvent, WordSearchState> {
  final _repository = Repository();

  WordSearchBloc() : super(WordSearchState.initial());

//  @override
//  // ignore: must_call_super
//  void onTransition(Transition<WordSearchEvent, WordSearchState> transition) {
//    print(transition.toString());
//  }

  @override
  Stream<Transition<WordSearchEvent, WordSearchState>> transformEvents(
      Stream<WordSearchEvent> events,
      TransitionFunction<WordSearchEvent, WordSearchState> transitionFn) {
    return super.transformEvents(
      events.debounceTime(const Duration(seconds: 1)),
      transitionFn,
    );
  }

  @override
  Stream<WordSearchState> mapEventToState(WordSearchEvent event) async* {
    yield WordSearchState.loading();

    try {
      SearchDetail words = await _getSearchResults(event.query);
      yield WordSearchState.success(words);
    } catch (_) {
      yield WordSearchState.error();
    }
  }

  Future<SearchDetail> _getSearchResults(String query) async {
    return _repository.searchWordAPI(query);
  }
}

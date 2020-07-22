import 'package:flutter/cupertino.dart' show TextEditingController;
import 'package:flutter_bloc/flutter_bloc.dart'
    show Bloc, Transition, TransitionFunction;
import 'package:rxdart/rxdart.dart' show DebounceExtensions;

import '../models/search/search_result_error.dart';
import '../models/search/word_search_event.dart';
import '../models/search/word_search_state.dart';
import '../resources/repository.dart';

class WordSearchBloc extends Bloc<WordSearchEvent, WordSearchState> {
  final Repository repository;
  final TextEditingController textController;

  WordSearchBloc(this.repository, this.textController) : super(null);

  WordSearchState get initialState => SearchStateEmpty();

  @override
  void onTransition(Transition<WordSearchEvent, WordSearchState> transition) {
    print(transition.toString());
    super.onTransition(transition);
  }

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
  Stream<WordSearchState> mapEventToState(
    WordSearchEvent event,
  ) async* {
    if (event is TextChanged) {
      final String searchTerm = event.query;
      if (searchTerm.isEmpty) {
        yield SearchStateEmpty();
      } else {
        yield SearchStateLoading();
        try {
          final results = await repository.searchWordAPI(searchTerm);
          yield SearchStateSuccess(results);
        } catch (error) {
          yield error is SearchResultError
              ? SearchStateError(error.message)
              : SearchStateError('something went wrong');
        }
      }
    }
  }
}

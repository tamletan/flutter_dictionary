import 'package:flutter_bloc/flutter_bloc.dart'
    show Bloc, Transition, TransitionFunction;
import 'package:rxdart/rxdart.dart' show DebounceExtensions;

import '../models/search/search_result_error.dart';
import '../models/search/word_search_event.dart';
import '../models/search/word_search_state.dart';
import '../resources/repository.dart';
import '../resources/service_locator.dart';

class WordSearchBloc extends Bloc<WordSearchEvent, WordSearchState> {
  WordSearchBloc() : super(SearchStateEmpty());

//  @override
//  void onTransition(Transition<WordSearchEvent, WordSearchState> transition) {
//    print(transition.toString());
//    super.onTransition(transition);
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
          final results =
              await getIt<Repository>().searchWordAPI(searchTerm);
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

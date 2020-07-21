import 'package:flutter_dictionary/src/models/search_detail.dart';

class WordSearchEvent {
  final String query;

  const WordSearchEvent(this.query);

  @override
  String toString() => 'WordSearchEvent { query: $query }';
}

class WordSearchState {
  final bool isLoading;
  final SearchDetail words;
  final bool hasError;

  const WordSearchState({this.isLoading, this.words, this.hasError});

  factory WordSearchState.initial() {
    return WordSearchState(
      words: null,
      isLoading: false,
      hasError: false,
    );
  }

  factory WordSearchState.loading() {
    return WordSearchState(
      words: null,
      isLoading: true,
      hasError: false,
    );
  }

  factory WordSearchState.success(SearchDetail words) {
    return WordSearchState(
      words: words,
      isLoading: false,
      hasError: false,
    );
  }

  factory WordSearchState.error() {
    return WordSearchState(
      words: null,
      isLoading: false,
      hasError: true,
    );
  }

  @override
  String toString() =>
      'WordSearchState {words: ${words?.printList()}, isLoading: $isLoading, hasError: $hasError }';
}

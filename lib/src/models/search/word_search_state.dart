import 'package:equatable/equatable.dart' show Equatable;
import '../search/search_detail.dart' show SearchJson;

abstract class WordSearchState extends Equatable {
  const WordSearchState();

  @override
  List<Object> get props => [];
}

class SearchStateEmpty extends WordSearchState {}

class SearchStateLoading extends WordSearchState {}

class SearchStateSuccess extends WordSearchState {
  final SearchJson items;

  const SearchStateSuccess(this.items);

  @override
  List<Object> get props => [items];

  @override
  String toString() => 'SearchStateSuccess { items: ${items.results.data.length} }';
}

class SearchStateError extends WordSearchState {
  final String error;

  const SearchStateError(this.error);

  @override
  List<Object> get props => [error];
}

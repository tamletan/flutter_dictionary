import 'package:equatable/equatable.dart';
import 'search_detail.dart';

abstract class WordSearchState extends Equatable {
  const WordSearchState();

  @override
  List<Object> get props => [];
}

class SearchStateEmpty extends WordSearchState {}

class SearchStateLoading extends WordSearchState {}

class SearchStateSuccess extends WordSearchState {
  final SearchDetail items;

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

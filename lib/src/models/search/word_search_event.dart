import 'package:equatable/equatable.dart' show Equatable;

abstract class WordSearchEvent extends Equatable {
  const WordSearchEvent();
}

class TextChanged extends WordSearchEvent {
  final String query;

  const TextChanged({this.query});

  @override
  List<Object> get props => [query];

  @override
  String toString() => 'TextChanged { query: $query }';
}

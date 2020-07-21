import 'dart:async';

import 'package:flutter_dictionary/src/models/search_detail.dart';
import 'package:flutter_dictionary/src/resources/word_api_provider.dart';

import '../models/word_detail.dart';

class Repository {
  final wordApiProvider = WordApiProvider();

  Future<WordDetail> fetchWordAPI(String word) =>
      wordApiProvider.fetchWord(word);

  Future<SearchDetail> searchWordAPI(String query) =>
      wordApiProvider.searchWord(query);
}

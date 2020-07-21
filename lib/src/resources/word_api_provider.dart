import 'dart:async';

import 'package:dio/dio.dart';

import '../models/search_detail.dart';
import '../models/word_detail.dart';
import 'utils.dart';

class WordApiProvider {
  Dio dio = Dio()
    ..options.baseUrl = '$BASE_URL'
    ..options.headers['$TOKEN_HOST'] = '$HOST'
    ..options.headers['$TOKEN_APIKEY'] = '$APIKEY';

  Future<WordDetail> fetchWord(String word) async {
    try {
      final response = await dio.get("/$word");
      dynamic pro = response.data['pronunciation'];
      if (pro is String){
        Map<String, dynamic> alter = {"all":"$pro",};
        response.data['pronunciation'] = alter;
      }
      WordDetail results = WordDetail.fromJson(response.data);
      return results;
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return WordDetail.withError("$error");
    }
  }

  Future<SearchDetail> searchWord(String query) async {
    var params = <String, String>{
      'letterPattern': '^$query\\w*\$',
      'limit': '$Search_Limit'
    };
    try {
      final response = await dio.get("/", queryParameters: params);
      SearchDetail results = SearchDetail.fromJson(response.data);
      return results;
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return SearchDetail.withError("$error");
    }
  }
}

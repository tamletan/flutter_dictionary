import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart' show Dio;

import '../models/database/word_db.dart';
import '../models/search/search_detail.dart' show SearchJson;
import '../models/word_json.dart' show WordJson;
import '../resources/repository.dart';
import '../resources/service_locator.dart';
import 'utils.dart';

class WordApiProvider {
  Dio dio = Dio()
    ..options.baseUrl = '$BASE_URL'
    ..options.headers['$TOKEN_HOST'] = '$HOST'
    ..options.headers['$TOKEN_APIKEY'] = '$APIKEY';

  Future<WordJson> fetchWord(String word) async {
    try {
      final response = await dio.get("/$word");
      dynamic pro = response.data['pronunciation'];
      if (pro is! Map<String, dynamic>) {
        Map<String, dynamic> alter = {"all": "$pro"};
        response.data['pronunciation'] = alter;
      }
      getIt.get<Repository>().word_recent = WordDB(
          word: response.data['word'],
          pronunciation: json.encode(response.data['pronunciation']),
          results: response.data['results'] == null
              ? "[]"
              : json.encode(response.data['results']));

      WordJson results = WordJson.fromJson(response.data);
      return results;
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return WordJson.withError("$error");
    }
  }

  Future<SearchJson> searchWord(String query) async {
    var params = <String, String>{
      'letterPattern': '^$query\\w*\$',
      'limit': '$Search_Limit'
    };
    try {
      final response = await dio.get("/", queryParameters: params);
      SearchJson results = SearchJson.fromJson(response.data);
      return results;
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return SearchJson.withError("$error");
    }
  }
}

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dictionary/src/models/word_search_event.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../blocs/word_search_bloc.dart';
import '../models/word_detail.dart';
import '../models/word_search_state.dart';
import 'WordScreen.dart';

class WordSearch extends SearchDelegate<WordDetail> {
  final WordSearchBloc wordBloc;
  String _recent;
  List<String> _history;
  final key = 'word_history';

  WordSearch(this.wordBloc);

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      primaryColor: Colors.blueAccent,
      primaryIconTheme: IconThemeData(color: Colors.white),
      primaryColorBrightness: Brightness.light,
      textTheme:
          TextTheme(headline6: TextStyle(color: Colors.white, fontSize: 25)),
      inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(color: Color.fromARGB(90, 255, 255, 255))),
      cursorColor: Colors.white,
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        _saveHistory();
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
//    if (_recent != query && query.trim() != "") {
//      wordBloc.add(WordSearchEvent(query));
//      _recent = query;
//    }
//
//    if (query.trim() == "") {
//      return buildHistory();
//    }
//
//    return BlocBuilder(
//        bloc: wordBloc,
//        builder: (BuildContext context, WordSearchState state) {
//          if (state.hasError)
//            return Container(child: Center(child: Text('Error')));
//          if (state.words == null || state.isLoading)
//            return Center(child: CircularProgressIndicator());
//          return ListView.builder(
//              itemCount: state.words?.results?.data?.length ?? 1,
//              itemBuilder: (context, index) {
//                String word = state.words?.results?.data?.elementAt(index);
//                return (word == null)
//                    ? SizedBox()
//                    : ListTile(
//                        leading: Icon(Icons.search),
//                        trailing: buildTrailingIcon(word),
//                        title: RichText(
//                            text: TextSpan(children: <TextSpan>[
//                          TextSpan(
//                              text: word.contains(query) ? query : "",
//                              style:
//                                  TextStyle(fontSize: 18, color: Colors.black)),
//                          TextSpan(
//                              text: word.contains(query)
//                                  ? word.substring(query.length)
//                                  : word,
//                              style:
//                                  TextStyle(fontSize: 18, color: Colors.grey)),
//                        ])),
//                        onTap: () async {
//                          var selected = await openWordScreen(context, word);
//                          _history.insert(0, selected);
//                        });
//              });
//        });
  }

  Widget buildHistory() {
    return FutureBuilder(
        future: _loadHistory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          if (snapshot.hasError)
            return Center(child: Text('Error: ${snapshot.error}'));
          if (_history.length == 0) return SizedBox();
          return ListView.builder(
              itemCount: (_history.length > 10) ? 10 : _history.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.history),
                  trailing: buildTrailingIcon(_history[index]),
                  title: Text(_history[index]),
                  onTap: () async =>
                      await openWordScreen(context, _history[index]),
                );
              });
        });
  }

  Future openWordScreen(BuildContext context, String word) {
    return Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (_) => SafeArea(child: WordScreen(word: word))));
  }

  Transform buildTrailingIcon(String q) {
    return Transform.rotate(
      angle: 270 * pi / 180,
      child: IconButton(
        icon: Icon(Icons.call_made),
        onPressed: () => query = q,
      ),
    );
  }

  Future<List<String>> _loadHistory() async {
    if (_history == null) {
      final prefs = await SharedPreferences.getInstance();
      _history = prefs.getStringList(key) ?? <String>[];
//      print('read: $_history');
    }
    return _history;
  }

  Future _saveHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final value = _history.length > 10 ? _history.sublist(0, 10) : _history;
    prefs.setStringList(key, value);
//    print('saved $value');
  }
}

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/word_search_bloc.dart';
import '../models/search_cache.dart';
import '../models/word_detail.dart';
import '../resources/repository.dart';
import '../resources/word_api_provider.dart';
import 'SearchForm.dart';
import 'SearchScreen.dart';

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = TextStyle(fontSize: 18.0);
  final repository = Repository(
    WordApiProvider(),
    SearchCache(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        title: Text('Startup Word Generator'),
//        actions: <Widget>[
//          IconButton(
//            icon: Icon(
//              Icons.search,
//              color: Colors.white,
//            ),
//            onPressed: () {
//              showSearch<WordDetail>(
//                context: context,
//                delegate: WordSearch(BlocProvider.of<WordSearchBloc>(context)),
//              );
//            },
//          )
//        ],
//      ),
//      body: _buildSuggestions(),
      body: BlocProvider(
        create: (context) => WordSearchBloc(repository),
        child: SearchForm(),
      ),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return Divider();
          /*2*/

          final index = i ~/ 2; /*3*/
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10)); /*4*/
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
    );
  }
}

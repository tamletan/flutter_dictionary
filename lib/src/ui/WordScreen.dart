import 'package:flutter/material.dart';
import 'package:flutter_dictionary/src/models/database/word_db.dart';
import 'package:flutter_dictionary/src/resources/repository.dart';

import '../blocs/word_bloc.dart';
import '../models/word_detail.dart' show WordDetail;

class WordScreen extends StatefulWidget {
  final String word;
  bool isSaved;

  WordScreen({Key key, @required this.word, @required this.isSaved})
      : super(key: key);

  @override
  _WordScreenState createState() => _WordScreenState();
}

class _WordScreenState extends State<WordScreen> {
  final _biggerFont = TextStyle(fontSize: 18.0);
  final wordBloc = WordBloc();

  @override
  void initState() {
    super.initState();
    wordBloc.fetchWordBloc(widget.word);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: wordBloc.getWord,
        builder: (context, AsyncSnapshot<WordDetail> snapshot) {
          if (snapshot.hasData) {
            return buildListView(snapshot);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        });
  }

  Widget buildListView(AsyncSnapshot<WordDetail> snapshot) {
    return WillPopScope(
      onWillPop: () async {
        repository.dbHelper.saveWord(HistoryWord(
          word: snapshot.data.word,
          all: snapshot.data.pronunciation?.all,
        ));
        Navigator.pop(context, snapshot.data);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "${snapshot.data.word}   /${snapshot.data.pronunciation?.all}/",
            style: TextStyle(fontSize: 25, color: Colors.white),
          ),
          actions: <Widget>[
            IconButton(
              key: Key("fav"),
              icon: widget.isSaved ? Icon(Icons.star) : Icon(Icons.star_border),
              onPressed: () {
                setState(() {
                  widget.isSaved = !(widget.isSaved);
                });
              },
            )
          ],
        ),
        body: (snapshot.data.results?.length == 0)
            ? SingleChildScrollView(
                child: Center(
                  child: Text('No Result', style: _biggerFont),
                  heightFactor: 20,
                ),
              )
            : buildWordView(snapshot),
      ),
    );
  }

  ListView buildWordView(AsyncSnapshot<WordDetail> snapshot) {
    return ListView.separated(
        separatorBuilder: (context, index) => Divider(
              height: 5,
              color: Colors.black,
              thickness: 5,
            ),
        itemCount: snapshot.data.results.length,
        itemBuilder: (BuildContext context, int index) {
          return ListBody(
            children: <Widget>[
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(10),
                child: ListTile(
                  title: Text(
                    snapshot.data.results[index].definition ?? "null",
                    style: _biggerFont,
                  ),
                  subtitle: Text(
                    snapshot.data.results[index].partOfSpeech ?? "null",
                    style: TextStyle(fontSize: 15, color: Colors.deepOrange),
                  ),
                ),
              )
            ],
          );
        });
  }
}

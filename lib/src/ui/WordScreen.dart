import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dictionary/src/models/database/word_db.dart';
import 'package:flutter_dictionary/src/resources/repository.dart';

import '../blocs/word_bloc.dart';
import '../models/word_json.dart' show WordJson;

class WordScreen extends StatefulWidget {
  @override
  _WordScreenState createState() => _WordScreenState();
}

class _WordScreenState extends State<WordScreen> {
  final _biggerFont = TextStyle(fontSize: 18.0);
  final wordBloc = WordBloc();
  String word;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Map<String, dynamic> rcvdData =
        ModalRoute.of(context).settings.arguments;
    word = rcvdData['word'];
    wordBloc.fetchWordBloc(word);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: wordBloc.getWord,
        builder: (context, AsyncSnapshot<WordJson> snapshot) {
          if (snapshot.hasError)
            return Text(snapshot.error.toString());
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          return buildListView(snapshot);
        });
  }

  Widget buildListView(AsyncSnapshot<WordJson> snapshot) {
    return WillPopScope(
      onWillPop: () async {
        WordDB w = WordDB.cast(snapshot.data);
        bool a = repository.dbHelper.contains(snapshot.data.word);
        if (!a && snapshot.data.isFavor) repository.saveWordToDB(w);
        if (a && !(snapshot.data.isFavor)) repository.deleteWordsFromDB(w);
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
              icon: snapshot.data.isFavor
                  ? Icon(Icons.star)
                  : Icon(Icons.star_border),
              onPressed: () {
                setState(() {
                  snapshot.data.isFavor = !snapshot.data.isFavor;
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

  ListView buildWordView(AsyncSnapshot<WordJson> snapshot) {
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../blocs/word_bloc.dart';
import '../models/database/word_db.dart';
import '../models/word_json.dart' show WordJson;
import '../resources/repository.dart';
import '../resources/service_locator.dart';

class WordScreen extends StatefulWidget {
  final String word;

  WordScreen({Key key, this.word}) : super(key: key);

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
        builder: (context, AsyncSnapshot<WordJson> snapshot) {
          if (snapshot.hasError) return Text(snapshot.error.toString());
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          return buildListView(snapshot);
        });
  }

  Widget buildListView(AsyncSnapshot<WordJson> snapshot) {
    return WillPopScope(
      onWillPop: () async {
        WordDB w = WordDB.cast(snapshot.data);
        bool a = getIt<Repository>().dbHelper.contains(snapshot.data.word);
        if (!a && snapshot.data.isFavor)
          getIt<Repository>().saveWordToDB(w);
        if (a && !(snapshot.data.isFavor))
          getIt<Repository>().deleteWordsFromDB(w);

        Navigator.pop(context, w);
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

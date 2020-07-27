import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../blocs/home_bloc.dart';
import '../models/database/word_db.dart';

class FavorWordScreen extends StatefulWidget {
  @override
  _FavorWordScreenState createState() => _FavorWordScreenState();
}

class _FavorWordScreenState extends State<FavorWordScreen> {
  @override
  void initState() {
    super.initState();
    homeBloc.fetchWordBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite"),
      ),
      body: StreamBuilder(
          stream: homeBloc.getWord,
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? buildListView(snapshot.data)
                : Center(child: new CircularProgressIndicator());
          }),
    );
  }

  ListView buildListView(List<WordDB> words) {
    return ListView.builder(
        itemCount: words == null ? 0 : words.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(words[index].word),
            subtitle: Text("/${words[index].pronunciation}/"),
            onTap: () async {
              await Navigator.pushNamed(
                  context, 'word/${words[index].word}');
              homeBloc.fetchWordBloc();
            },
          );
        });
  }
}

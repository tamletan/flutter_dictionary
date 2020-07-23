import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dictionary/src/blocs/home_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../blocs/word_search_bloc.dart';
import '../models/database/word_db.dart' show HistoryWord;
import 'SearchBar.dart' show SearchBar;
import 'WordScreen.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final textController = TextEditingController();
  final homeBloc = HomeBloc();

  @override
  void initState() {
    super.initState();
    homeBloc.fetchWordBloc();
  }

  @override
  Widget build(BuildContext context) {
    var logo = SvgPicture.asset("assets/logo.svg");
    return Scaffold(
      appBar: AppBar(
        title: logo,
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(58.0),
          child: buildSearch(),
        ),
      ),
      body: StreamBuilder(
          stream: homeBloc.getWord,
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? UserList(snapshot.data)
                : Center(child: new CircularProgressIndicator());
          }),
    );
  }

  Widget buildSearch() {
    return BlocProvider(
      create: (context) => WordSearchBloc(textController),
      child: SearchBar(),
    );
  }
}

class UserList extends StatelessWidget {
  final List<HistoryWord> words;

  UserList(this.words, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: words == null ? 0 : words.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(words[index].word),
            subtitle: Text("/${words[index].all}/"),
            onTap: () => Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (_) => SafeArea(
                            child: WordScreen(
                          word: words[index].word,
                          isSaved: true,
                        )))),
          );
        });
  }
}

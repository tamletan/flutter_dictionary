import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../blocs/home_bloc.dart';
import '../blocs/word_search_bloc.dart';
import 'SearchBar.dart' show SearchBar;

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final textController = TextEditingController();

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
          preferredSize: Size.fromHeight(48.0),
          child: buildSearch(),
        ),
      ),
      body: buildHorizontalListView(),
    );
  }

  Widget buildSearch() {
    return BlocProvider(
      create: (context) => WordSearchBloc(textController),
      child: SearchBar(),
    );
  }

  Widget buildHorizontalListView() {
    return ListView(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      children: <Widget>[
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: Theme.of(context).primaryColorDark,
          child: ListTile(
            title: Text(
              "Favorite",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            onTap: () => Navigator.pushNamed(context, '/favor'),
          ),
        )
      ],
    );
  }
}

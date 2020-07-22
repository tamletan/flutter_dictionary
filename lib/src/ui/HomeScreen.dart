import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocProvider;
import 'package:flutter_svg/flutter_svg.dart' show SvgPicture;

import '../blocs/word_search_bloc.dart';
import '../models/search/search_cache.dart';
import '../resources/repository.dart';
import '../resources/word_api_provider.dart';
import 'SearchBar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final repository = Repository(
    WordApiProvider(),
    SearchCache(),
  );
  final textController = TextEditingController();

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
      backgroundColor: Colors.amberAccent,
//      body: buildSearch(),
    );
  }

  Widget buildSearch() {
    return BlocProvider(
      create: (context) => WordSearchBloc(repository, textController),
      child: SearchBar(),
    );
  }
}

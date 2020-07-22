import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/word_search_bloc.dart';
import '../models/search_cache.dart';
import '../resources/repository.dart';
import '../resources/word_api_provider.dart';
import 'SearchForm.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final repository = Repository(
    WordApiProvider(),
    SearchCache(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search')),
      body: BlocProvider(
        create: (context) => WordSearchBloc(repository),
        child: SearchForm(),
      ),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return ListView(
      scrollDirection: Axis.vertical,
      children: <Widget>[
        SearchForm(),
        Container(color: Colors.red, width: mediaQuery.size.width, height: mediaQuery.size.height,),
      ],
    );
  }
}
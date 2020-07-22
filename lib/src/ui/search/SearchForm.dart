import 'dart:math' show pi;

import 'package:flutter/cupertino.dart' show CupertinoPageRoute;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocProvider, BlocBuilder;

import '../../blocs/word_search_bloc.dart';
import '../../models/search/word_search_event.dart';
import '../../models/search/word_search_state.dart';
import '../WordScreen.dart';

part 'SearchBar.dart';

part 'SearchBody.dart';

class SearchForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[_SearchBar(), _SearchBody()],
    );
  }
}

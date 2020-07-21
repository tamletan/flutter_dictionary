import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/word_search_bloc.dart';
import 'ui/RandomWord.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Dictionary",
      theme: ThemeData.light(),
      home: SafeArea(
        child: RandomWords(),
      ),
    );
  }
}

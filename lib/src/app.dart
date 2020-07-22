import 'package:flutter/material.dart';

import 'ui/HomeScreen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Dictionary",
      theme: ThemeData.light(),
      home: SafeArea(
        child: HomeScreen(),
      ),
    );
  }
}

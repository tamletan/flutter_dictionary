import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ui/HomeScreen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Dictionary",
      theme: ThemeData(
        primaryColor: Color(0xFF02BB9F),
        primaryColorDark: const Color(0xFF167F67),
        accentColor: const Color(0xFFFFAD32),
      ),
      home: SafeArea(child: MyHomePage(title: 'Flutter Database')),
    );
  }
}

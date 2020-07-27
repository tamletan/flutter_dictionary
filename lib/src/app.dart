import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'models/router.dart';
import 'ui/HomeScreen.dart';
import 'ui/NoPage.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Dictionary",
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFDDE6E6),
        primaryTextTheme: TextTheme(
          headline6: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        primaryIconTheme: IconThemeData(color: Colors.white),
        primaryColor: Color(0xFF02BB9F),
        primaryColorDark: const Color(0xFF167F67),
        accentColor: const Color(0xFFFFAD32),
      ),
      initialRoute: 'home',
      onGenerateRoute: FluroRouter.router.generator,
      onUnknownRoute: (settings) {
        return CupertinoPageRoute(
            builder: (_) => SafeArea(child: NoPage()), settings: settings);
      },
    );
  }
}

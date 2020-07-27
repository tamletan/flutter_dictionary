import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import '../ui/FavorWordScreen.dart';
import '../ui/HomeScreen.dart';
import '../ui/WordScreen.dart';

class FluroRouter {
  static Router router = Router();
  static Handler _homeHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          SafeArea(child: HomeScreen(title: 'Flutter Database')));
  static Handler _wordHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          SafeArea(child: WordScreen(word: params['word'][0])));
  static Handler _favWordHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          SafeArea(child: FavorWordScreen()));

  static void setupRouter() {
    router.define(
      'home',
      handler: _homeHandler,
      transitionType: TransitionType.fadeIn,
    );
    router.define(
      'word/:word',
      handler: _wordHandler,
      transitionType: TransitionType.material,
    );
    router.define(
      'fav',
      handler: _favWordHandler,
      transitionType: TransitionType.cupertino,
    );
  }
}

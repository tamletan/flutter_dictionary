import 'package:flutter/material.dart';

import 'src/app.dart';
import 'src/blocs/home_bloc.dart';
import 'src/models/fluro_router.dart';
import 'src/resources/repository.dart';

void main() {
  _init();
}

void _init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await repository.dbHelper.open();
  FluroRouter.setupRouter();
  homeBloc.fetchWordBloc();
  runApp(App());
}

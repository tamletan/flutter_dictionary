import 'package:flutter/material.dart';

import 'src/app.dart';
import 'src/blocs/home_bloc.dart';
import 'src/models/fluro_router.dart';
import 'src/resources/repository.dart';
import 'src/resources/service_locator.dart';

void main() {
  _init();
}

void _init() async {
  WidgetsFlutterBinding.ensureInitialized();
  FluroRouter.setupRouter();
  setupLocator();
  getIt<Repository>().dbHelper.open();
  getIt<HomeBloc>().fetchWordBloc();
  runApp(App());
}

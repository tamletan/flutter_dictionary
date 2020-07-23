import 'package:flutter/material.dart';
import 'package:flutter_dictionary/src/resources/repository.dart';

import 'src/app.dart';

void main() {
  _init();
}

void _init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await repository.dbHelper.open();
  runApp(App());
}

import 'package:get_it/get_it.dart';

import '../blocs/home_bloc.dart';
import '../models/search/search_cache.dart';
import 'db_helper.dart';
import 'repository.dart';
import 'word_api_provider.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerSingleton<Repository>(
      Repository(WordApiProvider(), SearchCache(), DatabaseHelper()));
  getIt.registerSingleton<HomeBloc>(HomeBloc());
}

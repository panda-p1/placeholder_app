import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:placeholder_app/app.dart';

import 'request_cache_manager/cached_response.dart';
import 'request_cache_manager/request_cache_manager.dart';

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(CachedResponseAdapter());
  await RequestCacheManager.shared.initialize();
  runApp(const App());
}
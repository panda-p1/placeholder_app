

import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:placeholder_app/request_cache_manager/cached_response.dart';

abstract class CacheRequest {
  String get url;
  String get methodStr;
  String get parametersStr;
  Map<String, dynamic>? get body;
  Duration get cacheDuration => Duration.zero;
}

class RequestCacheManager {
  const RequestCacheManager._();
  static const shared = RequestCacheManager._();

  static const _boxKey = 'RequestBox';
  Box<CachedResponse> get box => Hive.box<CachedResponse>(_boxKey);

  Future<void> initialize() async {
    if(!Hive.isBoxOpen(_boxKey)) {
      await Hive.openBox<CachedResponse>(_boxKey);
    }
  }

  CachedResponse getCached(CacheRequest request) {
    final id = _makeId(request);
    return box.get(id)!;
  }

  void cache(CacheRequest request, dynamic content) {
    final id = _makeId(request);

    final cachedResponse = CachedResponse(
      duration: request.cacheDuration,
      content: content,
      dateTime: DateTime.now(),
    );

    box.put(id, cachedResponse);
  }

  bool isCached(CacheRequest request) {
    final id = _makeId(request);
    return box.get(id) != null;
  }

  String _makeId(CacheRequest request) {
    final key = request.url + request.methodStr + (request.body?.toString() ?? '') + request.parametersStr;
    return md5.convert(utf8.encode(key)).toString();
  }
}
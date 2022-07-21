import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:placeholder_app/api/base/provider_response.dart';
import 'package:placeholder_app/enums/http_method.dart';
import 'package:placeholder_app/request_cache_manager/request_cache_manager.dart';


abstract class HttpRequest implements CacheRequest {
  const HttpRequest();

  @override
  String get parametersStr => parameters?.toString() ?? '';

  @override
  String get methodStr => method.name;

  @override
  Duration get cacheDuration => const Duration(minutes: 1);
  bool get isCacheable => false;

  RequestMethod get method => RequestMethod.GET;
  Map<String, String>? get headers  => null;
  String get url;
  Map<String, dynamic>? get body => null;
  Map<String, dynamic>? get parameters => null;
}

abstract class CacheableNetManager extends NetManager {
  const CacheableNetManager();

  @override
  Future<ProviderResponse> fetch(HttpRequest request) async {
    if(!request.isCacheable) {
      final response = await super.fetch(request);
      return response;
    }

    const cacheManager = RequestCacheManager.shared;

    if(cacheManager.isCached(request)) {
      final response = cacheManager.getCached(request);
      if(response.isValid()) {
        return ProviderResponse(
          success: true,
          content: response.content,
        );
      }
    }

    final response = await super.fetch(request);
    if(response.isSuccess()) {
      cacheManager.cache(request, response.content);
    }
    return response;
  }
}

abstract class NetManager {
  const NetManager();

  Future<ProviderResponse> fetch(HttpRequest request,) async {
    final url = Uri.parse(request.url).replace(
      queryParameters: request.parameters,
    );

    final http.Response response;

    switch(request.method) {
      case RequestMethod.GET:
        response = await http.get(
          url,
          headers: request.headers,
        ).timeout(const Duration(seconds: 10));
        break;
      case RequestMethod.POST:
        response = await http.post(
          url,
          headers: request.headers,
          body: request.body,
        ).timeout(const Duration(seconds: 10));
        break;
    }

    final decoded = jsonDecode(response.body);
    if(response.statusCode >= 200 && response.statusCode < 300) {
      return ProviderResponse(
        content: decoded,
        success: true,
      );
    }

    return const ProviderResponse(
      success: false,
    );
  }
}
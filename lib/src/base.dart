library flickr.base;

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

final _METHOD_PARAMS_KEY = 'method';
final FLICKR_HOST = "api.flickr.com";
final FLICKR_API_BASE = "services/rest";
final BASE_PARAMS = {
  "format": "json",
  "nojsoncallback": "1",
};

class Client {
  Map baseParams;
  Client(String apiKey) {
    baseParams = new Map.from(BASE_PARAMS);
    baseParams['api_key'] = apiKey;
  }

  Uri buildUriFromParams(Map params) {
    var joinedParams = new Map.from(baseParams);
    params.forEach((k, v) => joinedParams[k] = v);
    return new Uri.https(FLICKR_HOST, FLICKR_API_BASE, joinedParams);
  }

  Future<Map> get(String method, Map<String, String> params) =>
      new Future(() async {
        params[_METHOD_PARAMS_KEY] = method;
        // var queryParameters = new Map.from(baseParams);
        // queryParameters['method'] = method;
        // params.forEach((k, v) => queryParameters[k] = v);
        var uri = buildUriFromParams(params);
        var response = await http.get(uri);
        return JSON.decode(response.body);
      });
}

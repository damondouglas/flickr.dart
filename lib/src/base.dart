library flickr.base;

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

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

  Future<Map> get(String method, Map<String, String> params) =>
      new Future(() async {
        var queryParameters = new Map.from(baseParams);
        queryParameters['method'] = method;
        params.forEach((k, v) => queryParameters[k] = v);
        var uri =
            new Uri.https("api.flickr.com", "services/rest", queryParameters);
        var response = await http.get(uri);
        return JSON.decode(response.body);
      });
}

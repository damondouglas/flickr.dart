library flickr.base;

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

final FLICKR_URL_BASE = "https://api.flickr.com/services/rest/";
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

  Future<Map> get(String method, Map<String, String> params) => new Future(() async {
    params.addAll(baseParams);
    params['method'] = method;
    var uri = new Uri(path: FLICKR_URL_BASE, queryParameters: params);
    var response = await http.get(uri.toString());
    return JSON.decode(response.body);
  });
}

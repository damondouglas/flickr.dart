library flickr_shelf;

import 'dart:async';
import 'dart:convert';
import 'package:shelf/shelf.dart' as shelf;
import 'flickr.dart' as flickr;

final PAGE_KEY = 'p';
final Q_KEY = 'q';

class Flickr {
  String apiKey;
  Flickr(this.apiKey);

  Future<shelf.Response> search(shelf.Request request) async {
    var url = request.url;
    if (_validate(url)) {
      var params = url.queryParameters;
      var q = params[Q_KEY];
      var p = int.parse(params[PAGE_KEY], onError: (_) => 1);
      return _search(apiKey, q, p);
    }
    else return new shelf.Response.forbidden('$url is not valid.');
  }

}

bool _validate(Uri url) {
  return [PAGE_KEY, Q_KEY].every((key) => url.queryParameters.containsKey(key));
}

Future<shelf.Response> _search(String apiKey, String q, int page) async {
  var json = await flickr.search(apiKey, q, page: page);
  var data = JSON.encode(json);
  return new shelf.Response.ok(data);
}

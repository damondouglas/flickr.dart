library flickr_shelf;

import 'dart:async';
import 'dart:convert';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf_route/shelf_route.dart' as route;
import 'flickr.dart' as flickr;

final PAGE_KEY = 'p';
final Q_KEY = 'q';

class Flickr {
  String apiKey;
  Flickr(this.apiKey);

  shelf.Handler get handler => () {
        var router = route.router();
        router
          ..get('/flickr/search', _search)
          ..get('/flickr/photo/{id}', _info)
          ..get('/flickr/license', _license);

        return router.handler;
      }();

  Future<shelf.Response> _search(shelf.Request request) async {
    var params = request.url.queryParameters;
    var q = params['q'];
    var page = int.parse(params['p'], onError: (_) => 1);
    var json = await flickr.search(apiKey, q, page: page);
    var data = JSON.encode(json);
    return new shelf.Response.ok(data);
  }

  Future<shelf.Response> _license(shelf.Request request) async {
    var licenses = await flickr.getAllLicenses(apiKey);
    var json = licenses.map((license) => license.toJson()).toList();
    var data = JSON.encode(json);
    return new shelf.Response.ok(data);
  }

  Future<shelf.Response> _info(shelf.Request request) async {
    var id = route.getPathParameter(request, 'id');
    var json = await flickr.getInfo(apiKey, id);
    var data = JSON.encode(json);
    return new shelf.Response.ok(data);
  }
}

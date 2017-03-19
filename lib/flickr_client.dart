library flickr.client;

import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'package:http/browser_client.dart' as http;
import 'package:flickr/flickr.dart' as flickr show License, SearchResult, SearchResultEntry;

final PAGE_KEY = 'p';
final Q_KEY = 'q';

class FlickrApi {
  String rootUrl;
  String get servicePath => 'flickr';

  FlickrApi(this.rootUrl);

  SearchResourceApi get search => new SearchResourceApi(rootUrl, servicePath, 'search');
}

class SearchResourceApi extends ResourceApi {
  SearchResourceApi(String rootUrl, String servicePath, String methodPath) : super(rootUrl, servicePath, methodPath);

  Future<flickr.SearchResult> search(String q, int p) async {
    var url = buildUriFromParameters({
      PAGE_KEY: p.toString(),
      Q_KEY: q
    });

    var client = new http.BrowserClient();
    var response = await client.get(url);
    var data = response.body;
    var result = JSON.decode(data);
    return new flickr.SearchResult.fromJson(result);
  }
}

class ResourceApi {
  String rootUrl;
  String servicePath;
  String methodPath;
  ResourceApi(this.rootUrl, this.servicePath, this.methodPath);

  Uri buildUriFromParameters(Map parameters) => new Uri.https(rootUrl, "$servicePath/$methodPath", parameters);
}

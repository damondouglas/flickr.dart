library flickr.client;

import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flickr/flickr.dart' as flickr show License, SearchResult, SearchResultEntry;

class FlickrApi {
  String rootUrl;
  String version;
  String get servicePath => 'flickr/$version';

  SearchResourceApi get search => new SearchResourceApi(rootUrl, servicePath, 'search');
}

class SearchResourceApi extends ResourceApi {
  SearchResourceApi(String rootUrl, String servicePath, String methodPath) : super(rootUrl, servicePath, methodPath);
  Future<flickr.SearchResult> search(String q, String p) {
    var url = buildUriFromParameters({

    });
  }
}

class ResourceApi {
  String rootUrl;
  String servicePath;
  String methodPath;
  ResourceApi(this.rootUrl, this.servicePath, this.methodPath);

  Uri buildUriFromParameters(Map parameters) => new Uri.https(rootUrl, "$servicePath/$methodPath", parameters);

}

library flickr.client;

import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'package:http/browser_client.dart' as http;
import 'package:flickr/flickr.dart' as flickr
    show License, SearchResult, SearchResultEntry, Info;

final PAGE_KEY = 'p';
final Q_KEY = 'q';

class FlickrApi {
  String rootUrl;
  String get servicePath => 'flickr';

  FlickrApi(this.rootUrl);

  Future<flickr.SearchResult> search(String q, int p) async {
    var url =
        _buildUriFromParameters('search', {PAGE_KEY: p.toString(), Q_KEY: q});

    var client = new http.BrowserClient();
    var response = await client.get(url);
    var data = response.body;
    var result = JSON.decode(data);
    return new flickr.SearchResult.fromJson(result);
  }

  Future<List<flickr.License>> licenses() async {
    var url = _buildUriFromParameters('license', {});

    var client = new http.BrowserClient();
    var response = await client.get(url);
    var data = response.body;
    return JSON
        .decode(data)
        .map((licenseData) => new flickr.License.from(licenseData))
        .toList();
  }

  Future<flickr.Info> info(String photoId) async {
    var url = _buildUriFromParameters('photo/$photoId', {});

    var client = new http.BrowserClient();
    var response = await client.get(url);
    var data = response.body;
    var result = JSON.decode(data);
    var photo = new flickr.Info.fromJson(result);
    return photo;
  }

  Uri _buildUriFromParameters(String methodPath, Map parameters) =>
      parameters.isNotEmpty
          ? new Uri.https(rootUrl, "$servicePath/$methodPath", parameters)
          : new Uri.https(rootUrl, "$servicePath/$methodPath");
}

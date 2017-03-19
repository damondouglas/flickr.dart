/*
 * see README before running this test.
 */

import 'dart:html';
import 'dart:convert';
import 'dart:async';
import 'package:test/test.dart';
import 'package:flickr/flickr_client.dart' as flickr;
import 'package:flickr/flickr.dart' show License, SearchResult, SearchResultEntry;

final ROOT_URL_KEY_FROM_CONFIG = 'FLICKR_SERVER';

void main() {
  flickr.FlickrApi api;
  setUpAll(() async {
    var configData = await HttpRequest.getString('config.json');
    var config = JSON.decode(configData);
    var rootUrl = config[ROOT_URL_KEY_FROM_CONFIG];
    api = new flickr.FlickrApi(rootUrl);
  });
  group('flickr_client', () {
    test('ResourceApi', (){
      var resource = new flickr.ResourceApi('foo', 'bar', 'baz');
      expect(resource.buildUriFromParameters({'hello':'world'}), new Uri.https('foo', 'bar/baz', {'hello':'world'}));
    });
  });

  group('search', () {
    SearchResult result;
    setUpAll(() async {
      result = await api.search.search('cats', 1);
    });

    test('page is 1', (){
      expect(result.page, 1);
    });

    test('total is > 0', (){
      expect(result.total > 0, isTrue);
      expect(result.entries, isNotEmpty);
    });

    group('first entry', () {
      SearchResultEntry entry;
      setUpAll(() => entry = result.entries.first);

      test('is not empty', (){
        expect(entry, isNotNull);
        expect(entry.smallSquareUri, isNotNull);
      });

      group('url', () {
        ImageElement img;
        setUpAll(() async {
          var completer = new Completer();
          img = new ImageElement();
          img.src = entry.smallSquareUri.toString();
          img.onLoad.listen((_) => completer.complete());
          img.onError.listen((_) => completer.complete());
          var container = querySelector('.container');
          container.children.add(img);
          return completer.future;
        });

        test('loads in browser', (){
          expect(img.naturalHeight, isNonZero);
          expect(img.naturalWidth, isNonZero);
        });
      });
    });
  });
}

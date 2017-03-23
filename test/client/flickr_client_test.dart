/*
 * see README before running this test.
 */

import 'dart:html';
import 'dart:convert';
import 'dart:async';
import 'package:test/test.dart';
import 'package:flickr/flickr_client.dart' as flickr;
import 'package:flickr/flickr.dart'
    show
        License,
        SearchResult,
        SearchResultEntry,
        COMMERCIAL_ALLOWED_LICENSE_IDS;

final ROOT_URL_KEY_FROM_CONFIG = 'FLICKR_SERVER';

void main() {
  flickr.FlickrApi api;
  setUpAll(() async {
    var configData = await HttpRequest.getString('config.json');
    var config = JSON.decode(configData);
    var rootUrl = config[ROOT_URL_KEY_FROM_CONFIG];
    api = new flickr.FlickrApi(rootUrl);
  });

  group('search', () {
    SearchResult result;
    setUpAll(() async {
      result = await api.search('cats', 1);
    });

    test('page is 1', () {
      expect(result.page, 1);
    });

    test('total is > 0', () {
      expect(result.total > 0, isTrue);
      expect(result.entries, isNotEmpty);
    });

    group('first entry', () {
      SearchResultEntry entry;
      setUpAll(() => entry = result.entries.first);

      test('is not empty', () {
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

        test('loads in browser', () {
          expect(img.naturalHeight, isNonZero);
          expect(img.naturalWidth, isNonZero);
        });
      });
    });
  });

  group('license', () {
    List<License> licenses;
    setUpAll(() async {
      licenses = await api.licenses();
    });

    test('gets a nonempty list', () {
      expect(licenses, isNotEmpty);
    });

    test('Commercially allowed is ${COMMERCIAL_ALLOWED_LICENSE_IDS}', () {
      var commerciallyAllowed = licenses
          .where((License license) =>
              COMMERCIAL_ALLOWED_LICENSE_IDS.contains(license.id))
          .toList();
      expect(
          commerciallyAllowed.every((l) => [
                'Attribution License',
                'No known copyright restrictions'
              ].contains(l.name)),
          isTrue);
    });
  });
}

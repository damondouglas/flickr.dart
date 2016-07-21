import 'dart:async';
import 'dart:convert';
import 'common.dart';
import 'package:flickr/src/license.dart' as license;
import 'package:test/test.dart';

void main() {

  String apiKey;
  List _compareAgainst = JSON.decode(_licenseData);

  group('A group of tests', () {
    setUp(() {
      apiKey = getApiKey();
    });

    test('licenses should work', () async {
      var licenseList = await license.getAll(apiKey);
      licenseList.forEach((l1) {
        var id = l1.id;
        var l2 = _compareAgainst.firstWhere((l) => l['id'] == id);
        expect(l2['id'], id);
        expect(l2['name'], l1.name);
        expect(l2['url'], l1.url);
      });
    });
  });
}



final _licenseData = """
[
  { "id": 0, "name": "All Rights Reserved", "url": "" },
  { "id": 4, "name": "Attribution License", "url": "https:\/\/creativecommons.org\/licenses\/by\/2.0\/" },
  { "id": 6, "name": "Attribution-NoDerivs License", "url": "https:\/\/creativecommons.org\/licenses\/by-nd\/2.0\/" },
  { "id": 3, "name": "Attribution-NonCommercial-NoDerivs License", "url": "https:\/\/creativecommons.org\/licenses\/by-nc-nd\/2.0\/" },
  { "id": 2, "name": "Attribution-NonCommercial License", "url": "https:\/\/creativecommons.org\/licenses\/by-nc\/2.0\/" },
  { "id": 1, "name": "Attribution-NonCommercial-ShareAlike License", "url": "https:\/\/creativecommons.org\/licenses\/by-nc-sa\/2.0\/" },
  { "id": 5, "name": "Attribution-ShareAlike License", "url": "https:\/\/creativecommons.org\/licenses\/by-sa\/2.0\/" },
  { "id": 7, "name": "No known copyright restrictions", "url": "https:\/\/www.flickr.com\/commons\/usage\/" },
  { "id": 8, "name": "United States Government Work", "url": "http:\/\/www.usa.gov\/copyright.shtml" },
  { "id": 9, "name": "Public Domain Dedication (CC0)", "url": "https:\/\/creativecommons.org\/publicdomain\/zero\/1.0\/" },
  { "id": 10, "name": "Public Domain Mark", "url": "https:\/\/creativecommons.org\/publicdomain\/mark\/1.0\/" }
]
""";

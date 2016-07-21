library flickr.license;

import 'dart:async';
import 'base.dart' as base;

final _METHOD = "flickr.photos.licenses.getInfo";
final _PARAMS = {};

class License {
  int id;
  String name;
  String url;
  License.from(Map data) {
    id = int.parse(data['id'], onError: (input) => -1);
    name = data['name'];
    url = data['url'];
  }
}

Future<List<License>> getAll(String apiKey) => new Future(() async {
  var client = new base.Client(apiKey);
  var data = await client.get(_METHOD, _PARAMS);
  return data['licenses']['license']
  .map((licenseData) => new License.from(licenseData));
});

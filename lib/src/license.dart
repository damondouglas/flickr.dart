library flickr.license;

import 'dart:async';
import 'base.dart' as base;

final _METHOD = "flickr.photos.licenses.getInfo";
final _PARAMS = {};
final _ID = 'id';
final _NAME = 'name';
final _URL = 'url';
const COMMERCIAL_ALLOWED_LICENSE_IDS = const [4, 7];

class License {
  int id;
  String name;
  String url;
  License.from(Map data) {
    id = int.parse(data[_ID], onError: (input) => -1);
    name = data[_NAME];
    url = data[_URL];
  }
  Map toJson() {
    return {_ID: id, _NAME: name, _URL: url};
  }
}

Future<List<License>> getAllLicenses(String apiKey) => new Future(() async {
      var client = new base.Client(apiKey);
      var data = await client.get(_METHOD, _PARAMS);
      return data['licenses']['license']
          .map((licenseData) => new License.from(licenseData));
    });

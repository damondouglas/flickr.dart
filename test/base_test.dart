import 'dart:async';
import 'common.dart';
import 'package:flickr/src/base.dart' as flickr;
import 'package:test/test.dart';

void main() {
  flickr.Client client;
  String apiKey;

  group('base', () {
    setUp(() {
      apiKey = getApiKey();
      client = new flickr.Client(apiKey);
    });

    test('uri builds with expected params', () {
      var uri = client.buildUriFromParams(
          {"method": "flickr.photos.search", "text": "cats", "license": "4,7"});
      expect(uri.queryParameters["license"], "4,7");
      expect(uri.queryParameters["method"], "flickr.photos.search");
      expect(uri.queryParameters["text"], "cats");
    });

    test('echo responds with api_key', () async {
      var response = await client.get("flickr.test.echo", {});
      expect(response['api_key']['_content'], apiKey);
    });
  });
}

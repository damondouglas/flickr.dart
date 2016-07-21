import 'dart:async';
import 'common.dart';
import 'package:flickr/src/base.dart' as flickr;
import 'package:test/test.dart';

void main() {

  flickr.Client client;
  String apiKey;

  group('A group of tests', () {
    setUp(() {
      apiKey = getApiKey();
      client = new flickr.Client(apiKey);
    });

    test('true is true', () async {
      var response = await client.get("flickr.test.echo", {});
      expect(response['api_key']['_content'], apiKey);
    });
  });
}

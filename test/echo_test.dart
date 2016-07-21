import 'dart:async';
import 'common.dart';
import 'package:flickr/src/echo.dart' as echo;
import 'package:test/test.dart';

void main() {

  String apiKey;

  group('A group of tests', () {
    setUp(() {
      apiKey = getApiKey();
    });

    test('echo should work', () async {
      echo.Echo obj = await echo.getEcho(apiKey);
      expect(obj.apiKey, apiKey);
    });
  });
}

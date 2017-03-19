import 'dart:async';
import 'common.dart';
import 'package:flickr/src/echo.dart' as echo;
import 'package:test/test.dart';

void main() {
  String apiKey;

  group('', () {
    setUp(() {
      apiKey = getApiKey();
    });

    test('echo should echo', () async {
      echo.Echo obj = await echo.getEcho(apiKey);
      expect(obj.apiKey, apiKey);
    });
  });
}

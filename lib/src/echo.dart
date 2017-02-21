library flickr.echo;

import 'dart:async';
import 'base.dart' as base;

final _METHOD = "flickr.test.echo";
final _PARAMS = {};

class Echo {
  String apiKey;
}

Future<Echo> getEcho(String apiKey) => new Future(() async {
      var client = new base.Client(apiKey);
      var data = await client.get(_METHOD, _PARAMS);
      var obj = new Echo();
      obj.apiKey = data['api_key']['_content'];
      return obj;
    });

import 'dart:io';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as io;
import 'package:flickr/flickr_shelf.dart' as flickr;
import 'package:shelf_cors/shelf_cors.dart' as shelf_cors;

main() async {
  var port = 9999;
  var apiKey = Platform.environment['FLICKR_API_KEY'];
  var f = new flickr.Flickr(apiKey);
  var handler = const shelf.Pipeline()
      .addMiddleware(shelf_cors.createCorsHeadersMiddleware())
      .addMiddleware(shelf.logRequests())
      .addHandler(f.handler);

  var server = await io.serve(handler, '0.0.0.0', port);

  server.autoCompress = true;
}

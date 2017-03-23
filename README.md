
# About

[Dartlang](https://www.dartlang.org) wrapper for [flickr API](https://www.flickr.com/services/api/) calls.

# Install

In your `pubspec.yaml`:

```yaml
dependencies:
  flickr:
    git: git@github.com:damondouglas/flickr.dart.git
```

# Documentation

https://damondouglas.github.io/flickr.dart/

# Testing

For tests to pass, set `FLICKR_API_KEY` obtained from [request api key](https://www.flickr.com/services/apps/create/apply/) in your system variables:

`$ export FLICKR_API_KEY="..."`

Then run:

`$ pub run test`

# Server

```dart
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as io;
import 'package:flickr/flickr_shelf.dart' as flickr;

main() {
  var port = 9999;
  var apiKey = Platform.environment['FLICKR_API_KEY'];
  var f = new flickr.Flickr(apiKey);
  var handler = const shelf.Pipeline()
      .addMiddleware(shelf.logRequests())
      .addHandler(f.handler);

  var server = await io.serve(handler, '0.0.0.0', port);
}
```

# Client

```dart
import 'package:flickr/flickr_client.dart' as flickr;

main() async {
  var rootUrl = 'host url without http or https'; // example: morning-true-92723.herokuapp.com
  var api = new flickr.FlickrApi(rootUrl);

  var result = api.search('cats', 1);
  var photos = result.entries;
  var photo = photos.first;
  var smallPhotoUri = photo.smallSquareUri;
}
```


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

# License

MIT License

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

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

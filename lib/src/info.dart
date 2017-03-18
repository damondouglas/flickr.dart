library flickr.info;

import 'dart:async';
import 'base.dart' as base;

final _METHOD = "flickr.photos.getInfo";
final _PARAMS = {};
final _PHOTO_URL_BASE = 'staticflickr.com';
final _OWNER_URL_BASE = 'www.flickr.com';

final PHOTO_KEY = 'photo';
final ID_KEY = 'id';
final PHOTO_ID_KEY = 'photo_id';
final OWNER_KEY = 'owner';
final OWNER_ID_KEY = 'nsid';
final USERNAME_KEY = 'username';
final REALNAME_KEY = 'realname';
final LICENSE_ID_KEY = 'license';
final SECRET_KEY = 'secret';
final SERVER_KEY = 'server';
final FARM_KEY = 'farm';
final ORIGINAL_SECRET_KEY = 'originalsecret';
final ORIGINAL_FORMAT_KEY = 'originalformat';

class Info {
  String id;
  String secret;
  String server;
  String originalSecret;
  String originalFormat;
  int farm;
  int licenseId;
  Owner owner;

  Info.fromJson(Map json) {
    json = json[PHOTO_KEY];
    id = json[ID_KEY];
    secret = json[SECRET_KEY];
    server = json[SERVER_KEY];
    farm = json[FARM_KEY];
    originalSecret = json[ORIGINAL_SECRET_KEY];
    originalFormat = json[ORIGINAL_FORMAT_KEY];
    licenseId = int.parse(json[LICENSE_ID_KEY], onError: (_) => 0);
    owner = new Owner.fromJson(json[OWNER_KEY]);
  }

  Map toJson() => {
    PHOTO_KEY: {
      ID_KEY: id,
      SECRET_KEY: secret,
      SERVER_KEY: server,
      FARM_KEY: farm,
      ORIGINAL_SECRET_KEY: originalSecret,
      ORIGINAL_FORMAT_KEY: originalFormat,
      LICENSE_ID_KEY: licenseId.toString(),
      OWNER_KEY: owner.toJson()
    }
  };

  // https://www.flickr.com/services/api/misc.urls.html
  Uri get url => new Uri.https('farm$farm.$_PHOTO_URL_BASE', '$server/${id}_${originalSecret}_o.${originalFormat}');
}

class Owner {
  String id;
  String userName;
  String realName;

  Owner.fromJson(Map json) {
    id = json[OWNER_ID_KEY];
    userName = json[USERNAME_KEY];
    realName = json[REALNAME_KEY];
  }

  Map toJson() => {
    OWNER_ID_KEY: id,
    USERNAME_KEY: userName,
    REALNAME_KEY: realName
  };

  Uri get url => new Uri.https(_OWNER_URL_BASE, 'people/$id');
}

Future<Map> get(String apiKey, String photoId) {
  var client = new base.Client(apiKey);
  return client.get(_METHOD, {
    PHOTO_ID_KEY: photoId
  });
}

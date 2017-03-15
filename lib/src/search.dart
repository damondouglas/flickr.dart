library flickr.search;

import 'dart:async';
import 'base.dart' as base;
import 'license.dart' as license;

final _METHOD = 'flickr.photos.search';
final _QUERY_TEXT_KEY = 'text';
final _MEDIA_KEY = 'media';
final _LICENSE_KEY = 'license';

final SMALL_SQUARE = 's';
final LARGE_SQUARE = 'q';
final THUMBNAIL = 't';
final SMALL_240_ON_LONGEST_SIDE = 'm';
final SMALL_320_ON_LONGEST_SIDE = 'n';
final MEDIUM_500_ON_LONGEST_SIDE = '-';
final MEDIUM_640_ON_LONGEST_SIDE = 'z';
final MEDIUM_800_ON_LONGEST_SIDE = 'c';
final LARGE_1024_ON_LONGEST_SIDE = 'b';
final LARGE_1600_ON_LONGEST_SIDE = 'h';
final LARGE_2048_ON_LONGEST_SIDE = 'k';
final ORIGINAL = 'o';

final PHOTOS = 'photos';
final PHOTO = 'photo';
final PAGE = 'page';
final PAGES = 'pages';
final NUM_PAGES = 'num_pages';
final PERPAGE = 'perpage';
final TOTAL = 'total';
final ID = 'id';
final OWNER = 'owner';
final SECRET = 'secret';
final SERVER = 'server';
final FARM = 'farm';
final TITLE = 'title';
final ENTRIES = 'entries';

const PHOTOS_ONLY = 'photos';
const VIDEOS_ONLY = 'videos';

final URL_BASE = 'staticflickr.com';

class SearchResult {
  int page;
  int numPages;
  int numPerPage;
  int total;
  List<SearchResultEntry> entries;
  SearchResult.fromJson(Map json) {
    json = json[PHOTOS];
    page = json[PAGE];
    // numPages = int.parse(json[PAGES]);
    numPages = json[PAGES];
    numPerPage = json[PERPAGE];
    total = int.parse(json[TOTAL]);
    List<Map> rawPhotoResults = json[PHOTO];
    entries = rawPhotoResults
        .map((Map photoResultData) =>
            new SearchResultEntry.fromJson(photoResultData))
        .toList(growable: false);
  }

  Map toJson() {
    return {
      PAGE: page,
      NUM_PAGES: numPages,
      PERPAGE: numPerPage,
      TOTAL: total,
      ENTRIES: entries
          .map((SearchResultEntry entry) => entry.toJson())
          .toList(growable: false)
    };
  }
}

class SearchResultEntry {
  String id;
  String owner;
  String secret;
  String server;
  int farm;
  String title;

  Uri _buildImageUriFromSize(String size) {
    return new Uri.https("farm$farm.$URL_BASE", "${server}_${id}_${size}.jpg");
  }

  Uri _buildImageUri() {
    // return new Uri.https(authority, unencodedPath)
    return null;
  }

  SearchResultEntry.fromJson(Map json) {
    id = json[ID];
    owner = json[OWNER];
    secret = json[SECRET];
    server = json[SERVER];
    farm = json[FARM];
    title = json[TITLE];
  }

  Map toJson() {
    return {
      ID: id,
      OWNER: owner,
      SECRET: secret,
      SERVER: server,
      FARM: farm,
      TITLE: title
    };
  }
}

Future<SearchResult> search(String apiKey, String query,
    {List<int> licenses: license.COMMERCIAL_ALLOWED_LICENSE_IDS,
    String media: PHOTOS_ONLY}) async {
  var client = new base.Client(apiKey);
  var params = {_QUERY_TEXT_KEY: query};
  var dataResult = await client.get(_METHOD, params);
  return new SearchResult.fromJson(dataResult);
  // return null;
}

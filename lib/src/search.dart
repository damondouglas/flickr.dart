library flickr.search;

import 'dart:async';
import 'base.dart' as base;

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

final _PHOTOS = 'photos';
final _PHOTO = 'photo';
final _PAGE = 'page';
final _PAGES = 'pages';
final _NUM_PAGES = 'num_pages';
final _PERPAGE = 'perpage';
final _TOTAL = 'total';
final _ID = 'id';
final _OWNER = 'owner';
final _SECRET = 'secret';
final _SERVER = 'server';
final _FARM = 'farm';
final _TITLE = 'title';
final _ENTRIES = 'entries';

final URL_BASE = 'staticflickr.com';

class SearchResult {
  int page;
  int numPages;
  int numPerPage;
  int total;
  List<SearchResultEntry> entries;
  SearchResult.fromJson(Map json) {
    json = json[_PHOTOS];
    page = json[_PAGE];
    numPages = int.parse(json[_PAGES]);
    numPerPage = json[_PERPAGE];
    total = int.parse(json[_TOTAL]);
    List<Map> rawPhotoResults = json[_PHOTO];
    entries = rawPhotoResults.map((Map photoResultData) => new SearchResultEntry.fromJson(photoResultData))
    .toList(growable: false);
  }

  Map toJson() {
    return {
      _PAGE : page,
      _NUM_PAGES : numPages,
      _PERPAGE : numPerPage,
      _TOTAL : total,
      _ENTRIES : entries.map((SearchResultEntry entry) => entry.toJson()).toList(growable: false)
    };
  }
}

class SearchResultEntry {
  String id;
  String owner;
  String secret;
  String server;
  String farm;
  String title;

  Uri _buildImageUriFromSize(String size) {
    return new Uri.https("farm$farm.$URL_BASE", "${server}_${id}_${size}.jpg");
  }

  Uri _buildImageUri() {
    // return new Uri.https(authority, unencodedPath)
    return null;
  }

  SearchResultEntry.fromJson(Map json) {
    id = json[_ID];
    owner = json[_OWNER];
    secret = json[_SECRET];
    server = json[_SERVER];
    farm = json[_FARM];
    title = json[_TITLE];
  }

  Map toJson() {
    return {
      _ID : id,
      _OWNER : owner,
      _SECRET : secret,
      _SERVER : server,
      _FARM : farm,
      _TITLE : title
    };
  }
}

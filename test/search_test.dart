import 'dart:async';
import 'dart:convert';
import 'common.dart';
import 'package:flickr/src/search.dart' as search;
import 'package:flickr/src/base.dart' as base;
import 'package:test/test.dart';

String PATH_DELIMITER = '.';
String USER_ID = '142142221@N02';
String USER_ID_KEY = 'user_id';

final PAGE = 1;
final PAGES = 1;
final PERPAGE = 100;
final TOTAL = 1;
final ID = "27940317290";
final OWNER = "142142221@N02";
final SECRET = "9842ee4acd";
final SERVER = "8688";
final FARM = 9;
final TITLE = "Sampson";

final SEARCH_TERM = 'cats';

void main() {
  String apiKey;
  Map result;

  group('search', () {
    base.Client client;

    setUpAll(() async {
      apiKey = getApiKey();
      client = new base.Client(apiKey);
      var params = {USER_ID_KEY: USER_ID};
      result = await client.get('flickr.photos.search', params);
    });

    group('data', () {
      String rootPath = search.PHOTOS;
      Map photosResult;
      Map root;
      int page;
      int pages;
      int perpage;
      int total;

      setUpAll(() async {
        root = result[search.PHOTOS];
        photosResult = root;
        page = root[search.PAGE];
        pages = root[search.PAGES];
        perpage = root[search.PERPAGE];
        total = int.parse(root[search.TOTAL], onError: (_) => 0);
      });

      test(search.PHOTOS, (){
        expect(photosResult, isNotEmpty);
        expect(photosResult.runtimeType, {}.runtimeType);
      });

      test(search.PAGE, (){
        expect(page, PAGE);
      });

      test(search.PAGES, (){
        expect(pages, PAGES);
      });

      test(search.PERPAGE, (){
        expect(perpage, PERPAGE);
      });

      test(search.TOTAL, (){
        expect(total, TOTAL);
      });

      group(search.PHOTO, () {
        List photoList;
        Map photo;
        String id;
        String owner;
        String secret;
        String server;
        int farm;
        String title;

        setUpAll(() {
          photoList = root[search.PHOTO];
          photo = photoList.first;

          id = photo[search.ID];
          owner = photo[search.OWNER];
          secret = photo[search.SECRET];
          server = photo[search.SERVER];
          farm = photo[search.FARM];
          title = photo[search.TITLE];
        });

        test("${search.PHOTO} is not empty", (){
          expect(photoList, isNotEmpty);
          expect(photo, isNotNull);
          expect(photo.runtimeType, {}.runtimeType);
        });

        test(search.ID, (){
          expect(id, ID);
        });

        test(search.OWNER, (){
          expect(owner, OWNER);
        });

        test(search.SECRET, (){
          expect(secret, SECRET);
        });

        test(search.SERVER, (){
          expect(server, SERVER);
        });

        test(search.FARM, (){
          expect(farm, FARM);
        });

        test(search.TITLE, (){
          expect(title, TITLE);
        });
      });
    });

    group('parsing', () {
      search.SearchResult searchResult;
      setUpAll(() {
        searchResult = new search.SearchResult.fromJson(result);
      });

      group('SearchResult', () {
        test(search.PAGE, (){
          expect(searchResult.page, PAGE);
        });

        test(search.NUM_PAGES, (){
          expect(searchResult.numPages, PAGES);
        });

        test(search.PERPAGE, (){
          expect(searchResult.numPerPage, PERPAGE);
        });

        test(search.TOTAL, (){
          expect(searchResult.total, TOTAL);
        });

        group('SearchResultEntry', () {
          List<search.SearchResultEntry> searchResultEntries;
          search.SearchResultEntry entry;
          setUpAll(() {
            searchResultEntries = searchResult.entries;
            entry = searchResultEntries.first;
          });

          test('is not empty', (){
            expect(searchResultEntries, isNotEmpty);
            expect(entry, isNotNull);
          });

          test(search.ID, (){
            expect(entry.id, ID);
          });

          test(search.OWNER, (){
            expect(entry.owner, OWNER);
          });

          test(search.SECRET, (){
            expect(entry.secret, SECRET);
          });

          test(search.SERVER, (){
            expect(entry.server, SERVER);
          });

          test(search.FARM, (){
            expect(entry.farm, FARM);
          });

          test(search.TITLE, (){
            expect(entry.title, TITLE);
          });
        });
      });
    });

    group('method default page', () {
      Map resultFromMethod;
      search.SearchResult searchResult;
      setUpAll(() async {
        resultFromMethod = await search.search(apiKey, SEARCH_TERM);
        searchResult = new search.SearchResult.fromJson(resultFromMethod);
      });

      group('parsing', () {
        group('SearchResult', () {
          test(search.PAGE, (){
            expect(searchResult.page, 1);
          });

          test(search.PAGES, () {
            expect(searchResult.numPages, isNonZero);
          });

          test(search.PERPAGE, () {
            expect(searchResult.numPerPage, isNonZero);
          });

          test(search.TOTAL, () {
            expect(searchResult.total, isNonZero);
          });

          group('SearchResultEntry', () {
            List<search.SearchResultEntry> searchResultList;
            search.SearchResultEntry entry;
            setUpAll(() {
              searchResultList = searchResult.entries;
              entry = searchResultList.first;
            });

            test('is not empty', (){
              expect(searchResultList, isNotEmpty);
              expect(entry, isNotNull);
            });

            test(search.ID, (){
              expect(entry.id.length, isNonZero);
            });

            test(search.OWNER, (){
              expect(entry.owner.length, isNonZero);
            });

            test(search.SECRET, (){
              expect(entry.secret.length, isNonZero);
            });

            test(search.SERVER, (){
              expect(entry.server.length, isNonZero);
            });

            test(search.FARM, (){
              expect(entry.farm, isNonZero);
            });

            test(search.TITLE, (){
              expect(entry.title.length, isNonZero);
            });
          });
        });
      });
    });

    group('method page 2', () {
      search.SearchResult searchResult;
      setUpAll(() async {
        var result = await search.search(apiKey, SEARCH_TERM, page: 2);
        searchResult = new search.SearchResult.fromJson(result);
      });
      test('page is 2', (){
        expect(searchResult.page, 2);
      });
    });
  });
}

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

void main() {
  String apiKey;

  group('search', () {
    base.Client client;
    setUpAll(() async {
      apiKey = getApiKey();
    });

    group('data', () {
      Map result;
      String rootPath = search.PHOTOS;
      Map photosResult;
      Map root;
      int page;
      int pages;
      int perpage;
      int total;

      setUpAll(() async {
        client = new base.Client(apiKey);
        var params = {USER_ID_KEY: USER_ID};
        result = await client.get('flickr.photos.search', params);
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
  });
}

/*
 *
 * {photos: {page: 1, pages: 1, perpage: 100, total: 1,
 * photo: [{id: 27940317290, owner: 142142221@N02, secret: 9842ee4acd, server: 8688,
 * farm: 9, title: Sampson, ispublic: 1, isfriend: 0, isfamily: 0}]}, stat: ok}
 */

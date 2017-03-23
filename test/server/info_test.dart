library info_test;

import 'package:test/test.dart';
import 'package:flickr/src/info.dart' as info;
import 'package:http/http.dart' as http;
import 'common.dart' as common;

String PHOTO_ID = '27940317290';
String SECRET = '9842ee4acd';
String SERVER = '8688';
int FARM = 9;
int LICENSE = 4;
String ORIGINAL_SECRET = '4efa0b4164';
String ORIGINAL_FORMAT = 'jpg';

String OWNER_ID = '142142221@N02';
String USER_NAME = 'cyoapp';
String REAL_NAME = 'cyoapp';
int STATUS_OK = 200;

main() {
  group('info', () {
    Map originalResult;
    Map result;
    setUpAll(() async {
      var apiKey = common.getApiKey();
      originalResult = await info.getInfo(apiKey, PHOTO_ID);
      result = originalResult[info.PHOTO_KEY];
    });

    group('parses', () {
      group('Map', () {
        test(info.ID_KEY, () {
          expect(result[info.ID_KEY], PHOTO_ID);
        });

        test(info.SECRET_KEY, () {
          expect(result[info.SECRET_KEY], SECRET);
        });

        test(info.SERVER_KEY, () {
          expect(result[info.SERVER_KEY], SERVER);
        });

        test(info.FARM_KEY, () {
          expect(result[info.FARM_KEY], FARM);
        });

        test(info.ORIGINAL_SECRET_KEY, () {
          expect(result[info.ORIGINAL_SECRET_KEY], ORIGINAL_SECRET);
        });

        test(info.ORIGINAL_FORMAT_KEY, () {
          expect(result[info.ORIGINAL_FORMAT_KEY], ORIGINAL_FORMAT);
        });

        test(info.LICENSE_ID_KEY, () {
          expect(result[info.LICENSE_ID_KEY], LICENSE.toString());
        });

        group(info.OWNER_KEY, () {
          Map ownerJson;
          setUpAll(() => ownerJson = result[info.OWNER_KEY]);
          test(info.OWNER_ID_KEY, () {
            expect(ownerJson[info.OWNER_ID_KEY], OWNER_ID);
          });

          test(info.USERNAME_KEY, () {
            expect(ownerJson[info.USERNAME_KEY], USER_NAME);
          });

          test(info.REALNAME_KEY, () {
            expect(ownerJson[info.REALNAME_KEY], REAL_NAME);
          });
        });
      });

      group('Info', () {
        info.Info infoObj;
        int urlStatusCode;

        setUpAll(() async {
          infoObj = new info.Info.fromJson(originalResult);
          var response = await http.get(infoObj.url);
          urlStatusCode = response.statusCode;
        });

        group('toJson() yields parseable', () {
          String id;
          String secret;
          String server;
          int farm;
          int license;
          String originalSecret;
          String originalFormat;
          String ownerId;
          String userName;
          String realName;

          setUpAll(() {
            var toJsonResult = infoObj.toJson();
            var infoObjFromToJson = new info.Info.fromJson(toJsonResult);

            id = infoObjFromToJson.id;
            secret = infoObjFromToJson.secret;
            server = infoObjFromToJson.server;
            farm = infoObjFromToJson.farm;
            originalSecret = infoObjFromToJson.originalSecret;
            originalFormat = infoObjFromToJson.originalFormat;
            license = infoObjFromToJson.licenseId;

            var ownerFromToJson = infoObjFromToJson.owner;

            ownerId = ownerFromToJson.id;
            userName = ownerFromToJson.userName;
            realName = ownerFromToJson.realName;
          });

          test('Info object', () {
            expect(id, PHOTO_ID);
            expect(secret, SECRET);
            expect(server, SERVER);
            expect(farm, FARM);
            expect(license, LICENSE);
            expect(originalSecret, ORIGINAL_SECRET);
            expect(originalFormat, ORIGINAL_FORMAT);
          });

          test('Owner object', () {
            expect(ownerId, OWNER_ID);
            expect(userName, USER_NAME);
            expect(realName, REAL_NAME);
          });
        });

        test(info.ID_KEY, () {
          expect(infoObj.id, PHOTO_ID);
        });

        test(info.SECRET_KEY, () {
          expect(infoObj.secret, SECRET);
        });

        test(info.SERVER_KEY, () {
          expect(infoObj.server, SERVER);
        });

        test(info.FARM_KEY, () {
          expect(infoObj.farm, FARM);
        });

        test(info.LICENSE_ID_KEY, () {
          expect(infoObj.licenseId, LICENSE);
        });

        test(info.ORIGINAL_SECRET_KEY, () {
          expect(infoObj.originalSecret, ORIGINAL_SECRET);
        });

        test(info.ORIGINAL_FORMAT_KEY, () {
          expect(infoObj.originalFormat, ORIGINAL_FORMAT);
        });

        test('original photo url', () {
          expect(urlStatusCode, STATUS_OK);
        });

        group('Owner', () {
          info.Owner owner;
          int ownerUrlStatusCode;

          // setUpAll(() => owner = infoObj.owner);
          setUpAll(() async {
            owner = infoObj.owner;
            var response = await http.get(owner.url);
            ownerUrlStatusCode = response.statusCode;
          });

          test(info.OWNER_ID_KEY, () {
            expect(owner.id, OWNER_ID);
          });

          test(info.USERNAME_KEY, () {
            expect(owner.userName, USER_NAME);
          });

          test(info.REALNAME_KEY, () {
            expect(owner.realName, REAL_NAME);
          });

          test('url', () {
            expect(ownerUrlStatusCode, STATUS_OK);
          });
        });
      });
    });
  });
}

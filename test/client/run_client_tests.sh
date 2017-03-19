echo "{\"FLICKR_SERVER\":\"$FLICKR_SERVER\"}" > test/client/config.json
pub run test -p dartium test/client/flickr_client_test.html

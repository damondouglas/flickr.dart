Before running tests:

1.  Install [ngrok](https://ngrok.com/)
2.  `$ dart test/server/server.dart`
3.  `$ ngrok http 9999`
4.  `$ export FLICKR_SERVER=<ngrok url>`
4.  `$ bash test/client/run_client_tests.sh`

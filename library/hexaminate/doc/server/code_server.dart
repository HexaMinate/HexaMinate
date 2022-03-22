import 'dart:io';

import 'package:hexaminate/hexaminate.dart';

void main(List<String> arguments) {
  var api = Server();
  api.on("/", (req, res) {

  });
  api.listen(
    host: "0.0.0.0",
    port: 8000,
    callback: (server) {
      print('Listening on http://${server.address.address}:${server.port}/');
    },
  );
}

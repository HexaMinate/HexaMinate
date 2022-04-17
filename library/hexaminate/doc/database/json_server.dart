import 'dart:io';

import 'package:hexaminate/hexaminate.dart';

void main() async {
  var pathFile = "${Directory.current.path}/db/json.json";
  await JsonDb(path_data: pathFile).set({"azka": "baru"}).write();

  JsonDb(path_data: pathFile);
}

library hexaminate;

import 'dart:async';
import 'package:http/http.dart';
import 'package:universal_io/io.dart';
import 'dart:convert';
import "dart:math";

export 'package:hexaminate/src/server.dart'
    if (dart.library.html) 'telegram_bot_api/telegram_bot_api_web.dart';

part 'src/eventemitter.dart';
part 'src/database.dart';
part 'src/fetch.dart';
part 'src/utils.dart';


//--! Extenstion 
part 'extension/string.dart';
part "extension/map.dart";
part 'extension/list.dart';
part 'extension/num.dart';
part 'extension/bool.dart';
part 'extension/dynamic.dart';
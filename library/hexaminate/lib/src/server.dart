// ignore_for_file: empty_catches, unnecessary_type_check, non_constant_identifier_names

part of hexaminate;

class Server {
  EventEmitter emitter = EventEmitter();
  List<String> paths = [];
  Server();

  void on(path, void Function(RequestApi req, ResponseApi res) callback) {
    if (!paths.contains(path)) {
      paths.add(path);
    }
    emitter.on(path.toString().toLowerCase(), null, (Event ev, context) {
      HttpRequest update = ev.eventData as HttpRequest;
      return callback(RequestApi(update), ResponseApi(update));
    });
  }

  void get(path, void Function(RequestApi req, ResponseApi res) callback) {
    if (!paths.contains(path)) {
      paths.add(path);
    }
    emitter.on(path.toString().toLowerCase(), null, (Event ev, context) {
      HttpRequest update = ev.eventData as HttpRequest;
      if (update.method.toString().toLowerCase() == "get") {
        return callback(RequestApi(update), ResponseApi(update));
      }
    });
  }

  void post(path, void Function(RequestApi req, ResponseApi res) callback) {
    if (!paths.contains(path)) {
      paths.add(path);
    }
    emitter.on(path.toString().toLowerCase(), null, (Event ev, context) {
      HttpRequest update = ev.eventData as HttpRequest;
      if (update.method.toString().toLowerCase() == "post") {
        return callback(RequestApi(update), ResponseApi(update));
      }
    });
  }

  void delete(path, void Function(RequestApi req, ResponseApi res) callback) {
    if (!paths.contains(path)) {
      paths.add(path);
    }
    emitter.on(path.toString().toLowerCase(), null, (Event ev, context) {
      HttpRequest update = ev.eventData as HttpRequest;
      if (update.method.toString().toLowerCase() == "delete") {
        return callback(RequestApi(update), ResponseApi(update));
      }
    });
  }

  void put(path, void Function(RequestApi req, ResponseApi res) callback) {
    if (!paths.contains(path)) {
      paths.add(path);
    }
    emitter.on(path.toString().toLowerCase(), null, (Event ev, context) {
      HttpRequest update = ev.eventData as HttpRequest;
      if (update.method.toString().toLowerCase() == "put") {
        return callback(RequestApi(update), ResponseApi(update));
      }
    });
  }

  void patch(path, void Function(RequestApi req, ResponseApi res) callback) {
    if (!paths.contains(path)) {
      paths.add(path);
    }
    emitter.on(path.toString().toLowerCase(), null, (Event ev, context) {
      HttpRequest update = ev.eventData as HttpRequest;
      if (update.method.toString().toLowerCase() == "patch") {
        return callback(RequestApi(update), ResponseApi(update));
      }
    });
  }

  void head(path, void Function(RequestApi req, ResponseApi res) callback) {
    if (!paths.contains(path)) {
      paths.add(path);
    }
    emitter.on(path.toString().toLowerCase(), null, (Event ev, context) {
      HttpRequest update = ev.eventData as HttpRequest;
      if (update.method.toString().toLowerCase() == "head") {
        return callback(RequestApi(update), ResponseApi(update));
      }
    });
  }

  void options(path, void Function(RequestApi req, ResponseApi res) callback) {
    if (!paths.contains(path)) {
      paths.add(path);
    }
    emitter.on(path.toString().toLowerCase(), null, (Event ev, context) {
      HttpRequest update = ev.eventData as HttpRequest;
      if (update.method.toString().toLowerCase() == "options") {
        return callback(RequestApi(update), ResponseApi(update));
      }
    });
  }

  void listen({String host = "0.0.0.0", int port = 8080, required void Function(HttpServer server) callback}) async {
    HttpServer server = await HttpServer.bind(host, port);
    callback(server);
    server.listen((HttpRequest req) async {
      req.response.headers.add(
        'Access-Control-Allow-Origin',
        '*',
        preserveHeaderCase: true,
      );
      var getPath = req.uri.toString().toLowerCase();
      bool isFoundPath = true;
      if (!paths.contains(req.uri.toString().toLowerCase())) {
        if (Regex(r"^/.*(\\)?$", "i").exec(req.uri)) {
          getPath = req.uri.toString().toLowerCase().split("?")[0];
          if (!paths.contains(getPath)) {
            var is_found = false;
            for (var i = 0; i < paths.length; i++) {
              var loop_data = paths[i];
              try {
                if (loop_data.contains(":")) {
                  Iterable<Match> get_params = RegExp(r":[a-z0-9_]+", caseSensitive: false).allMatches(loop_data);
                  var string_new = loop_data;
                  for (final Match m in get_params) {
                    String match = m[0]!;
                    string_new = string_new.replace(RegExp(match, caseSensitive: false), ".*");
                  }
                  if (RegExp(string_new, caseSensitive: false).hasMatch(getPath)) {
                    getPath = loop_data;
                    is_found = true;
                  }
                }
              } catch (e) {}
            }
            if (!is_found) {
              isFoundPath = false;
            }
          }
        } else {
          isFoundPath = false;
        }
      }

      if (isFoundPath) {
        return emitter.emit(getPath, null, req);
      } else {
        req.response.write("not found path ${req.uri}");
        return req.response.close();
      }
    });
  }
}

class RequestApi {
  late HttpRequest request;
  RequestApi(this.request);

  String get url {
    return request.uri.toString().toLowerCase();
  }

  String get method {
    return request.method.toString().toLowerCase();
  }

  get headers {
    Map json = {};
    request.headers.forEach((key, value) {
      json[key] = value;
    });
    return json;
  }

  Map get query {
    var uri = Uri.parse(request.requestedUri.toString());
    return uri.queryParameters;
  }

  Future<dynamic> get body async {
    if (method == "post") {
      Future<String> content = utf8.decodeStream(request);
      var body = await content;
      if (RegExp(r"json", caseSensitive: false).hasMatch(headers["content-type"][0])) {
        if (body is String && body.isNotEmpty) {
          try {
            return json.decode(body);
          } catch (e) {
            print(e);
            return body;
          }
        } else {
          return body;
        }
      } else {
        return body;
      }
    } else {
      return null;
    }
  }
}

class ResponseApi {
  late HttpRequest response;
  bool isFoundType = false;
  ResponseApi(this.response);

  ResponseApi code([int code = 200]) {
    response.response.statusCode = code;
    return ResponseApi(response);
  }

  ResponseApi header(String key, [var value]) {
    response.response.headers.add(key, value, preserveHeaderCase: true);
    return ResponseApi(response);
  }

  ResponseApi headers(Map header) {
    header.forEach((key, value) {
      response.response.headers.add(key, value, preserveHeaderCase: true);
    });
    return ResponseApi(response);
  }

  ResponseApi type([String type = "plain/text"]) {
    isFoundType = true;
    response.response.headers.add('Content-Type', type, preserveHeaderCase: true);
    return ResponseApi(response);
  }

  Future<dynamic> send(dynamic data, {String type = "auto"}) async {
    if (!isFoundType) {
      if (type.isNotEmpty) {
        bool is_set_data = false;
        String getType = type.toLowerCase();
        if (type == "auto") {
          if (data is Map && !is_set_data) {
            is_set_data = true;
            try {
              data = (json.encode(data));
            } catch (e) {
              print(e);
            }
            response.response.headers.contentType = ContentType.json;
          }
          if (data is List && !is_set_data) {
            is_set_data = true;
            response.response.headers.contentType = ContentType.json;
          }
          if (data is String && !is_set_data) {
            is_set_data = true;
            response.response.headers.contentType = ContentType.html;
          }
        }
        if (getType == "binary" && !is_set_data) {
          is_set_data = true;
          response.response.headers.contentType = ContentType.binary;
        }
        if (getType == "html" && !is_set_data) {
          is_set_data = true;
          response.response.headers.contentType = ContentType.html;
        }
        if (getType == "json" && !is_set_data) {
          is_set_data = true;
          if (data is Map) {
            try {
              data = (json.encode(data));
            } catch (e) {}
          }
          response.response.headers.contentType = ContentType.json;
        }
        if (getType == "text" && !is_set_data) {
          is_set_data = true;
          response.response.headers.contentType = ContentType.text;
        }
      }
    }
    response.response.write(data);
    return await response.response.close();
  }
}

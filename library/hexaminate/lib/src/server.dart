part of hexaminate;


class Server {
  EventEmitter emitter = EventEmitter();
  List paths = [];
  Server();

  void on(path, void Function(RequestApi req, ResponseApi res) callback) {
    if (!paths.contains(path)) {
      paths.add(path);
    }
    emitter.on(path.toString().toLowerCase(), null, (Event ev, context) {
      HttpRequest update = ev.eventData as HttpRequest;
      // ignore: void_checks
      return callback(RequestApi(update), ResponseApi(update));
    });
  }

  void listen(
      {String host = "0.0.0.0", int port = 8080, void Function(HttpServer server)? callback}) async {
    HttpServer server = await HttpServer.bind(host, port);
    if (callback != null) {
      callback(server);
    }
    server.listen((HttpRequest req) async {
      req.response.headers.add(
        'Access-Control-Allow-Origin',
        '*',
        preserveHeaderCase: true,
      );
      var getPath = req.uri.toString().toLowerCase();
      bool isFoundPath = true;
      if (!paths.contains(req.uri.toString().toLowerCase())) {
        // ignore: unnecessary_string_escapes
        if (RegExp("^/.*\?\$", caseSensitive: false)
            .hasMatch(req.uri.toString().toLowerCase())) {
          getPath = req.uri.toString().toLowerCase().split("?")[0];
          if (!paths.contains(getPath)) {
            isFoundPath = false;
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
      if (headers["content-type"][0] == "application/json; charset=utf-8") {
        if (getBoolean(body)) {
          try {
            return json.decode(body);
          } catch (e) {
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
    response.response.headers
        .add('Content-Type', type, preserveHeaderCase: true);
    return ResponseApi(response);
  }

  Future<dynamic> send(dynamic data, {String type = "auto"}) async {
    if (!isFoundType) {
      if (type.isNotEmpty) {
        String getType = type.toLowerCase();
        if (type == "auto") {
          if (typeof(data) == "object") {
            response.response.headers.contentType = ContentType.json;
          }
          if (typeof(data) == "array") {
            response.response.headers.contentType = ContentType.json;
          }
          if (typeof(data) == "string") {
            response.response.headers.contentType = ContentType.html;
          }
        }
        if (getType == "binary") {
          response.response.headers.contentType = ContentType.binary;
        }
        if (getType == "html") {
          response.response.headers.contentType = ContentType.html;
        }
        if (getType == "json") {
          response.response.headers.contentType = ContentType.json;
        }
        if (getType == "text") {
          response.response.headers.contentType = ContentType.text;
        }
      }
    }
    response.response.write(data);
    return await response.response.close();
  }
}

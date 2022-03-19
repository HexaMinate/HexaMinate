part of hexaminate;

class Server {
  EventEmitter emitter = EventEmitter();
  List paths = [];
  Server();
  
  void on(path, callback) {
    if (!paths.contains(path)) {
      paths.add(path);
    }
    emitter.on(path.toString().toLowerCase(), null, (Event ev, context) {
      // ignore: void_checks
      return callback(ev.eventData);
    });
  }

  void listen({String host = "0.0.0.0", int port = 8080, callback}) async {
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
}

class ResponseApi {
  late HttpRequest response;
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
    response.response.headers
        .add('Content-Type', type, preserveHeaderCase: true);
    return ResponseApi(response);
  }

  Future<dynamic> send([var data = "hello world"]) async {
    response.response.write(data);
    return await response.response.close();
  }
}
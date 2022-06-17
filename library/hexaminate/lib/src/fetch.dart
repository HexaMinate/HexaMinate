// ignore_for_file: empty_catches

part of hexaminate;

Future<FetchResponse> fetch(String url, [Map<String, dynamic>? options]) async {
  options ??= {};
  Map<String, String> headers = {};
  Object? body;
  if (options.containsKey("headers") && options["headers"] is Map) {
    try {
      headers = options["headers"];
    } catch (e) {}
  }
  if (options.containsKey("body")) {
    try {
      body = options["body"];
    } catch (e) {}
  }
  var method = "get";
  if (options.containsKey("method") && options["method"] is String) {
    method = options["method"].toString().toLowerCase();
  }
  late Response response;
  if (method == "get") {
    response = await get(Uri.parse(url), headers: headers);
  } else if (method == "post") {
    response = await post(Uri.parse(url), body: body, headers: headers);
  } else if (method == "put") {
    response = await put(Uri.parse(url), body: body, headers: headers);
  } else if (method == "patch") {
    response = await patch(Uri.parse(url), body: body, headers: headers);
  } else if (method == "delete") {
    response = await delete(Uri.parse(url), body: body, headers: headers);
  } else if (method == "head") {
    response = await head(Uri.parse(url), headers: headers);
  } else {
    response = await get(Uri.parse(url), headers: headers);
  }
  return FetchResponse(response);
}

class FetchResponse {
  late Response raw;
  FetchResponse(this.raw);

  body() {
    if (raw.headers.toString().contains("json")) {
      try {
        return json.decode(raw.body);
      } catch (e) {
        return raw.body;
      }
    } else {
      return raw.body;
    }
  }

  int get statusCode { 
    return raw.statusCode;
  }
}

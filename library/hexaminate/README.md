# Hexaminate Library

## Install

```bash
flutter pub add hexaminate
```

```bash
dart pub add hexaminate
```

## Documentation

- [Api](https://github.com/HexaMinate/HexaMinate/tree/main/library/hexaminate/doc/api)
- [Database](https://github.com/HexaMinate/HexaMinate/tree/main/library/hexaminate/doc/database)
- [Event-Emitter](https://github.com/HexaMinate/HexaMinate/tree/main/library/hexaminate/doc/event-emitter)
- [Fetch](https://github.com/HexaMinate/HexaMinate/tree/main/library/hexaminate/doc/fetch)
- [Server](https://github.com/HexaMinate/HexaMinate/tree/main/library/hexaminate/doc/server)
- [Utils](https://github.com/HexaMinate/HexaMinate/tree/main/library/hexaminate/doc/utils)

## Api


## Fetch 

quickstart:
```dart
import 'dart:convert';
import 'package:hexaminate/hexaminate.dart';
void main() async {
  FetchResponse res = await fetch("https://api.example.com", {
    "method": "post",
    "headers": {"Content-Type": "application/json"},
    "body": json.encode({"key": "value"})
  });
  print(res.body());
}
```

#### constructor
return [Fetch Response](#fetchresponse)
| No |       key       | value  | Deskripsi | `required` |
|----|:---------------:|:------:|:----------|:----------:|
| 1  |`url`|String path url| |`yes`|
| 2  | `options` |  [object]()    | <details>parameters di butuhkan jika method membutuhkannya</details> |    `no`    |
- examples
```js
fetch("https://api.example.com", {
    "method": "post",
    "headers": { 
        "Content-Type": "application/json"
    },
    "body": json.encode({
        "key": "value"
    })
});
```

### FetchResponse

#### statusCode
return status `int` from api

| No |       key       | value  | Deskripsi | `required` |
|----|:---------------:|:------:|:----------|:----------:|
  
```dart
FetchResponse res = await fetch("url");
print(res.statusCode);
```

#### body
return `Object` or `text` from api

| No |       key       | value  | Deskripsi | `required` |
|----|:---------------:|:------:|:----------|:----------:|
  
```dart
FetchResponse res = await fetch("url");
print(res.body());
```

## Server
quickstart:
```dart
import 'dart:convert';
import 'dart:io';
import 'package:hexaminate/hexaminate.dart';
void main() async {
  Server app = Server();
  app.on("/", (RequestApi req, ResponseApi res) async {
    return res.send("api normal");
  });
  app.get("/json", (RequestApi req, ResponseApi res) async {
    return res.send({"value": "json"});
  });
  app.listen(callback: (HttpServer server) {}, port: 8080, host: "0.0.0.0");
}
```

#### constructor

| No |       key       | value  | Deskripsi | `required` |
|----|:---------------:|:------:|:----------|:----------:|
- examples
```js
Server();
```

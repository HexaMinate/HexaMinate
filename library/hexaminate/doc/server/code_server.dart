import 'package:hexaminate/hexaminate.dart';

void main(List<String> arguments) {
  var api = Server();

  api.on("/baru", (update) {
    RequestApi req = RequestApi(update);
    ResponseApi res = ResponseApi(update);
    return res.send("update baru");
  });
  api.on("/azka", (update) {
    RequestApi req = RequestApi(update);
    ResponseApi res = ResponseApi(update);
    print(req.method);
    return res.send({"azka": "oke"});
  });
  api.listen(
    host: "0.0.0.0",
    port: 8000,
    callback: (server) {
      print('Listening on http://${server.address.address}:${server.port}/');
    },
  );
}

// import 'package:hexaminate/hexaminate.dart';

// void main(List<String> arguments) {
//   var api = Server();
//   api.on("/", (RequestApi req, ResponseApi res) async {
//     print(req.method);
//     print(await req.body);
//     print(req.query);
//     return res.send({"path": "root"});
//   });
//   api.on("/azka", (RequestApi req, ResponseApi res) {
//     print(req.method);
//     res.send({"Azka": "aoke"});
//   });
//   api.listen(
//     host: "0.0.0.0",
//     port: 8000,
//     callback: (server) {
//       print('Listening on http://${server.address.address}:${server.port}/');
//     },
//   );
// }

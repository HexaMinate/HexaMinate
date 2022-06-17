// ignore_for_file: non_constant_identifier_names, empty_catches

part of hexaminate;

class JsonDb {
  late String path = "${Directory.current.path}/data.json";
  late Map<dynamic, dynamic> parameters = {"@type": "", "key": "", "requests": []};
  JsonDb({String? path_data, Map? params}) {
    if (path_data != null) {
      path = path_data;
    }
    if (params != null) {
      parameters = params;
    }
  }

  JsonDb set(Object new_value) {
    if (parameters["@type"].toString().isNotEmpty) {
      parameters["requests"].add({"@type": "set", "new_data": new_value});
    } else {
      parameters["@type"] = "set";
      parameters["new_data"] = new_value;
    }
    return JsonDb(path_data: path, params: parameters);
  }

  JsonDb get(String key) {
    if (parameters["@type"].toString().isNotEmpty && parameters["@type"] != "get") {
      throw {"status_bool": false, "message": "Tolong gunakan method get sekali saja ya!"};
    }
    parameters["@type"] = "get";
    parameters["key"] = key;
    return JsonDb(path_data: path, params: parameters);
  }

  JsonDb find(old_data) {
    if (parameters["@type"] != "get") {
      throw {"status_bool": false, "message": "Tolong gunakan function get terlebih dahulu ya"};
    }
    parameters["requests"].add({"@type": "find", "old_data": old_data});
    return JsonDb(path_data: path, params: parameters);
  }

  JsonDb replace(Object old_data, Object new_data) {
    if (parameters["@type"].toString().isNotEmpty) {
      parameters["requests"].add({"@type": "replace", "old_data": old_data, "new_data": new_data});
    } else {
      parameters["@type"] = "replace";
      parameters["old_data"] = old_data;
      parameters["new_data"] = new_data;
    }

    return JsonDb(path_data: path, params: parameters);
  }

  JsonDb push(new_data) {
    if (parameters["@type"] != "get") {
      throw {"status_bool": false, "message": "Tolong gunakan function get terlebih dahulu ya"};
    }
    parameters["requests"].add({"@type": "push", "new_data": new_data});
    return JsonDb(path_data: path, params: parameters);
  }

  Map state() {
    return parameters;
  }

  Future<bool> write() async {
    if (parameters["@type"].toString().isEmpty) {
      throw {"status_bool": false, "message": "Tolong gunakan method lain dlu ya!"};
    }
    File fs = File(path);
    if (!await fs.exists()) {
      await fs.create(recursive: true);
      await fs.writeAsString(json.encode({}));
      await Future.delayed(Duration(milliseconds: 10));
    }
    Map result_data = {};
    try {
      String result = await fs.readAsString();
      result_data = json.decode(result);
    } catch (e) {}

    if (parameters["requests"].length == 0) {
      if (parameters["@type"] == "set") {
        if (typeof(parameters["new_data"]) == "object") {
          parameters["new_data"].forEach((key, value) async {
            result_data[key.toString()] = value;
          });
          await fs.writeAsString(json.encode(result_data));
          parameters = {};
          return true;
        } else {
          result_data[parameters["key"]] = parameters["new_data"];
          await fs.writeAsString(json.encode(result_data));
          parameters = {};
          return true;
        }
      }

      parameters = {};
      return false;
    }

    if (parameters["requests"].length == 1) {
      if (parameters["requests"][0]["@type"] == "find") {
        parameters = {};
        return false;
      }

      if (parameters["requests"][0]["@type"] == "push") {
        if (typeof(result_data[parameters["key"]]) == "array") {
          result_data[parameters["key"]].add(parameters["requests"][0]["new_data"]);
          await fs.writeAsString(json.encode(result_data));

          parameters = {};
          return true;
        } else {
          parameters = {};
          return false;
        }
      }

      if (parameters["requests"][0]["@type"] == "set") {
        if (typeof(parameters["requests"][0]["new_data"]) == "object") {
          parameters["requests"][0]["new_data"].forEach((key, value) async {
            result_data[key.toString()] = value;
          });
          await fs.writeAsString(json.encode(result_data));

          parameters = {};
          return true;
        } else {
          result_data[parameters["key"]] = parameters["requests"][0]["new_data"];
          await fs.writeAsString(json.encode(result_data));

          parameters = {};
          return true;
        }
      }

      if (parameters["requests"][0]["@type"] == "replace") {
        if (typeof(result_data[parameters["key"]]) == "array") {
          for (var i = 0; i < result_data[parameters["key"]].length; i++) {
            if (typeof(result_data[parameters["key"]][i]) == "object") {
              if (typeof(parameters["requests"][0]["old_data"]) == "object") {
                if (result_data[parameters["key"]][i][parameters["requests"][0]["old_data"]["id_find_key"].toString()] == parameters["requests"][0]["old_data"]["id_find_value"]) {
                  if (typeof(parameters["requests"][0]["new_data"]) == "object") {
                    parameters["requests"][0]["new_data"].forEach((key, value) async {
                      result_data[parameters["key"]][i][key.toString()] = value;
                    });
                  } else {
                    result_data[parameters["key"]][i] = parameters["requests"][0]["new_data"];
                  }
                  await fs.writeAsString(json.encode(result_data));

                  parameters = {};
                  return true;
                }
              }
            } else {
              if (result_data[parameters["key"]][i] == parameters["requests"][0]["old_data"]) {
                result_data[parameters["key"]][i] = parameters["requests"][0]["new_data"];
                await fs.writeAsString(json.encode(result_data));

                parameters = {};
                return true;
              }
            }
          }

          parameters = {};
          return false;
        }

        if (typeof(result_data[parameters["key"]]) == "object") {
          if (typeof(parameters["requests"][0]["old_data"]) == "object") {
            if (result_data[parameters["key"]][parameters["requests"][0]["old_data"]["id_find_key"].toString()] == parameters["requests"][0]["old_data"]["id_find_value"]) {
              if (typeof(parameters["requests"][0]["new_data"]) == "object") {
                parameters["requests"][0]["new_data"].forEach((key, value) async {
                  result_data[parameters["key"]][key.toString()] = value;
                });
              } else {
                result_data[parameters["key"]] = parameters["requests"][0]["new_data"];
              }
              await fs.writeAsString(json.encode(result_data));

              parameters = {};
              return true;
            }
          }
        }

        if (result_data[parameters["key"]] == parameters["requests"][0]["old_data"]) {
          result_data[parameters["key"]] = parameters["requests"][0]["new_data"];
          await fs.writeAsString(json.encode(result_data));

          parameters = {};
          return true;
        }

        parameters = {};
        return false;
      }

      var find_old_data = parameters["requests"][0]["old_data"];
      var result_data_key = result_data[parameters["key"]];
      if (typeof(find_old_data) == "object") {
        var id_find_value_res = find_old_data["id_find_value"];

        if (typeof(result_data_key) == "object") {
          var id_find_key_res = result_data_key[find_old_data["id_find_key"].toString()];

          if (id_find_key_res == id_find_value_res) {
            parameters = {};
            return id_find_key_res;
          } else {
            parameters = {};
            return false;
          }
        }

        if (typeof(result_data_key) == "array") {
          for (var i = 0; i < result_data_key.length; i++) {
            var loop_data = result_data_key[i];
            if (typeof(loop_data) == "object") {
              if (loop_data[find_old_data["id_find_key"].toString()] == id_find_value_res) {
                loop_data["index_data_JsonDb"] = i;

                parameters = {};
                return loop_data;
              }
            }
          }
        }
        parameters = {};
        return false;
      } else {
        if (Regex("(object|array)", "i").exec(typeof(result_data_key)) && result_data_key.contains(find_old_data)) {
          parameters = {};
          return find_old_data;
        } else {
          parameters = {};
          return false;
        }
      }
    }

    parameters = {};
    return true;
  }

  get read async {
    File fs = File(path);
    if (!await fs.exists()) {
      await fs.create(recursive: true);
      await fs.writeAsString(json.encode({}));
      await Future.delayed(Duration(milliseconds: 10));
    }
    Map result_data = {};
    try {
      String result = await fs.readAsString();
      result_data = json.decode(result);
    } catch (e) {}
    return result_data;
  }

  get readSync {
    File fs = File(path);
    if (!fs.existsSync()) {
      fs.createSync(recursive: true);
      fs.writeAsStringSync(json.encode({}));
      Duration(milliseconds: 10);
    }
    Map result_data = {};
    try {
      String result = fs.readAsStringSync();
      result_data = json.decode(result);
    } catch (e) {}
    return result_data;
  }

  value() async {
    if (parameters["@type"].toString().isEmpty) {
      File fs = File(path);
      if (!await fs.exists()) {
        await fs.create(recursive: true);
        await Future.delayed(Duration(milliseconds: 10));
      }
      String result = await fs.readAsString();
      if (result.isNotEmpty) {
        return json.decode(result);
      } else {
        await fs.writeAsString(json.encode({}));
        return {};
      }
    }
    if (parameters["@type"] != "get") {
      throw {"status_bool": false, "message": "Tolong gunakan function get terlebih dahulu ya"};
    }
    File fs = File(path);
    if (!await fs.exists()) {
      await fs.create(recursive: true);
      await fs.writeAsString(json.encode({}));
      await Future.delayed(Duration(milliseconds: 10));
    }
    Map result_data = {};
    try {
      String result = await fs.readAsString();
      result_data = json.decode(result);
    } catch (e) {}

    if (parameters["requests"].length == 0) {
      var dat = result_data[parameters["key"]];
      parameters = {};
      return dat;
    }

    if (parameters["requests"].length == 1) {
      if (parameters["requests"][0]["@type"] != "find") {
        parameters = {};
        return null;
      }
      var find_old_data = parameters["requests"][0]["old_data"];
      var result_data_key = result_data[parameters["key"]];
      if (typeof(find_old_data) == "object") {
        var id_find_value_res = find_old_data["id_find_value"];

        if (typeof(result_data_key) == "object") {
          var id_find_key_res = result_data_key[find_old_data["id_find_key"].toString()];

          if (id_find_key_res == id_find_value_res) {
            parameters = {};
            return id_find_key_res;
          } else {
            parameters = {};
            return null;
          }
        }

        if (typeof(result_data_key) == "array") {
          for (var i = 0; i < result_data_key.length; i++) {
            var loop_data = result_data_key[i];
            if (typeof(loop_data) == "object") {
              if (loop_data[find_old_data["id_find_key"].toString()] == id_find_value_res) {
                loop_data["index_data_JsonDb"] = i;

                parameters = {};
                return loop_data;
              }
            }
          }
        }

        parameters = {};
        return null;
      } else {
        if (result_data_key.contains(find_old_data)) {
          parameters = {};
          return find_old_data;
        } else {
          parameters = {};
          return null;
        }
      }
    }

    var result_data_key = result_data[parameters["key"]];
    List array = [];
    for (var index_loop = 0; index_loop < parameters["requests"].length; index_loop++) {
      var find_old_data = parameters["requests"][index_loop]["old_data"];
      if (typeof(find_old_data) == "object") {
        var id_find_value_res = find_old_data["id_find_value"];

        if (typeof(result_data_key) == "object") {
          var id_find_key_res = result_data_key[find_old_data["id_find_key"].toString()];

          if (id_find_key_res == id_find_value_res) {
            array.add(id_find_key_res);
          }
        }

        if (typeof(result_data_key) == "array") {
          for (var i = 0; i < result_data_key.length; i++) {
            var loop_data = result_data_key[i];
            if (typeof(loop_data) == "object") {
              if (loop_data[find_old_data["id_find_key"].toString()] == id_find_value_res) {
                loop_data["index_data_JsonDb"] = i;
                array.add(loop_data);
              }
            }
          }
        }
      } else {
        if (result_data_key.contains(find_old_data)) {
          array.add(find_old_data);
        }
      }
    }
    return array;
  }
}

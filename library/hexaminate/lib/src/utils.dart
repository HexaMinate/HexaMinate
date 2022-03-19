part of hexaminate;

String typeData(data) {
  return data.runtimeType
      .toString()
      .toLowerCase()
      .replaceAll(RegExp(r"<.*"), "")
      .replaceAll(RegExp(r"_internallinkedhashmap"), "object")
      .replaceAll(RegExp(r"_"), "")
      .replaceAll(RegExp("^list\$",caseSensitive: false), "object")
      .replaceAll(RegExp("^int\$",caseSensitive: false), "number")
      .replaceAll(RegExp("^bool\$",caseSensitive: false), "boolean");
}

String typeof(data) {
  return data.runtimeType
      .toString()
      .toLowerCase()
      .replaceAll(RegExp(r"<.*"), "")
      .replaceAll(RegExp(r"_internallinkedhashmap"), "object")
      .replaceAll(RegExp(r"_"), "")
      .replaceAll(RegExp("^list\$",caseSensitive: false), "array")
      .replaceAll(RegExp("^int\$",caseSensitive: false), "number")
      .replaceAll(RegExp("^bool\$",caseSensitive: false), "boolean");
}

bool getBoolean(data) {
  var check = typeof(data);
  if (check == "string") {
    if (data.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  } else if (check == "object") {
    if (data.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  } else if (check == "array") {
    if (data.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  } else if (check == "number") {
    if (data < 0) {
      return true;
    } else if (data.isOdd) {
      return true;
    } else {
      return false;
    }
  } else if (check == "boolean") {
    return data;
  } else {
    return false;
  }
}
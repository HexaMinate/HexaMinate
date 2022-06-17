// ignore_for_file: camel_case_types, non_constant_identifier_names

part of hexaminate;

String typeData(data) {
  return data.runtimeType.toString().toLowerCase().replaceAll(RegExp(r"<.*"), "").replaceAll(RegExp(r"_internallinkedhashmap"), "object").replaceAll(RegExp(r"_"), "").replaceAll(RegExp("^list\$", caseSensitive: false), "object").replaceAll(RegExp("^int\$", caseSensitive: false), "number").replaceAll(RegExp("^bool\$", caseSensitive: false), "boolean");
}

String typeof(data) {
  return data.runtimeType.toString().toLowerCase().replaceAll(RegExp(r"<.*"), "").replaceAll(RegExp(r"_internallinkedhashmap"), "object").replaceAll(RegExp(r"_"), "").replaceAll(RegExp(r"^list$", caseSensitive: false), "array").replaceAll(RegExp(r"^int$", caseSensitive: false), "number").replaceAll(RegExp(r"^bool$", caseSensitive: false), "boolean");
}

bool getBoolean(dynamic data) {
  if (data == null) {
    return false;
  }
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

class Regex {
  String text;
  String expression;
  Regex(this.text, this.expression);

  bool exec(input) {
    try {
      input ??= "null";
      if (typeof(input) == "number") {
        input = (input.toString());
      } else if (typeof(input) != "string") {
        input = (input.toString());
      }
      List expressionList = expression.toLowerCase().toArray;

      return RegExp(
        text,
        caseSensitive: expressionList.contains("i") ? false : true,
        multiLine: expressionList.contains("g"),
        dotAll: expressionList.contains("s"),
        unicode: expressionList.contains("u"),
      ).hasMatch(input);
    } catch (e) {
      return false;
    }
  }

  RegExp get run {
    List expressionList = expression.toLowerCase().toArray;
    return RegExp(
      text,
      caseSensitive: expressionList.contains("i") ? false : true,
      multiLine: expressionList.contains("g"),
      dotAll: expressionList.contains("s"),
      unicode: expressionList.contains("u"),
    );
  }
}

class buffer {
  static String base64 = "base64";
  static String utf8 = "utf8";
  static Encode from(String data, [String type = "utf8"]) {
    return Encode(data, type);
  }
}

class Encode {
  String text;
  String type;
  Encode(this.text, this.type);

  String toStringEncode(String type_encode) {
    if (Regex(r"^utf8$", "i").exec(type)) {
      if (Regex(r"^base64$", "i").exec(type_encode)) {
        return base64.encode(utf8.encode(text));
      }
    }
    if (Regex(r"^base64$", "i").exec(type)) {
      if (Regex(r"^utf8$", "i").exec(type_encode)) {
        return utf8.decode(base64.decode(text));
      }
    }
    return text;
  }
}

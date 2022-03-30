part of hexaminate;

String typeData(data) {
  return data.runtimeType
      .toString()
      .toLowerCase()
      .replaceAll(RegExp(r"<.*"), "")
      .replaceAll(RegExp(r"_internallinkedhashmap"), "object")
      .replaceAll(RegExp(r"_"), "")
      .replaceAll(RegExp("^list\$", caseSensitive: false), "object")
      .replaceAll(RegExp("^int\$", caseSensitive: false), "number")
      .replaceAll(RegExp("^bool\$", caseSensitive: false), "boolean");
}

String typeof(data) {
  return data.runtimeType
      .toString()
      .toLowerCase()
      .replaceAll(RegExp(r"<.*"), "")
      .replaceAll(RegExp(r"_internallinkedhashmap"), "object")
      .replaceAll(RegExp(r"_"), "")
      .replaceAll(RegExp("^list\$", caseSensitive: false), "array")
      .replaceAll(RegExp("^int\$", caseSensitive: false), "number")
      .replaceAll(RegExp("^bool\$", caseSensitive: false), "boolean");
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

  RegExp get run{
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

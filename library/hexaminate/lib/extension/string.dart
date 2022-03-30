// ignore_for_file: non_constant_identifier_names

part of hexaminate;

/*
*
*
*
*/

extension StringEncodeDecodeExtension on String? {}

extension StringIstypeExtension on String {
  get isType {
    return runtimeType
        .toString()
        .toLowerCase()
        .replaceAll(RegExp(r"<.*"), "")
        .replaceAll(RegExp(r"_internallinkedhashmap"), "object")
        .replaceAll(RegExp(r"_"), "");
  }

  String replace(RegExp regex, String new_string) {
    return replaceAll(regex, new_string);
  }

  bool isUpperCase() {
    return (toUpperCase() == this);
  }

  bool isLowerCase() {
    return (toLowerCase() == this);
  }

  String repeat(int count, {String? new_string}) {
    if (new_string != null) {
      String _message = this;
      for (var i = 0; i < count; i++) {
        _message += new_string + this;
      }
      return _message;
    }
    return this * count;
  }

  List<String> get toArray {
    List<String> array = [];
    for (var i = 0; i < length; i++) {
      array.add(this[i]);
    }
    return array;
  }

  Map<String, String> get toJson {
    Map<String, String> data = {};
    for (var i = 0; i < length; i++) {
      data[i.toString()] = this[i].toString();
    }
    return data;
  }

  List toEntities() {
    List array = [];
    for (var i = 0; i < length; i++) {
      
    }
    return split(" ");
  }
}

extension StringToIntExtension on String {
  /// Parses the string as an [int] number and returns the result.
  ///
  /// The [radix] must be in the range 2..36. The digits used are
  /// first the decimal digits 0..9, and then the letters 'a'..'z' with
  /// values 10 through 35. Also accepts upper-case letters with the same
  /// values as the lower-case ones.
  ///
  /// If no [radix] is given then it defaults to 10.
  toInt({int? radix}) {
    try {
      return int.parse(this, radix: radix);
    } catch (e) {
      return int;
    }
  }
}

extension ToBooleanExtension on String? {
  bool get toBoolean {
    if (this!.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}

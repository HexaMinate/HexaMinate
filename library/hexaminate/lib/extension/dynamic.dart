part of hexaminate;


extension DynamicUtilsTypeExntension on dynamic {
  String get type {
    return typeof(this);
  }

  bool get toBoolean {
    if (this == null) {
      return false;
    }
    return getBoolean(this);
  }
}

extension NullableTypeExntensiont on Null {
  String get type {
    return typeof(this);
  }

  bool get toBoolean {
    return false;
  }
}
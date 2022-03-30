part of hexaminate;

extension EncodeDecode<A, V> on Map<A, V> {}

extension Loop<K, V> on Map<K, V> {
  void loop(void Function(K key, V value, int index) callback) {
    var i = 0;
    forEach((key, value) {
      callback(key, value, i);
      i++;
    });
  }
}



extension IsType<K, V> on Map<K, V> {
  get isType {
    return runtimeType
        .toString()
        .toLowerCase()
        .replaceAll(RegExp(r"<.*"), "")
        .replaceAll(RegExp(r"_internallinkedhashmap"), "object")
        .replaceAll(RegExp(r"_"), "");
  }
}

extension ToBoolean<K, V> on Map<K, V> {
  bool get toBoolean {
    return isNotEmpty;
  }
}

part of hexaminate;

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

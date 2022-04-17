// ignore_for_file: non_constant_identifier_names

part of hexaminate;

extension ListLoopExtension<T> on List<T> {
  void loop(void Function(T value, int index) callback) {
    for (var i = 0; i < length; i++) {
      callback(this[i], i);
    }
  }

  List<T> slice(int index) {
    removeAt(index);
    return this;
  }

  T random() {
    return this[Random().nextInt(length)];
  }

  void push(dynamic value) {
    add(value);
  }
}

extension ListIsTypeExtension<E> on List<E> {
  get isType {
    return runtimeType
        .toString()
        .toLowerCase()
        .replaceAll(RegExp(r"<.*"), "")
        .replaceAll(RegExp(r"_internallinkedhashmap"), "object")
        .replaceAll(RegExp(r"_"), "");
  }
}

abstract interface class JavaEnum {
  String get javaName;
}

extension JavaEnumLookup<T extends JavaEnum> on Iterable<T> {
  T getByJavaName(String javaName) {
    for (var value in this) {
      if (value.javaName == javaName) return value;
    }
    throw ArgumentError.value(
        javaName, "javaName", "No enum value with that javaName");
  }
}

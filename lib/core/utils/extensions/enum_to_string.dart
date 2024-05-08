extension ParseToString<T extends Enum> on T {
  String toShortString() {
    return toString().split('.').last;
  }
}
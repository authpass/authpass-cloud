extension ObjectExt<T> on T {
  T? takeIf(bool Function(T that) predicate) => predicate(this) ? this : null;
  R let<R>(R Function(T that) op) => op(this);
}

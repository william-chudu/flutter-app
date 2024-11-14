extension ListExtention<T> on List<T> {
  List<T> separator(T item) {
    final newList = List<T>.empty(growable: true);
    for (int i = 0; i < length; i++) {
      if (i > 0) {
        newList.add(item);
      }
      newList.add(this[i]);
    }
    return newList;
  }
}

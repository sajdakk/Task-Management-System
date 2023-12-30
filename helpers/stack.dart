class Stack<T> {
  final List<T> _items = [];

  void push(T item) {
    _items.add(item);
  }

  T pop() {
    if (_items.isNotEmpty) {
      return _items.removeLast();
    }
    throw StateError('Cannot pop from an empty stack.');
  }

  T peek() {
    if (_items.isNotEmpty) {
      return _items.last;
    }
    throw StateError('Cannot peek an empty stack.');
  }

  bool get isEmpty => _items.isEmpty;

  bool get isNotEmpty => _items.isNotEmpty;

  int get length => _items.length;

  void clear() {
    _items.clear();
  }
}

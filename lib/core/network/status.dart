class Status<T, E> {
  final T? _data;
  final E? _error;

  Status.success(this._data) : _error = null;
  Status.error(this._error) : _data = null;

  T get data {
    if (_data == null) {
      throw Exception("Using 'Status.get => _data' on 'null' _data value.");
    }
    return _data;
  }

  E get error {
    if (_error == null) {
      throw Exception("Using 'Status.get => _data' on 'null' _error value.");
    }
    return _error;
  }

  bool get isSuccess => _data != null;
  bool get isError => _error != null;
}

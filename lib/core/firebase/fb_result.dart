sealed class FbResult<T> {}

class Success<T> extends FbResult<T> {
  T? data;
  Success({this.data});
}

class Failure<T> extends FbResult<T> {
  String errorMsg;
  Failure({required this.errorMsg});
}

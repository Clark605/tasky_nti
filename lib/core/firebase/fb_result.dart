// ignore_for_file: public_member_api_docs, sort_constructors_first
sealed class FbResult<T> {}

class Succces<T> extends FbResult<T> {
  T? data;
  Succces({this.data});
}

class Faluire extends FbResult {
  String errorMsg;
  Faluire({required this.errorMsg});
}

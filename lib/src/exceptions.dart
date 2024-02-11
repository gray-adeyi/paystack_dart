class BaseException implements Exception {
  final String message;

  BaseException(this.message);

  @override
  String toString() {
    return '$runtimeType: $message';
  }
}

class MissingSecretKeyException extends BaseException {
  MissingSecretKeyException(super.message);
}

class UnsupportedHttpMethodException extends BaseException {
  UnsupportedHttpMethodException(super.message);
}

class ApiException extends BaseException {
  ApiException(super.message);
}

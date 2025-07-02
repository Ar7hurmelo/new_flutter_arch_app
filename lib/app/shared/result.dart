sealed class Result<TSuccess, TFailure> {
  TSuccess? getOrNull() {
    if (this is Success<TSuccess, TFailure>) {
      return (this as Success<TSuccess, TFailure>)._value;
    }
    return null;
  }

  TFailure? getErrorOrNull() {
    if (this is Failure<TSuccess, TFailure>) {
      return (this as Failure<TSuccess, TFailure>)._value;
    }
    return null;
  }

  T fold<T>(T Function(TSuccess) onSuccess, T Function(TFailure) onFailure) {
    if (this is Success) {
      return onSuccess((this as Success)._value);
    } //else if (this is Failure) {
    else {
      return onFailure((this as Failure)._value);
    }
    //throw Exception('Invalid Result type');
  }
}

class Success<TSucces, TFailure> extends Result<TSucces, TFailure> {
  final TSucces _value;

  Success(this._value);
}

class Failure<TSucces, TFailure> extends Result<TSucces, TFailure> {
  final TFailure _value;

  Failure(this._value);
}

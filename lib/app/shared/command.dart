import 'package:flutter/material.dart';

import 'result.dart';

abstract class Command<TSuccess, TFailure> extends ChangeNotifier {
  bool _isExecuting = false;
  bool get isExecuting => _isExecuting;

  Result<TSuccess, TFailure>? _result;

  bool get isSuccess => _result is Success;
  bool get isFailure => _result is Failure;

  Future<void> _execute(
    Future<Result<TSuccess, TFailure>> Function() action,
  ) async {
    if (_isExecuting) {
      return; // Prevent re-entrance if already executing
    }

    _isExecuting = true;
    notifyListeners();

    _result = await action();

    _isExecuting = false;
    notifyListeners();
  }
}

class Command0<TSuccess, TFailure> extends Command<TSuccess, TFailure> {
  final Future<Result<TSuccess, TFailure>> Function() _action;

  Command0(this._action);

  Future<void> execute() async {
    await _execute(_action);
  }
}

class Command1<TSuccess, TFailure, TParam> extends Command<TSuccess, TFailure> {
  final Future<Result<TSuccess, TFailure>> Function(TParam) _action;

  Command1(this._action);

  Future<void> execute(TParam param) async {
    await _execute(() => _action(param));
  }
}

import 'dart:async';

import 'package:logging/logging.dart';

abstract class AsyncUseCase<T, Params> {
  Logger _logger;
  Logger get logger => _logger;

  UseCase() {
    _logger = Logger(this.runtimeType.toString());
  }

  /// Builds the [Future]. [Params] is required
  /// by the [UseCase] to retrieve the appropraite data from the repository
  Future<T> buildUseCase(Params params);

  Future<T> execute([Params params]) async {
    return await buildUseCase(params);
  }
}

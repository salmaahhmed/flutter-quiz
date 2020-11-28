import '../index.dart';

abstract class AsyncCompletableUseCase<Params>
    extends AsyncUseCase<void, Params> {
  Future<void> buildUseCase(Params params);
}

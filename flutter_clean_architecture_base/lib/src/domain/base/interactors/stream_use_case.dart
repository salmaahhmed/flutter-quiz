abstract class StreamUseCase<T, Params> {
  Stream<T> buildUseCase(Params params);
}

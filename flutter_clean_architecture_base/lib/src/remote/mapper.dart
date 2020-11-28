abstract class RemoteMapper<M, E> {
  E mapFromRemote(M type);
  Future<M> mapToRemote(E type);
}

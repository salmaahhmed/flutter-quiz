///
///Interface for model mappers. It provides helper methods that facilitate
///retrieving of models from outer data source layers
///
///@param <E> the cached model input type
///@param <E> the remote model input type
///@param <D> the model return type
///
abstract class Mapper<E, D> {
  D mapFromEntity(E type);
  E mapToEntity(D type);
}

import '../domain_index.dart';

abstract class TriviaCategoryRepository {
  Future<List<TriviaCategoryEntity>> getTriviaCategories();
}

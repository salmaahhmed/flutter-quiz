import '../../data.dart';

abstract class CategoryRemoteDataSource {
  Future<List<TriviaCategoryModel>> getTriviaCategories();
}

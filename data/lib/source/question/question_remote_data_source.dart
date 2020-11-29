import '../../data.dart';

abstract class QuestionRemoteDataSource {
  Future<List<QuestionModel>> getTriviaQuestions(
      TriviaCategoryModel categoryModel);
}

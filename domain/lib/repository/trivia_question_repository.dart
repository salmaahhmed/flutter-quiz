import '../domain_index.dart';

abstract class TriviaQuestionRepository {
  Future<List<QuestionEntity>> getTriviaCategoryQuestions(
      TriviaCategoryEntity entity);
}

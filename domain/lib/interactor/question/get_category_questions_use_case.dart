import 'package:clean_architecture_base/clean_architecture_base.dart';

import '../../domain_index.dart';

class GetCategoryQuestionsUseCase
    extends AsyncUseCase<List<QuestionEntity>, TriviaCategoryEntity> {
  final TriviaQuestionRepository _triviaQuestionRepository;

  GetCategoryQuestionsUseCase(this._triviaQuestionRepository);

  @override
  Future<List<QuestionEntity>> buildUseCase(TriviaCategoryEntity params) async {
    return await _triviaQuestionRepository.getTriviaCategoryQuestions(params);
  }
}

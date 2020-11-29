import 'package:domain/domain_index.dart';

import '../data.dart';

class QuestionRepositoryImpl extends TriviaQuestionRepository {
  final QuestionRemoteDataSource _remoteDataSource;
  final QuestionMapper _questionMapper;
  final CategoryMapper _categoryMapper;

  QuestionRepositoryImpl(
      this._remoteDataSource, this._questionMapper, this._categoryMapper);

  @override
  Future<List<QuestionEntity>> getTriviaCategoryQuestions(
      TriviaCategoryEntity entity) async {
    return (await _remoteDataSource
            .getTriviaQuestions(_categoryMapper.mapFromEntity(entity)))
        ?.map((c) => _questionMapper.mapToEntity(c))
        ?.toList();
  }
}

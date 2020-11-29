import 'package:clean_architecture_base/clean_architecture_base.dart';
import 'package:domain/domain_index.dart';

import '../data.dart';

class QuestionMapper extends Mapper<QuestionEntity, QuestionModel> {
  @override
  QuestionEntity mapToEntity(QuestionModel type) {
    return (type == null)
        ? null
        : QuestionEntity(
            category: type.category,
            type: type.type,
            difficulty: type.difficulty,
            question: type.question,
            correctAnswer: type.correctAnswer,
            incorrectAnswers: type.incorrectAnswers);
  }

  @override
  QuestionModel mapFromEntity(QuestionEntity type) {
    return (type == null)
        ? null
        : QuestionModel(
            category: type.category,
            type: type.type,
            difficulty: type.difficulty,
            question: type.question,
            correctAnswer: type.correctAnswer,
            incorrectAnswers: type.incorrectAnswers);
  }
}

import 'package:clean_architecture_base/clean_architecture_base.dart';
import 'package:data/data.dart';
import '../remote.dart';

class QuestionMapperRemote extends RemoteMapper<QuestionRemote, QuestionModel> {
  @override
  QuestionModel mapFromRemote(QuestionRemote type) {
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

  @override
  Future<QuestionRemote> mapToRemote(QuestionModel type) async {
    return (type == null)
        ? null
        : QuestionRemote(
            category: type.category,
            type: type.type,
            difficulty: type.difficulty,
            question: type.question,
            correctAnswer: type.correctAnswer,
            incorrectAnswers: type.incorrectAnswers);
  }
}

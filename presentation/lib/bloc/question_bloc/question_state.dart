import 'package:clean_architecture_base/clean_architecture_base.dart';
import 'package:domain/domain_index.dart';
import 'package:meta/meta.dart';

@immutable
abstract class QuestionState extends BlocStateBase {
  QuestionState([Iterable props]);
  QuestionState getStateCopy();
}

class GetQuestionsLoading extends QuestionState {
  @override
  String toString() => 'GetQuestionsLoading';

  @override
  QuestionState getStateCopy() {
    return GetQuestionsLoading();
  }

  @override
  List<Object> get props => [];
}

class GetQuestionsSuccess extends QuestionState {
  final List<QuestionEntity> questionLs;

  GetQuestionsSuccess(this.questionLs) : super([questionLs]);

  @override
  String toString() => 'GetQuestionsSuccess Length: ${questionLs.length}';

  @override
  GetQuestionsSuccess getStateCopy() {
    return GetQuestionsSuccess(questionLs);
  }

  @override
  List<Object> get props => [questionLs];
}

class GetQuestionsFail extends QuestionState {
  final String error;

  GetQuestionsFail(this.error) : super([error]);

  @override
  String toString() => 'GetQuestionsFail error: ${error}';

  @override
  GetQuestionsFail getStateCopy() {
    return GetQuestionsFail(error);
  }

  @override
  List<Object> get props => [error];
}

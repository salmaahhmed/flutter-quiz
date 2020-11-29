import 'package:clean_architecture_base/clean_architecture_base.dart';

import '../../presentation_index.dart';

abstract class QuestionEvent
    extends BlocEventBase<QuestionBloc, QuestionState> {}

class GetQuestionEvent extends QuestionEvent {
  final TriviaCategoryEntity categoryEntity;

  GetQuestionEvent(this.categoryEntity);

  @override
  String toString() => 'LoadCreateEQuestionEvent';
  @override
  Stream<QuestionState> apply(
      {QuestionState currentState, QuestionBloc bloc}) async* {
    yield GetQuestionsLoading();
    try {
      final categoryLs =
          await bloc.getCategoryQuestionsUseCase.execute(categoryEntity);
      if (categoryLs != null) {
        yield GetQuestionsSuccess(categoryLs);
      } else {
        yield GetQuestionsFail('Category list is empty');
      }
    } catch (_, stackTrace) {
      yield GetQuestionsFail(_?.toString());
    }
  }

  @override
  List<Object> get props => [];
}

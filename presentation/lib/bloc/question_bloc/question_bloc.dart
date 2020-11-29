import 'dart:async';

import 'package:clean_architecture_base/clean_architecture_base.dart';
import 'package:presentation/presentation_index.dart';

class QuestionBloc extends Bloc<QuestionEvent, QuestionState> {
  final GetCategoryQuestionsUseCase getCategoryQuestionsUseCase;

  QuestionBloc(
    this.getCategoryQuestionsUseCase,
  );

  final BehaviorSubject<int> _currentQuestionIndexController =
      BehaviorSubject<int>.seeded(0);
  Stream<int> get currentQuestionIndexStream =>
      _currentQuestionIndexController.stream;
  void changeQuestionIndex(final int index) =>
      _currentQuestionIndexController.sink.add(index);

  final StreamController<int> _scoreController = StreamController<int>();
  Stream<int> get currentScore => _scoreController.stream;
  void updateScore(final int index) => _scoreController.sink.add(index);

  @override
  QuestionState get initialState => GetQuestionsLoading();

  @override
  Stream<QuestionState> mapEventToState(QuestionEvent event) async* {
    try {
      yield* event.apply(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      print('$_ $stackTrace');
      yield state;
    }
  }

  void dispose() {
    _currentQuestionIndexController?.close();
  }
}

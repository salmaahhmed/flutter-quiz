import 'package:clean_architecture_base/clean_architecture_base.dart';

import '../../presentation_index.dart';

abstract class CategoryEvent
    extends BlocEventBase<CategoryBloc, CategoryState> {}

class GetCategoryEvent extends CategoryEvent {
  @override
  String toString() => 'LoadCreateECategoryEvent';
  @override
  Stream<CategoryState> apply(
      {CategoryState currentState, CategoryBloc bloc}) async* {
    yield GetCategoryLoading();
    try {
      final categoryLs = await bloc.getCategoriesUseCase.execute();
      if (categoryLs != null) {
        yield GetCategorySuccess(categoryLs);
      } else {
        yield GetCategoryFail('Category list is empty');
      }
    } catch (_, stackTrace) {
      yield GetCategoryFail(_?.toString());
    }
  }

  @override
  List<Object> get props => [];
}

import 'package:clean_architecture_base/clean_architecture_base.dart';
import 'package:presentation/presentation_index.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetCategoriesUseCase getCategoriesUseCase;

  CategoryBloc(
    this.getCategoriesUseCase,
  );

  @override
  CategoryState get initialState => GetCategoryLoading();

  @override
  Stream<CategoryState> mapEventToState(CategoryEvent event) async* {
    try {
      yield* event.apply(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      print('$_ $stackTrace');
      yield state;
    }
  }
}

import 'package:clean_architecture_base/clean_architecture_base.dart';
import 'package:domain/domain_index.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CategoryState extends BlocStateBase {
  CategoryState([Iterable props]);
  CategoryState getStateCopy();
}

class GetCategoryLoading extends CategoryState {
  @override
  String toString() => 'GetCategoryLoading';

  @override
  CategoryState getStateCopy() {
    return GetCategoryLoading();
  }

  @override
  List<Object> get props => [];
}

class GetCategorySuccess extends CategoryState {
  final List<TriviaCategoryEntity> categoryLs;

  GetCategorySuccess(this.categoryLs) : super([categoryLs]);

  @override
  String toString() => 'GetCategorySuccess Length: ${categoryLs.length}';

  @override
  GetCategorySuccess getStateCopy() {
    return GetCategorySuccess(categoryLs);
  }

  @override
  List<Object> get props => [categoryLs];
}

class GetCategoryFail extends CategoryState {
  final String error;

  GetCategoryFail(this.error) : super([error]);

  @override
  String toString() => 'GetCategoryFail error: ${error}';

  @override
  GetCategoryFail getStateCopy() {
    return GetCategoryFail(error);
  }

  @override
  List<Object> get props => [error];
}

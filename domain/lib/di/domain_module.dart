import 'package:clean_architecture_base/clean_architecture_base.dart';

import '../domain_index.dart';

class DomainModule extends Module {
  @override
  void configure(GetIt get) => get
    ..registerFactory(
        () => GetCategoriesUseCase(get<TriviaCategoryRepository>()))
    ..registerFactory(() => GetCategoryQuestionsUseCase(get()));
}

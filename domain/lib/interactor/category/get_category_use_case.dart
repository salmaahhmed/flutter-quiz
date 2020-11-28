import 'package:clean_architecture_base/clean_architecture_base.dart';

import '../../domain_index.dart';

class GetCategoriesUseCase
    extends AsyncUseCase<List<TriviaCategoryEntity>, void> {
  final TriviaCategoryRepository _triviaCategoryRepository;

  GetCategoriesUseCase(this._triviaCategoryRepository);

  @override
  Future<List<TriviaCategoryEntity>> buildUseCase(void params) async {
    return await _triviaCategoryRepository.getTriviaCategories();
  }
}

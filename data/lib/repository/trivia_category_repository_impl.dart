import 'package:domain/domain_index.dart';

import '../data.dart';

class CategoryRepositoryImp extends TriviaCategoryRepository {
  final CategoryRemoteDataSource _remoteDataSource;
  final CategoryMapper _categoryMapper;

  CategoryRepositoryImp(this._remoteDataSource, this._categoryMapper);

  @override
  Future<List<TriviaCategoryEntity>> getTriviaCategories() async {
    return (await _remoteDataSource.getTriviaCategories())
        ?.map((c) => _categoryMapper.mapToEntity(c))
        ?.toList();
  }
}

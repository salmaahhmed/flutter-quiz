import 'package:clean_architecture_base/clean_architecture_base.dart';
import 'package:data/data.dart';
import 'package:domain/domain_index.dart';

class DataModule extends Module {
  @override
  void configure(GetIt get) => get
    ..registerFactory<TriviaCategoryRepository>(
        () => CategoryRepositoryImp(get(), CategoryMapper()));
}

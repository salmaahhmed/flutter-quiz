import 'package:clean_architecture_base/clean_architecture_base.dart';
import 'package:data/data.dart';
import '../remote.dart';

class RemoteModule extends Module {
  @override
  void configure(GetIt get) => get
    ..registerFactory<CategoryRemoteDataSource>(
        () => CategoriesRemoteDataSourceImpl(CategoryRemoteMapper()))
    ..registerFactory<QuestionRemoteDataSource>(
        () => QuestionsRemoteDataSourceImpl(QuestionMapperRemote()));
}

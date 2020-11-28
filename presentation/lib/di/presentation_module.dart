import 'package:clean_architecture_base/clean_architecture_base.dart';
import 'package:presentation/presentation_index.dart';

class PresentationModule extends Module {
  @override
  void configure(GetIt get) => get..registerFactory(() => CategoryBloc(get()));
}
